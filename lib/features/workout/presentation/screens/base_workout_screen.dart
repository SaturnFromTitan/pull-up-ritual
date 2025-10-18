import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/shared/shell_screen.dart' show Shell;
import 'package:pull_up_ritual/shared/widgets/home_button.dart' show HomeButton;
import 'package:pull_up_ritual/features/workout/presentation/widgets/set_cards.dart'
    show SetCards;
import 'package:pull_up_ritual/features/workout/presentation/widgets/progress_bar.dart'
    show WorkoutProgressBar;
import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart';
import 'package:pull_up_ritual/core/utils/utils.dart' show getSetCardValues;

import 'package:pull_up_ritual/shared/providers/app_provider.dart'
    show AppProvider;
import 'package:pull_up_ritual/features/workout/data/models.dart'
    show WorkoutSet;
import 'rest_screen.dart' show RestScreen;
import 'success_screen.dart' show SuccessScreen;

abstract class BaseWorkoutScreen extends StatefulWidget {
  const BaseWorkoutScreen({super.key});

  @override
  State<BaseWorkoutScreen> createState();
}

abstract class BaseWorkoutState<T extends BaseWorkoutScreen> extends State<T> {
  int get restDurationSeconds;

  int? getTargetReps();
  double progress(WorkoutProvider workoutProvider);
  Widget getInputs(WorkoutProvider workoutProvider, AppProvider appProvider);

  void navigateToSuccess(WorkoutProvider workoutProvider) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SuccessScreen(workout: workoutProvider.workout),
      ),
    );
  }

  void navigateToRest(WorkoutProvider workoutProvider) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: workoutProvider,
          child: RestScreen(progress: progress(workoutProvider)),
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Shell()));
  }

  void finishSet({
    required int group,
    required int completedReps,
    required WorkoutProvider workoutProvider,
    required AppProvider appProvider,
  }) {
    // add set
    final set_ = WorkoutSet(
      group: group,
      targetReps: getTargetReps(),
      completedReps: completedReps,
    );
    workoutProvider.addSet(set_);

    // navigate
    if (progress(workoutProvider) == 1) {
      workoutProvider.finish(appProvider);
      navigateToSuccess(workoutProvider);
    } else {
      workoutProvider.rest(restDurationSeconds);
      navigateToRest(workoutProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = context.read<AppProvider>();
    var workoutProvider = context.watch<WorkoutProvider>();
    int? targetReps = getTargetReps();
    Widget inputs = getInputs(workoutProvider, appProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(workoutProvider.workout.workoutType.name),
              WorkoutProgressBar(value: progress(workoutProvider)),
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
                  values: getSetCardValues(workoutProvider.workout),
                ),
              ),
              HomeButton(text: "Cancel", icon: Icons.close),
            ],
          ),
        ),
      ),
    );
  }
}
