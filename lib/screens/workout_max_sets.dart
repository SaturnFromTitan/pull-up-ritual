import 'package:flutter/material.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;
import 'widgets/reps_form.dart' show RepsForm;

class WorkoutMaxSetsScreen extends BaseWorkoutScreen {
  const WorkoutMaxSetsScreen({super.key});

  @override
  State<WorkoutMaxSetsScreen> createState() => _WorkoutMaxSetsScreenState();
}

class _WorkoutMaxSetsScreenState
    extends BaseWorkoutState<WorkoutMaxSetsScreen> {
  final _numberOfSets = 3;

  @override
  int get restDurationSeconds => 5 * 60;

  @override
  Null getTargetReps() => null;

  @override
  double progress(WorkoutState workoutState) {
    return workoutState.workout.sets.length / _numberOfSets;
  }

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    return RepsForm(
      onValidSubmit: (int reps) {
        finishSet(
          completedReps: reps,
          workoutState: workoutState,
          appState: appState,
        );
      },
    );
  }
}
