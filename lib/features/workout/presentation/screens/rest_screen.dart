import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/features/workout/presentation/widgets/progress_bar.dart'
    show WorkoutProgressBar;
import 'package:pull_up_ritual/features/workout/presentation/widgets/set_cards.dart'
    show SetCards;
import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart';

import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart'
    show WorkoutProvider;
import 'package:pull_up_ritual/core/utils/utils.dart'
    show formatMinutesSeconds, getSetCardValues;

class RestScreen extends StatelessWidget {
  final double progress;
  const RestScreen({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var workoutProvider = context.watch<WorkoutProvider>();

    if (!workoutProvider.isResting()) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pop(context),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(workoutProvider.workout.workoutType.name),
              WorkoutProgressBar(value: progress),
              Column(
                children: [
                  Text('😴', style: theme.textTheme.displayMedium),
                  SizedBox(height: 40),
                  Text(
                    formatMinutesSeconds(workoutProvider.restTimeRemaining),
                    style: theme.textTheme.displayMedium,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SetCards(
                  values: getSetCardValues(workoutProvider.workout),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  workoutProvider.resume();
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
