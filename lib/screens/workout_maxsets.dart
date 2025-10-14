import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import 'workout_base.dart' show BaseWorkoutScreen, BaseWorkoutState;

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
  int? getTargetReps() => null;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) {
    return workoutState.workout.sets.length == _numberOfSets;
  }

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text("Do as many reps as possible! 🔥"),
          TextFormField(
            controller: controller,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
            ],
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'How many reps did you do?';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              var value = controller.text;
              if (value.isEmpty) {
                return;
              }
              final completedReps = int.parse(value);

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
    );
  }
}
