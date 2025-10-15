import 'package:flutter/material.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;
import 'widgets/custom_reps_form.dart' show RepsForm;

class WorkoutLaddersScreen extends BaseWorkoutScreen {
  const WorkoutLaddersScreen({super.key});

  @override
  State<WorkoutLaddersScreen> createState() => _WorkoutLaddersState();
}

class _WorkoutLaddersState extends BaseWorkoutState<WorkoutLaddersScreen> {
  final _numberOfLadders = 5;
  int _targetReps = 1;
  int _completedLadders = 0;
  bool _showCustomRepsForm = false;

  @override
  int get restDurationSeconds => 30;

  @override
  int getTargetReps() => _targetReps;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) =>
      _completedLadders == _numberOfLadders;

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    var defaultButtons = Column(
      children: [
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
              _showCustomRepsForm = !_showCustomRepsForm;
            });
          },
          child: Text('I did fewer'),
        ),
      ],
    );
    var customRepsForm = RepsForm(
      onValidSubmit: (int reps) {
        _targetReps = 1;
        _completedLadders++;
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

    return _showCustomRepsForm ? customRepsForm : defaultButtons;
  }
}
