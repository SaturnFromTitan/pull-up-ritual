import 'package:flutter/material.dart';
import 'package:pull_up_ritual/screens/widgets/set_cards.dart' show SetCards;

import '../states/models.dart' show Workout;
import '../utils.dart' show formatMinutesSeconds, getSetCardValues;

class SuccessScreen extends StatelessWidget {
  final Workout workout;

  const SuccessScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final durationText = formatMinutesSeconds(workout.durationSeconds() ?? 0);
    final totalReps = workout.sets.fold(0, (t, s) => t + s.completedReps);

    return Scaffold(
      body: SafeArea(
        child: Center(
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
              ElevatedButton(
                onPressed: () {
                  // TODO: use named routes instead
                  //  because I also want to clear the state from the homepage
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
