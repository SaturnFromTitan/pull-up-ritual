import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/screens/home.dart';
import 'package:pull_up_ritual/screens/widgets/set_cards.dart' show SetCards;
import 'package:pull_up_ritual/screens/widgets/progress_bar.dart'
    show WorkoutProgressBar;
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
  double progress(WorkoutState workoutState);

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
    if (progress(workoutState) == 1.0) {
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
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(workoutState.workout.workoutType.name),
              WorkoutProgressBar(value: progress(workoutState)),
              SizedBox(
                width: double.infinity,
                child: Card(
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
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SetCards(
                  values: [
                    for (var set in workoutState.workout.sets)
                      set.completedReps,
                  ],
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
