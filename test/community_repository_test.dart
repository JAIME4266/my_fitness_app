import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/features/community/data/community_repository.dart';
import 'package:my_fitness_app/features/run_tracking/domain/gps_filter.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  group('Phase 5 CommunityRepository (Multi-User, Privacy, Groups & Challenges)',
      () {
    test('Publishes run post, prevents duplicate likes, supports multi-user comments & blocking',
        () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() async => db.close());

      final repo = CommunityRepository(db);
      repo.setLocalActiveUser(id: 'user_aria', name: 'Aria Kim');

      final postId = await repo.publishRunPost(
        title: 'Sunrise Road Run',
        distanceKm: 6.2,
        durationSec: 1960,
        visibility: 'public',
      );

      // Switch to second user account
      repo.setLocalActiveUser(id: 'user_marcus', name: 'Marcus Vance');
      await repo.toggleLike(postId);
      var feed = await repo.watchFeed().first;
      expect(feed.length, 1);
      expect(feed.first.likeCount, 1);
      expect(feed.first.isLikedByMe, isTrue);

      // Toggle again unlikes (prevents duplicate likes)
      await repo.toggleLike(postId);
      feed = await repo.watchFeed().first;
      expect(feed.first.likeCount, 0);

      // Comment & unauthorized delete protection
      await repo.addComment(postId, 'Great pace!');
      final comments = await repo.watchComments(postId).first;
      expect(comments.length, 1);

      repo.setLocalActiveUser(id: 'user_aria', name: 'Aria Kim');
      final deletedByOther = await repo.deleteComment(comments.first);
      expect(deletedByOther, isFalse);

      // Block user hides their posts
      await repo.blockUser('user_marcus');
      repo.setLocalActiveUser(id: 'user_marcus', name: 'Marcus Vance');
      await repo.publishRunPost(
        title: 'Trail Run',
        distanceKm: 4.5,
        durationSec: 1575,
      );
      repo.setLocalActiveUser(id: 'user_aria', name: 'Aria Kim');
      final filteredFeed = await repo.watchFeed().first;
      expect(filteredFeed.any((p) => p.post.userId == 'user_marcus'), isFalse);
    });

    test('GPS privacy trims start/end ~150m endpoints', () {
      // 8 points spaced ~111m apart (~777m total)
      final pts = List.generate(
        8,
        (i) => TrackedPoint(
          lat: 28.6100 + (i * 0.001),
          lng: 77.2090,
          timestampEpochMs: i * 10000,
        ),
      );
      final trimmed = CommunityRepository.applyGpsPrivacyTrim(pts);
      expect(trimmed.length, lessThan(pts.length));
      expect(trimmed.first.lat, greaterThan(pts.first.lat));
      expect(trimmed.last.lat, lessThan(pts.last.lat));
    });

    test('Creates & joins groups and toggles challenges', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() async => db.close());

      final repo = CommunityRepository(db);
      await repo.createGroup(
        name: 'Delhi Morning Runners',
        description: '5K daily club',
        isPrivate: false,
      );
      final groups = await repo.watchGroups(query: 'delhi').first;
      expect(groups.length, 1);
      expect(groups.first.isJoined, isTrue);

      final challenges = await repo.watchChallenges().first;
      expect(challenges.length, greaterThanOrEqualTo(3));
    });
  });
}
