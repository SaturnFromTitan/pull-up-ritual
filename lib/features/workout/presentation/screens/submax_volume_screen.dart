import 'package:flutter/material.dart';
import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart';

import 'package:pull_up_ritual/common/providers/app_provider.dart'
    show AppProvider;
import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart'
    show WorkoutProvider;
import 'base_workout_screen.dart' show BaseWorkoutScreen, BaseWorkoutState;
import 'package:pull_up_ritual/features/workout/presentation/widgets/reps_form.dart'
    show RepsForm;

class SubmaxVolumeScreen extends BaseWorkoutScreen {
  final int targetReps;
  const SubmaxVolumeScreen({super.key, required this.targetReps});

  @override
  State<SubmaxVolumeScreen> createState() => _SubmaxVolumeScreenState();
}

class _SubmaxVolumeScreenState extends BaseWorkoutState<SubmaxVolumeScreen> {
  final _numberOfSets = 10;
  bool _showCustomRepsForm = false;

  @override
  int get restDurationSeconds => 60;

  @override
  int getTargetReps() => widget.targetReps;

  @override
  double progress(WorkoutProvider workoutProvider) {
    return workoutProvider.workout.sets.length / _numberOfSets;
  }

  @override
  Widget getInputs(WorkoutProvider workoutProvider, AppProvider appProvider) {
    var buttons = _getButtons(workoutProvider, appProvider);

    var customRepsForm = RepsForm(
      onValidSubmit: (int reps) {
        _showCustomRepsForm = false;
        finishSet(
          group: workoutProvider.workout.sets.length + 1,
          completedReps: reps,
          workoutProvider: workoutProvider,
          appProvider: appProvider,
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

  List<Widget> _getButtons(
    WorkoutProvider workoutProvider,
    AppProvider appProvider,
  ) {
    int targetReps = getTargetReps();
    var buttons = [
      ElevatedButton(
        onPressed: () {
          finishSet(
            group: workoutProvider.workout.sets.length + 1,
            completedReps: targetReps,
            workoutProvider: workoutProvider,
            appProvider: appProvider,
          );
        },
        child: Text('Done'),
      ),
      ElevatedButton(
        onPressed: () {
          finishSet(
            group: workoutProvider.workout.sets.length + 1,
            completedReps: targetReps - 1,
            workoutProvider: workoutProvider,
            appProvider: appProvider,
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
              group: workoutProvider.workout.sets.length + 1,
              completedReps: targetReps - 2,
              workoutProvider: workoutProvider,
              appProvider: appProvider,
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
