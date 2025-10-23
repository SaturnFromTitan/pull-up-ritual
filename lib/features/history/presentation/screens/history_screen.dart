import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/core/themes/app_colors.dart';
import 'package:pull_up_ritual/core/themes/app_spacing.dart';
import 'package:pull_up_ritual/core/themes/app_typography.dart';
import 'package:pull_up_ritual/features/workout/presentation/widgets/set_cards.dart'
    show SetCards;
import 'package:pull_up_ritual/shared/providers/app_provider.dart';
import 'package:pull_up_ritual/features/workout/data/models.dart';
import 'package:pull_up_ritual/core/utils/utils.dart'
    show getSetCardValues, formatMinutesSeconds, datetimeToString;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appProvider = context.read<AppProvider>();
    final workouts = appProvider.completedWorkouts.reversed.toList();
    final numWorkouts = workouts.length;
    final totalReps = workouts.fold(0, (t, w) => t + w.totalReps());

    return Column(
      children: [
        Text(
          "Workout History",
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall,
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: TotalCard(value: numWorkouts, text: "Total Workouts"),
            ),
            SizedBox(width: AppSpacing.xs),
            Expanded(
              child: TotalCard(value: totalReps, text: "Total Reps"),
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

class TotalCard extends StatelessWidget {
  final int value;
  final String text;
  const TotalCard({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: AppTypography.headlineLarge.copyWith(
                color: AppColors.onLight,
              ),
            ),
            Text(text, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class WorkoutHistory extends StatelessWidget {
  final Workout workout;

  const WorkoutHistory({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Text(
                workout.workoutType.name,
                style: theme.textTheme.titleMedium,
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
