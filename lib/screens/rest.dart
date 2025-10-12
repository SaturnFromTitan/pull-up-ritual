import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/workout.dart' show WorkoutState;
import '../utils.dart' show formatMinutesSeconds;

class RestScreen extends StatelessWidget {
  const RestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var workoutState = context.watch<WorkoutState>();

    if (!workoutState.isResting()) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pop(context),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
