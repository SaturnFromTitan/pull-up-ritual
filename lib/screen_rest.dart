import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/state_workout.dart';

import 'state_workout.dart' show WorkoutState;

String formatMinutesSeconds(int totalSeconds) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(totalSeconds ~/ 60);
  final seconds = twoDigits(totalSeconds % 60);
  return "$minutes:$seconds";
}

class RestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<WorkoutState>(
      builder: (context, workoutState, child) {
        if (!workoutState.isResting()) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pop(context),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('😴', style: theme.textTheme.displayMedium),
                const SizedBox(height: 16),
                Text(
                  formatMinutesSeconds(workoutState.restTimeRemaining),
                  style: theme.textTheme.displayMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    workoutState.resume();
                    // no need to call Navigator.pop(...) here as the state change
                    // causes this function to rerun and call the same code that
                    // would run if the timer reached 0.
                  },
                  child: Text('Skip'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
