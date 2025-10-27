import 'package:flutter/material.dart';
import 'package:pull_up_ritual/features/workout/providers/workout_provider.dart';
import 'package:pull_up_ritual/common/providers/app_provider.dart';
import 'package:pull_up_ritual/features/workout/widgets/reps_form.dart';
import '_base_workout_screen.dart';

class LaddersScreen extends BaseWorkoutScreen {
  const LaddersScreen({super.key});

  @override
  State<LaddersScreen> createState() => _LaddersState();
}

class _LaddersState extends BaseWorkoutState<LaddersScreen> {
  final _numberOfLadders = 5;
  int _targetReps = 1;
  int _completedLadders = 0;
  bool _showCustomRepsForm = false;

  @override
  int get restDurationSeconds => 30;

  @override
  int getTargetReps() => _targetReps;

  @override
  double progress(WorkoutProvider workoutProvider) {
    return _completedLadders / _numberOfLadders;
  }

  @override
  Widget getInputs(WorkoutProvider workoutProvider, AppProvider appProvider) {
    var buttons = [
      ElevatedButton(
        onPressed: () {
          finishSet(
            group: _completedLadders + 1,
            completedReps: getTargetReps(),
            workoutProvider: workoutProvider,
            appProvider: appProvider,
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
            workoutProvider: workoutProvider,
            appProvider: appProvider,
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
          workoutProvider: workoutProvider,
          appProvider: appProvider,
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
