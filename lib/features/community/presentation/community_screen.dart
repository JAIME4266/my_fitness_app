import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../../run_tracking/data/run_repository.dart';
import '../../run_tracking/domain/gps_filter.dart';
import '../../run_tracking/presentation/route_map_widget.dart';
import '../data/community_repository.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(communityRepositoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'COMMUNITY',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, size: 18),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              tooltip: 'Notifications',
              onPressed: () => _showNotificationsSheet(context, repo),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF0F766E),
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: const Color(0xFF0F766E),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Groups'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPostRunSheet(context),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Post a Run'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(repo),
          _buildGroupsTab(repo),
        ],
      ),
    );
  }

  Widget _buildFeedTab(CommunityRepository repo) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 90),
      children: [
        const Text(
          'Daily Goal Achievers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 92,
          child: StreamBuilder<List<CommunityProfile>>(
            stream: repo.watchGoalAchievers(),
            builder: (context, snap) {
              final users = snap.data ?? [];
              if (users.isEmpty) {
                return const Center(
                  child: Text('Complete a run to appear here!',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                );
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, i) {
                  final u = users[i];
                  final pct = (u.todayDistanceKm /
                          (u.dailyGoalKm > 0 ? u.dailyGoalKm : 5.0))
                      .clamp(0.0, 1.0);
                  return Column(
                    children: [
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: pct,
                              strokeWidth: 4,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF0F766E)),
                            ),
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: const Color(0xFFE6F2F0),
                              child: Text(
                                u.displayName.isNotEmpty
                                    ? u.displayName[0].toUpperCase()
                                    : 'A',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F766E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${u.todayDistanceKm.toStringAsFixed(1)}k today',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Daily Runs',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        StreamBuilder<List<FeedPostView>>(
          stream: repo.watchFeed(query: _query),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final posts = snap.data!;
            if (posts.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE7E5E4)),
                ),
                child: const Text(
                  'No runs shared yet. Tap "Post a Run" below to share a real recorded workout!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              );
            }
            return Column(
              children: posts.map((item) => _buildPostCard(repo, item)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPostCard(CommunityRepository repo, FeedPostView item) {
    final p = item.post;
    final points = GpsFilter.decodePolyline(p.polylineJson);
    final dur = GpsFilter.formatDuration(p.durationSec);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7E5E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFE6F2F0),
                child: Text(
                  p.authorName.isNotEmpty ? p.authorName[0].toUpperCase() : 'U',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF0F766E)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.authorName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Running • ${p.visibility}',
                        style: TextStyle(
                            fontSize: 11.5, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (val) async {
                  if (val == 'block') {
                    await repo.blockUser(p.userId);
                  } else if (val == 'report' && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Post reported for moderation review.')),
                    );
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'report', child: Text('Report Post')),
                  PopupMenuItem(value: 'block', child: Text('Block User')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(p.title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stat('${p.distanceKm.toStringAsFixed(2)} km', 'distance'),
              _stat(dur, 'time'),
              _stat('${p.paceLabel} /km', 'avg pace'),
            ],
          ),
          if (points.length >= 2) ...[
            const SizedBox(height: 10),
            RouteMapWidget(
              points: points,
              height: 150,
              interactive: false,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () => repo.toggleLike(p.id),
                icon: Icon(
                  item.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                  color: item.isLikedByMe ? Colors.red : Colors.grey.shade700,
                ),
              ),
              Text('${item.likeCount}'),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => _showCommentsSheet(context, repo, p.id),
                icon: const Icon(Icons.chat_bubble_outline),
              ),
              Text('${item.commentCount}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String val, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(val,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildGroupsTab(CommunityRepository repo) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Running Groups',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton.icon(
                onPressed: () => _showCreateGroupDialog(context, repo),
                icon: const Icon(Icons.group_add),
                label: const Text('Create Group'),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<CommunityGroup>>(
            stream: repo.watchGroups(query: _query),
            builder: (context, snap) {
              final groups = snap.data ?? [];
              if (groups.isEmpty) {
                return const Center(
                  child: Text('No groups yet. Create the first running club!',
                      style: TextStyle(color: Colors.grey)),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: groups.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final g = groups[i];
                  return Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Color(0xFFE7E5E4)),
                    ),
                    child: ListTile(
                      title: Text(g.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          '${g.isPrivate ? "Private" : "Public"} • ${g.memberCount} members\n${g.description}'),
                      trailing: OutlinedButton(
                        onPressed: () => repo.toggleJoinGroup(g),
                        child: Text(g.isJoined ? 'Joined' : 'Join'),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showPostRunSheet(BuildContext context) async {
    final workouts = await ref.read(runRepositoryProvider).watchRecentWorkouts().first;
    final titleCtrl = TextEditingController(text: 'Morning Run');
    final distCtrl = TextEditingController(
      text: workouts.isNotEmpty
          ? (workouts.first.distanceM / 1000.0).toStringAsFixed(2)
          : '3.00',
    );
    String visibility = 'public';
    Workout? selectedWorkout = workouts.isNotEmpty ? workouts.first : null;

    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Post a Run',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                    labelText: 'Run Title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: distCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Distance (km)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: visibility,
                decoration: const InputDecoration(
                    labelText: 'Privacy Visibility',
                    border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'public', child: Text('Public')),
                  DropdownMenuItem(
                      value: 'followers', child: Text('Followers Only')),
                  DropdownMenuItem(value: 'private', child: Text('Private')),
                ],
                onChanged: (v) {
                  if (v != null) setModalState(() => visibility = v);
                },
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F766E),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final km = double.tryParse(distCtrl.text) ?? 3.0;
                    await ref.read(communityRepositoryProvider).publishRunPost(
                          title: titleCtrl.text,
                          distanceKm: km,
                          durationSec: selectedWorkout?.durationSec ?? 1200,
                          polylineJson: selectedWorkout?.polylineJson,
                          visibility: visibility,
                        );
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Publish Run'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCommentsSheet(
      BuildContext context, CommunityRepository repo, String postId) {
    final commentCtrl = TextEditingController();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, MediaQuery.of(ctx).viewInsets.bottom + 16),
        child: SizedBox(
          height: 360,
          child: Column(
            children: [
              const Text('Comments',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Divider(),
              Expanded(
                child: StreamBuilder<List<CommunityComment>>(
                  stream: repo.watchComments(postId),
                  builder: (_, snap) {
                    final list = snap.data ?? [];
                    if (list.isEmpty) {
                      return const Center(
                          child: Text('No comments yet.',
                              style: TextStyle(color: Colors.grey)));
                    }
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        final c = list[i];
                        return ListTile(
                          dense: true,
                          title: Text(c.authorName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(c.body),
                          trailing: c.userId == repo.currentUserId
                              ? IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18),
                                  onPressed: () => repo.deleteComment(c),
                                )
                              : null,
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment...',
                        isDense: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF0F766E)),
                    onPressed: () async {
                      await repo.addComment(postId, commentCtrl.text);
                      commentCtrl.clear();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCreateGroupDialog(
      BuildContext context, CommunityRepository repo) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    bool isPrivate = false;
    return showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Create Running Group'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Group Name')),
              TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: 'Description')),
              SwitchListTile(
                value: isPrivate,
                onChanged: (v) => setDlg(() => isPrivate = v),
                title: const Text('Private Group'),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty) return;
                await repo.createGroup(
                  name: nameCtrl.text,
                  description: descCtrl.text,
                  isPrivate: isPrivate,
                );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNotificationsSheet(
      BuildContext context, CommunityRepository repo) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => StreamBuilder<List<CommunityNotification>>(
        stream: repo.watchNotifications(),
        builder: (_, snap) {
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const SizedBox(
              height: 180,
              child: Center(child: Text('No notifications yet.')),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => ListTile(
              leading: const Icon(Icons.notifications, color: Color(0xFF0F766E)),
              title: Text(items[i].title),
              subtitle: Text(items[i].body),
            ),
          );
        },
      ),
    );
  }
}
