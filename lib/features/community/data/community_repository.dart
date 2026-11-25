import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';
import '../../../database/database.dart';
import '../../../database/fitness_repository.dart';
import '../../run_tracking/domain/gps_filter.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CommunityRepository(db);
});

class FeedPostView {
  final CommunityPost post;
  final int likeCount;
  final bool isLikedByMe;
  final int commentCount;

  const FeedPostView({
    required this.post,
    required this.likeCount,
    required this.isLikedByMe,
    required this.commentCount,
  });
}

class CommunityRepository {
  final AppDatabase db;
  Future<void>? _seedFuture;
  String _activeUserId = 'local_user_1';
  String _activeUserName = 'You';

  CommunityRepository(this.db);

  String get currentUserId {
    if (SupabaseConfig.isConfigured) {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid != null) return uid;
    }
    return _activeUserId;
  }

  String get currentUserName => _activeUserName;

  /// Switch active local profile for testing / offline multi-account verification
  /// when Supabase keys are not yet configured.
  void setLocalActiveUser({required String id, required String name}) {
    _activeUserId = id;
    _activeUserName = name;
  }

  Future<void> ensureSeeded() => _seedFuture ??= _seed();

  Future<void> _seed() async {
    final existingChallenges = await db.select(db.communityChallenges).get();
    if (existingChallenges.isEmpty) {
      await db.batch((b) {
        b.insertAll(
          db.communityChallenges,
          const [
            CommunityChallengesCompanion(
              id: Value('ch_5k_daily'),
              title: Value('5 km Daily Challenge'),
              targetKm: Value(5.0),
              durationDays: Value(1),
              challengeType: Value('daily'),
              participantCount: Value(1),
              isJoined: Value(true),
            ),
            CommunityChallengesCompanion(
              id: Value('ch_30k_weekly'),
              title: Value('30 km Weekly Challenge'),
              targetKm: Value(30.0),
              durationDays: Value(7),
              challengeType: Value('weekly'),
              participantCount: Value(1),
              isJoined: Value(false),
            ),
            CommunityChallengesCompanion(
              id: Value('ch_100k_monthly'),
              title: Value('100 km Monthly Challenge'),
              targetKm: Value(100.0),
              durationDays: Value(30),
              challengeType: Value('monthly'),
              participantCount: Value(1),
              isJoined: Value(false),
            ),
          ],
          mode: InsertMode.insertOrIgnore,
        );
      });
    }

    await db.into(db.communityProfiles).insertOnConflictUpdate(
          CommunityProfilesCompanion(
            id: Value(_activeUserId),
            username: Value(_activeUserId),
            displayName: Value(_activeUserName),
            dailyGoalKm: const Value(5.0),
          ),
        );
  }

  /// Trims first/last [trimMeters] from a polyline so home/work start & end
  /// coordinates are never exposed in public Community posts.
  static List<TrackedPoint> applyGpsPrivacyTrim(
    List<TrackedPoint> points, {
    double trimMeters = 150.0,
  }) {
    if (points.length <= 4) return points;
    int startIdx = 0;
    double accStart = 0.0;
    for (int i = 1; i < points.length - 2; i++) {
      accStart += GpsFilter.haversineDistanceMeters(
        points[i - 1].lat,
        points[i - 1].lng,
        points[i].lat,
        points[i].lng,
      );
      if (accStart >= trimMeters) {
        startIdx = i;
        break;
      }
    }

    int endIdx = points.length - 1;
    double accEnd = 0.0;
    for (int i = points.length - 2; i > startIdx + 1; i--) {
      accEnd += GpsFilter.haversineDistanceMeters(
        points[i + 1].lat,
        points[i + 1].lng,
        points[i].lat,
        points[i].lng,
      );
      if (accEnd >= trimMeters) {
        endIdx = i;
        break;
      }
    }

    if (endIdx <= startIdx) return points;
    return points.sublist(startIdx, endIdx + 1);
  }

  Stream<List<CommunityProfile>> watchGoalAchievers() async* {
    await ensureSeeded();
    yield* (db.select(db.communityProfiles)
          ..where((p) => p.isPrivate.equals(false) | p.id.equals(currentUserId)))
        .watch();
  }

  Stream<List<FeedPostView>> watchFeed({String query = ''}) async* {
    await ensureSeeded();
    final trimmed = query.trim().toLowerCase();
    yield* (db.select(db.communityPosts)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAtMs)]))
        .watch()
        .asyncMap((posts) async {
      final blocks = await (db.select(db.blockedUsers)
            ..where((b) => b.blockerId.equals(currentUserId)))
          .get();
      final blockedIds = blocks.map((b) => b.blockedId).toSet();

      final result = <FeedPostView>[];
      for (final p in posts) {
        if (blockedIds.contains(p.userId)) continue;
        if (p.visibility == 'private' && p.userId != currentUserId) continue;
        if (trimmed.isNotEmpty &&
            !p.title.toLowerCase().contains(trimmed) &&
            !p.authorName.toLowerCase().contains(trimmed)) {
          continue;
        }

        final likes = await (db.select(db.communityPostLikes)
              ..where((l) => l.postId.equals(p.id)))
            .get();
        final comments = await (db.select(db.communityComments)
              ..where((c) => c.postId.equals(p.id)))
            .get();

        result.add(
          FeedPostView(
            post: p,
            likeCount: likes.length,
            isLikedByMe: likes.any((l) => l.userId == currentUserId),
            commentCount: comments.length,
          ),
        );
      }
      return result;
    });
  }

  Future<String> publishRunPost({
    required String title,
    required double distanceKm,
    required int durationSec,
    String? polylineJson,
    String? workoutBadge,
    String visibility = 'public',
    bool trimGpsEndpoints = true,
  }) async {
    await ensureSeeded();
    String? safePolyline = polylineJson;
    if (trimGpsEndpoints && polylineJson != null) {
      final pts = GpsFilter.decodePolyline(polylineJson);
      if (pts.isNotEmpty) {
        safePolyline = GpsFilter.encodePolyline(applyGpsPrivacyTrim(pts));
      }
    }

    final pace = GpsFilter.formatPacePerKm(
      distanceMeters: distanceKm * 1000.0,
      durationSeconds: durationSec,
    );
    final id = 'post_${DateTime.now().microsecondsSinceEpoch}';
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    await db.into(db.communityPosts).insertOnConflictUpdate(
          CommunityPostsCompanion(
            id: Value(id),
            userId: Value(currentUserId),
            authorName: Value(currentUserName),
            title: Value(title.trim()),
            distanceKm: Value(distanceKm),
            durationSec: Value(durationSec),
            paceLabel: Value(pace),
            polylineJson: Value(safePolyline),
            workoutBadge: Value(workoutBadge),
            visibility: Value(visibility),
            createdAtMs: Value(nowMs),
          ),
        );

    final prof = await (db.select(db.communityProfiles)
          ..where((p) => p.id.equals(currentUserId)))
        .getSingleOrNull();
    await db.into(db.communityProfiles).insertOnConflictUpdate(
          CommunityProfilesCompanion(
            id: Value(currentUserId),
            username: Value(currentUserId),
            displayName: Value(currentUserName),
            todayDistanceKm:
                Value((prof?.todayDistanceKm ?? 0.0) + distanceKm),
          ),
        );

    if (SupabaseConfig.isConfigured) {
      try {
        await Supabase.instance.client.from('run_posts').insert({
          'id': id,
          'user_id': currentUserId,
          'title': title.trim(),
          'distance_km': distanceKm,
          'duration_sec': durationSec,
          'pace_label': pace,
          'polyline_json': safePolyline,
          'workout_badge': workoutBadge,
          'visibility': visibility,
        });
      } catch (_) {
        // Offline cache retained cleanly; syncs on next online session
      }
    }
    return id;
  }

  Future<void> toggleLike(String postId) async {
    await ensureSeeded();
    final existing = await (db.select(db.communityPostLikes)
          ..where((l) =>
              l.postId.equals(postId) & l.userId.equals(currentUserId)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.delete(db.communityPostLikes)
            ..where((l) =>
                l.postId.equals(postId) & l.userId.equals(currentUserId)))
          .go();
    } else {
      await db.into(db.communityPostLikes).insertOnConflictUpdate(
            CommunityPostLikesCompanion(
              postId: Value(postId),
              userId: Value(currentUserId),
            ),
          );
      await _addNotification(
        'New Like',
        '$currentUserName liked a run post.',
      );
    }
  }

  Stream<List<CommunityComment>> watchComments(String postId) {
    return (db.select(db.communityComments)
          ..where((c) => c.postId.equals(postId))
          ..orderBy([(c) => OrderingTerm.asc(c.createdAtMs)]))
        .watch();
  }

  Future<void> addComment(String postId, String body) async {
    if (body.trim().isEmpty) return;
    await ensureSeeded();
    final id = 'cmt_${DateTime.now().microsecondsSinceEpoch}';
    await db.into(db.communityComments).insertOnConflictUpdate(
          CommunityCommentsCompanion(
            id: Value(id),
            postId: Value(postId),
            userId: Value(currentUserId),
            authorName: Value(currentUserName),
            body: Value(body.trim()),
            createdAtMs: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
  }

  Future<bool> deleteComment(CommunityComment comment) async {
    if (comment.userId != currentUserId) return false;
    await (db.delete(db.communityComments)
          ..where((c) => c.id.equals(comment.id)))
        .go();
    return true;
  }

  Future<void> blockUser(String targetUserId) async {
    if (targetUserId == currentUserId) return;
    await db.into(db.blockedUsers).insertOnConflictUpdate(
          BlockedUsersCompanion(
            blockerId: Value(currentUserId),
            blockedId: Value(targetUserId),
          ),
        );
  }

  Stream<List<CommunityGroup>> watchGroups({String query = ''}) async* {
    await ensureSeeded();
    final q = query.trim().toLowerCase();
    yield* db.select(db.communityGroups).watch().map((groups) {
      if (q.isEmpty) return groups;
      return groups
          .where((g) =>
              g.name.toLowerCase().contains(q) ||
              g.description.toLowerCase().contains(q))
          .toList();
    });
  }

  Future<void> createGroup({
    required String name,
    required String description,
    required bool isPrivate,
  }) async {
    await ensureSeeded();
    final id = 'grp_${DateTime.now().microsecondsSinceEpoch}';
    await db.into(db.communityGroups).insertOnConflictUpdate(
          CommunityGroupsCompanion(
            id: Value(id),
            name: Value(name.trim()),
            description: Value(description.trim()),
            isPrivate: Value(isPrivate),
            ownerId: Value(currentUserId),
            memberCount: const Value(1),
            isJoined: const Value(true),
          ),
        );
  }

  Future<void> toggleJoinGroup(CommunityGroup group) async {
    final nextJoined = !group.isJoined;
    final nextCount =
        nextJoined ? group.memberCount + 1 : (group.memberCount - 1).clamp(0, 999999);
    await db.into(db.communityGroups).insertOnConflictUpdate(
          CommunityGroupsCompanion(
            id: Value(group.id),
            name: Value(group.name),
            description: Value(group.description),
            isPrivate: Value(group.isPrivate),
            ownerId: Value(group.ownerId),
            memberCount: Value(nextCount),
            isJoined: Value(nextJoined),
          ),
        );
  }

  Stream<List<CommunityChallenge>> watchChallenges() async* {
    await ensureSeeded();
    yield* db.select(db.communityChallenges).watch();
  }

  Future<void> toggleJoinChallenge(CommunityChallenge ch) async {
    final nextJoined = !ch.isJoined;
    final nextCount =
        nextJoined ? ch.participantCount + 1 : (ch.participantCount - 1).clamp(0, 999999);
    await db.into(db.communityChallenges).insertOnConflictUpdate(
          CommunityChallengesCompanion(
            id: Value(ch.id),
            title: Value(ch.title),
            targetKm: Value(ch.targetKm),
            durationDays: Value(ch.durationDays),
            challengeType: Value(ch.challengeType),
            participantCount: Value(nextCount),
            isJoined: Value(nextJoined),
          ),
        );
  }

  Stream<List<CommunityNotification>> watchNotifications() async* {
    await ensureSeeded();
    yield* (db.select(db.communityNotifications)
          ..orderBy([(n) => OrderingTerm.desc(n.createdAtMs)]))
        .watch();
  }

  Future<void> _addNotification(String title, String body) async {
    await db.into(db.communityNotifications).insertOnConflictUpdate(
          CommunityNotificationsCompanion(
            id: Value('notif_${DateTime.now().microsecondsSinceEpoch}'),
            title: Value(title),
            body: Value(body),
            isRead: const Value(false),
            createdAtMs: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
  }
}
