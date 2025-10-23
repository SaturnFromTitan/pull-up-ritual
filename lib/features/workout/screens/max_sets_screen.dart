import 'package:flutter/material.dart';
import 'package:pull_up_ritual/features/workout/providers/workout_provider.dart';

import 'package:pull_up_ritual/common/providers/app_provider.dart'
    show AppProvider;
import 'package:pull_up_ritual/features/workout/providers/workout_provider.dart'
    show WorkoutProvider;
import 'base_workout_screen.dart' show BaseWorkoutScreen, BaseWorkoutState;
import 'package:pull_up_ritual/features/workout/widgets/reps_form.dart'
    show RepsForm;

class MaxSetsScreen extends BaseWorkoutScreen {
  const MaxSetsScreen({super.key});

  @override
  State<MaxSetsScreen> createState() => _MaxSetsScreenState();
}

class _MaxSetsScreenState extends BaseWorkoutState<MaxSetsScreen> {
  final _numberOfSets = 3;

  @override
  int get restDurationSeconds => 5 * 60;

  @override
  Null getTargetReps() => null;

  @override
  double progress(WorkoutProvider workoutProvider) {
    return workoutProvider.workout.sets.length / _numberOfSets;
  }

  @override
  Widget getInputs(WorkoutProvider workoutProvider, AppProvider appProvider) {
    return RepsForm(
      onValidSubmit: (int reps) {
        finishSet(
          group: workoutProvider.workout.sets.length + 1,
          completedReps: reps,
          workoutProvider: workoutProvider,
          appProvider: appProvider,
        );
      },
    );
  }
}
