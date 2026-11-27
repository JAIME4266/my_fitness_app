import 'package:flutter/material.dart';
import '../../domain/training_analytics_engine.dart';
import '../../theme/training_theme.dart';

class TrainingWeeklyCalendar extends StatelessWidget {
  final List<TrainingDayStatus> days;
  final DateTime selectedDate;
  final DateTime today;
  final ValueChanged<DateTime> onSelectDate;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const TrainingWeeklyCalendar({
    super.key,
    required this.days,
    required this.selectedDate,
    required this.today,
    required this.onSelectDate,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  static const _letters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final todayKey = TrainingAnalyticsEngine.dateKeyFor(today);
    final selectedKey = TrainingAnalyticsEngine.dateKeyFor(selectedDate);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              tooltip: 'Previous Week',
              icon: const Icon(Icons.chevron_left,
                  color: TrainingTheme.textSecondary, size: 20),
              onPressed: onPreviousWeek,
            ),
            Text(
              _weekLabel(days.first.date, days.last.date),
              style: const TextStyle(
                color: TrainingTheme.textSecondary,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              tooltip: 'Next Week',
              icon: const Icon(Icons.chevron_right,
                  color: TrainingTheme.textSecondary, size: 20),
              onPressed: onNextWeek,
            ),
          ],
        ),
        const SizedBox(height: 2),
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 20,
              right: 20,
              top: 31,
              child: Container(
                height: 1,
                color: TrainingTheme.border,
              ),
            ),
            Row(
              children: List.generate(days.length, (i) {
                final day = days[i];
                final isSelected = day.dateKey == selectedKey;
                final isToday = day.dateKey == todayKey;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelectDate(day.date),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? TrainingTheme.surfaceElevated
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isToday && !isSelected
                            ? Border.all(
                                color: TrainingTheme.lime.withValues(alpha: 0.35),
                              )
                            : isSelected
                                ? Border.all(
                                    color: TrainingTheme.lime
                                        .withValues(alpha: 0.6),
                                  )
                                : null,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _letters[i],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? TrainingTheme.textPrimary
                                  : TrainingTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: day.hasCompleted
                                  ? TrainingTheme.lime
                                  : (isSelected
                                      ? TrainingTheme.surface
                                      : TrainingTheme.bg),
                              border: Border.all(
                                color: day.hasCompleted
                                    ? TrainingTheme.lime
                                    : day.hasScheduled
                                        ? TrainingTheme.enduranceAccent
                                        : TrainingTheme.border,
                                width: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${day.date.day}',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: isSelected || isToday
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSelected || isToday
                                  ? TrainingTheme.lime
                                  : TrainingTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          SizedBox(
                            height: 5,
                            child: day.hasCompleted || day.hasScheduled
                                ? Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: day.hasCompleted
                                          ? TrainingTheme.lime
                                          : TrainingTheme.enduranceAccent,
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  static String _weekLabel(DateTime start, DateTime end) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    final sm = months[start.month - 1];
    final em = months[end.month - 1];
    if (sm == em) {
      return '$sm ${start.day} – ${end.day}';
    }
    return '$sm ${start.day} – $em ${end.day}';
  }
}
