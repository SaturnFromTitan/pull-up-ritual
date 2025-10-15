import 'package:flutter/material.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;
import 'widgets/custom_reps_form.dart' show RepsForm;

class WorkoutSubmaxVolumeScreen extends BaseWorkoutScreen {
  final int targetReps;
  const WorkoutSubmaxVolumeScreen({super.key, required this.targetReps});

  @override
  State<WorkoutSubmaxVolumeScreen> createState() =>
      _WorkoutSubmaxVolumeScreenState();
}

class _WorkoutSubmaxVolumeScreenState
    extends BaseWorkoutState<WorkoutSubmaxVolumeScreen> {
  final _numberOfSets = 10;
  bool _showCustomRepsForm = false;

  @override
  int get restDurationSeconds => 60;

  @override
  int getTargetReps() => widget.targetReps;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) {
    return workoutState.workout.sets.length == _numberOfSets;
  }

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    var buttons = _getButtons(workoutState, appState);

    var customRepsForm = RepsForm(
      onValidSubmit: (int reps) {
        _showCustomRepsForm = false;
        finishSet(
          completedReps: reps,
          workoutState: workoutState,
          appState: appState,
        );
      },
      onCancel: () {
        setState(() {
          _showCustomRepsForm = !_showCustomRepsForm;
        });
      },
    );

    return _showCustomRepsForm ? customRepsForm : Column(children: buttons);
  }

  List<Widget> _getButtons(WorkoutState workoutState, AppState appState) {
    int targetReps = getTargetReps();
    var buttons = [
      ElevatedButton(
        onPressed: () {
          finishSet(
            completedReps: targetReps,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done'),
      ),
      ElevatedButton(
        onPressed: () {
          finishSet(
            completedReps: targetReps - 1,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('I did ${targetReps - 1}'),
      ),
    ];
    if (targetReps >= 2) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            finishSet(
              completedReps: targetReps - 2,
              workoutState: workoutState,
              appState: appState,
            );
          },
          child: Text('I did ${targetReps - 2}'),
        ),
      );
    }
    if (targetReps >= 3) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showCustomRepsForm = !_showCustomRepsForm;
            });
          },
          child: Text('I did fewer'),
        ),
      );
    }
    return buttons;
  }
}
