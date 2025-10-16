import 'package:flutter/material.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;
import 'widgets/reps_form.dart' show RepsForm;

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
  double progress(WorkoutState workoutState) {
    return _completedLadders / _numberOfLadders;
  }

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    var buttons = [
      ElevatedButton(
        onPressed: () {
          finishSet(
            group: _completedLadders + 1,
            completedReps: getTargetReps(),
            workoutState: workoutState,
            appState: appState,
          );
          _targetReps++;
        },
        child: Text('Done, continue this ladder'),
      ),
      ElevatedButton(
        onPressed: () {
          // have to increment completedLadders before calling finishSet
          // so that progress() is evaluated correctly
          _completedLadders++;
          finishSet(
            group: _completedLadders,
            completedReps: getTargetReps(),
            workoutState: workoutState,
            appState: appState,
          );
          _targetReps = 1;
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
    ];
    var customRepsForm = RepsForm(
      onValidSubmit: (int reps) {
        // have to increment completedLadders before calling finishSet
        // so that progress() is evaluated correctly
        _completedLadders++;
        finishSet(
          group: _completedLadders,
          completedReps: reps,
          workoutState: workoutState,
          appState: appState,
        );
        _targetReps = 1;
        _showCustomRepsForm = false;
      },
      onCancel: () {
        setState(() {
          _showCustomRepsForm = !_showCustomRepsForm;
        });
      },
    );

    return _showCustomRepsForm ? customRepsForm : Column(children: buttons);
  }
}
