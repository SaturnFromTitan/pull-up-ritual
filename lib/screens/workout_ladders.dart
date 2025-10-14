import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;

class WorkoutLaddersScreen extends BaseWorkoutScreen {
  const WorkoutLaddersScreen({super.key});

  @override
  State<WorkoutLaddersScreen> createState() => _WorkoutLaddersState();
}

class _WorkoutLaddersState extends BaseWorkoutState<WorkoutLaddersScreen> {
  final _numberOfLadders = 5;
  int _targetReps = 1;
  int _completedLadders = 0;
  bool _showCustomInputForm = false;

  @override
  int get restDurationSeconds => 30;

  @override
  int getTargetReps() => _targetReps;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) =>
      _completedLadders == _numberOfLadders;

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    var defaultButtons = [
      ElevatedButton(
        onPressed: () {
          _targetReps++;
          finishSet(
            completedReps: getTargetReps(),
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done, continue this ladder'),
      ),
      ElevatedButton(
        onPressed: () {
          _targetReps = 1;
          _completedLadders++;
          finishSet(
            completedReps: getTargetReps(),
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done, start new ladder'),
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

              _targetReps = 1;
              _completedLadders++;
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
