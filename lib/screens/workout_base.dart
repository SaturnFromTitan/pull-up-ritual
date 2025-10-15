import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/screens/home.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import '../states/models.dart' show WorkoutSet;
import 'rest.dart' show RestScreen;
import 'success.dart' show SuccessScreen;

abstract class BaseWorkoutScreen extends StatefulWidget {
  const BaseWorkoutScreen({super.key});

  @override
  State<BaseWorkoutScreen> createState();
}

abstract class BaseWorkoutState<T extends BaseWorkoutScreen> extends State<T> {
  int get restDurationSeconds;

  int? getTargetReps();
  bool isWorkoutFinished(WorkoutState workoutState);

  void navigateToSuccess(WorkoutState workoutState) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SuccessScreen(workout: workoutState.workout),
      ),
    );
  }

  void navigateToRest(WorkoutState workoutState) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: workoutState,
          child: RestScreen(),
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  void finishSet({
    required int completedReps,
    required WorkoutState workoutState,
    required AppState appState,
  }) {
    // add set
    final set = WorkoutSet(
      targetReps: getTargetReps(),
      completedReps: completedReps,
    );
    workoutState.addSet(set);

    // navigate
    if (isWorkoutFinished(workoutState)) {
      workoutState.finish(appState);
      navigateToSuccess(workoutState);
    } else {
      workoutState.rest(restDurationSeconds);
      navigateToRest(workoutState);
    }
  }

  Widget getInputs(WorkoutState workoutState, AppState appState);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var workoutState = context.watch<WorkoutState>();
    int? targetReps = getTargetReps();
    Widget inputs = getInputs(workoutState, appState);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(workoutState.workout.workoutType.name),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      targetReps == null
                          ? Text("Do as many reps as possible! 🔥")
                          : Text("do $targetReps reps"),
                      SizedBox(height: 40),
                      inputs,
                    ],
                  ),
                ),
              ),
              ElevatedButton(onPressed: navigateToHome, child: Text("Cancel")),
            ],
          ),
        ),
      ),
    );
  }
}
