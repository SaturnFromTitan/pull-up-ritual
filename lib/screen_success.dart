import 'package:flutter/material.dart';

import 'models.dart' show Workout;
import 'utils.dart' show formatMinutesSeconds;

class SuccessScreen extends StatelessWidget {
  final Workout workout;

  const SuccessScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = formatMinutesSeconds(workout.durationSeconds());
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
                "Duration: $duration",
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                "Total Reps: $totalReps",
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: use named routes instead
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
