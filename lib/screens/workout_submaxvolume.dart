import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;

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
  bool _showCustomInputForm = false;

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
    int targetReps = getTargetReps();
    var defaultButtons = [
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
      ElevatedButton(
        onPressed: () {
          setState(() {
            _showCustomInputForm = !_showCustomInputForm;
          });
        },
        child: Text('I did fewer'),
      ),
    ];
    var fewerInputs = [
      TextFormField(
        controller: controller,
        maxLength: 2,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
        ],
        keyboardType: TextInputType.number,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showCustomInputForm = !_showCustomInputForm;
              });
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              var value = controller.text;
              if (value.isEmpty) {
                return;
              }
              final completedReps = int.parse(value);

              _showCustomInputForm = false;
              finishSet(
                completedReps: completedReps,
                workoutState: workoutState,
                appState: appState,
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    ];

    return Form(
      key: formKey,
      child: Column(
        children: _showCustomInputForm ? fewerInputs : defaultButtons,
      ),
    );
  }
}
