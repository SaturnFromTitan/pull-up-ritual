import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/screen_scaffold.dart';
import 'package:pull_up_ritual/common/widgets/home_button.dart' show HomeButton;
import 'package:pull_up_ritual/features/workout/widgets/set_cards.dart'
    show SetCards;

import 'package:pull_up_ritual/features/workout/models.dart' show Workout;
import 'package:pull_up_ritual/common/utils/utils.dart'
    show formatMinutesSeconds, getSetCardValues;

class SuccessScreen extends StatelessWidget {
  final Workout workout;

  const SuccessScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final durationText = formatMinutesSeconds(workout.durationSeconds() ?? 0);
    final totalReps = workout.totalReps();

    return ScreenScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '🎉\nWorkout\nCompleted!',
              style: AppTypography.displayMedium,
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                Text(
                  workout.workoutType.name,
                  style: AppTypography.headlineMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  "Duration: $durationText",
                  style: AppTypography.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  "Total Reps: $totalReps",
                  style: AppTypography.headlineSmall,
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
