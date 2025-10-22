import 'package:flutter/material.dart';
import 'package:pull_up_ritual/core/widgets/gradient_scaffold.dart';
import 'package:pull_up_ritual/shared/widgets/home_button.dart' show HomeButton;
import 'package:pull_up_ritual/features/workout/presentation/widgets/set_cards.dart'
    show SetCards;

import 'package:pull_up_ritual/features/workout/data/models.dart' show Workout;
import 'package:pull_up_ritual/core/utils/utils.dart'
    show formatMinutesSeconds, getSetCardValues;

class SuccessScreen extends StatelessWidget {
  final Workout workout;

  const SuccessScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final durationText = formatMinutesSeconds(workout.durationSeconds() ?? 0);
    final totalReps = workout.totalReps();

    return GradientScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '🎉\nWorkout\nCompleted!',
              style: theme.textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                Text(
                  workout.workoutType.name,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  "Duration: $durationText",
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  "Total Reps: $totalReps",
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 40),
                SetCards(values: getSetCardValues(workout)),
              ],
            ),
            HomeButton(text: "Home"),
          ],
        ),
      ),
    );
  }
}
