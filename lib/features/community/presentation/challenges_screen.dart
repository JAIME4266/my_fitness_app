import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../../run_tracking/data/run_repository.dart';
import '../data/community_repository.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(communityRepositoryProvider);
    final workouts = ref.watch(recentWorkoutsProvider).valueOrNull ?? [];
    final totalLoggedKm =
        workouts.fold<double>(0.0, (sum, w) => sum + (w.distanceM / 1000.0));

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Challenges',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<List<CommunityChallenge>>(
        stream: repo.watchChallenges(),
        builder: (context, snap) {
          final challenges = snap.data ?? [];
          if (challenges.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: challenges.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final ch = challenges[i];
              final pct = (totalLoggedKm / ch.targetKm).clamp(0.0, 1.0);
              final completed = totalLoggedKm >= ch.targetKm;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE7E5E4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(ch.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        OutlinedButton(
                          onPressed: () => repo.toggleJoinChallenge(ch),
                          child: Text(ch.isJoined ? 'Joined' : 'Join'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ch.durationDays} day(s) • ${ch.participantCount} participant(s) • ${completed ? "Completed" : "In Progress"}',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: pct,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF0F766E)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${totalLoggedKm.toStringAsFixed(2)} / ${ch.targetKm.toStringAsFixed(0)} km logged',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F766E)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
