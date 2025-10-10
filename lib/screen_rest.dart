import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/state_workout.dart';

import 'state_workout.dart' show WorkoutState;
import 'utils.dart' show formatMinutesSeconds;

class RestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: can i do this without Consumer? the RestScreen is initialised via ChnangeNotifierProvider after all...
    return Consumer<WorkoutState>(
      builder: (context, workoutState, child) {
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
      },
    );
  }
}
