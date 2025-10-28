import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/total_card.dart';
import 'package:pull_up_ritual/features/workout/widgets/set_cards.dart';
import 'package:pull_up_ritual/common/providers/app_provider.dart';
import 'package:pull_up_ritual/features/workout/models.dart';
import 'package:pull_up_ritual/common/utils/utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    final workouts = appProvider.completedWorkouts.reversed.toList();
    final numWorkouts = workouts.length;
    final totalReps = workouts.fold(0, (t, w) => t + w.totalReps());

    return Column(
      children: [
        Text(
          "Workout History",
          textAlign: TextAlign.center,
          style: AppTypography.displayMedium,
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: TotalCard(
                value: numWorkouts.toString(),
                text: "Total Workouts",
                emoji: "🏋",
                color: AppColors.glassBackground,
              ),
            ),
            SizedBox(width: AppSpacing.xs),
            Expanded(
              child: TotalCard(
                value: totalReps.toString(),
                text: "Total Reps",
                emoji: "💪",
                color: AppColors.glassBackground,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs),
        Expanded(
          child: ListView(
            children: [
              ...[
                for (var workout in workouts) WorkoutHistory(workout: workout),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class WorkoutHistory extends StatelessWidget {
  final Workout workout;

  const WorkoutHistory({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.paddingBig),
          child: Column(
            children: [
              Text(
                workout.workoutType.name,
                style: AppTypography.headlineMedium,
              ),
              Text(datetimeToString(workout.start)),
              Text(
                "Duration: ${formatMinutesSeconds(workout.durationSeconds() ?? 0)}",
              ),
              Text("Total Reps: ${workout.totalReps()}"),
              SetCards(values: getSetCardValues(workout)),
            ],
          ),
        ),
      ),
    );
  }
}
