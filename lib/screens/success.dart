import 'package:flutter/material.dart';

import '../states/models.dart' show Workout;
import '../utils.dart' show formatMinutesSeconds;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🎉\nWorkout\nCompleted!',
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Total Reps: $totalReps",
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                "Duration: $durationText",
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
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
