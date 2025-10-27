import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/widgets/screen_scaffold.dart';
import 'package:pull_up_ritual/common/shell_screen.dart';
import 'package:pull_up_ritual/common/widgets/home_button.dart';
import 'package:pull_up_ritual/features/workout/widgets/set_cards.dart';
import 'package:pull_up_ritual/features/workout/widgets/progress_bar.dart';
import 'package:pull_up_ritual/features/workout/providers/workout_provider.dart';
import 'package:pull_up_ritual/common/utils/utils.dart';

import 'package:pull_up_ritual/common/providers/app_provider.dart';
import 'package:pull_up_ritual/features/workout/models.dart';
import '../rest_screen.dart';
import '../success_screen.dart';

abstract class BaseWorkoutScreen extends StatefulWidget {
  const BaseWorkoutScreen({super.key});

  @override
  State<BaseWorkoutScreen> createState();
}

abstract class BaseWorkoutState<T extends BaseWorkoutScreen> extends State<T> {
  int get restDurationSeconds;

  int? getTargetReps();
  Widget getInputs(WorkoutProvider workoutProvider, AppProvider appProvider);

  int getCompletedGroups(WorkoutProvider workoutProvider) {
    return workoutProvider.workout.sets.length;
  }

  double progress(WorkoutProvider workoutProvider) {
    return getCompletedGroups(workoutProvider) /
        workoutProvider.workout.maxGroups;
  }

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
    final instructionTextStyle = AppTypography.headlineMedium;

    return ScreenScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            workoutProvider.workout.workoutType.name,
            style: AppTypography.displaySmall,
          ),
          WorkoutProgressBar(value: progress(workoutProvider)),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.paddingSmall),
                child: Column(
                  children: [
                    targetReps == null
                        ? Column(
                            children: [
                              Text(
                                "Do as many reps as possible! 🔥",
                                style: instructionTextStyle,
                              ),
                              SizedBox(height: AppSpacing.xl),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("do", style: instructionTextStyle),
                              const SizedBox(width: AppSpacing.sm),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    AppGradients.repCount.createShader(bounds),
                                child: Text(
                                  targetReps.toString(),
                                  style: TextStyle(
                                    fontSize: 110,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                targetReps == 1 ? "rep" : "reps",
                                style: instructionTextStyle,
                              ),
                            ],
                          ),
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
              numExpectedCards: workoutProvider.workout.maxGroups,
            ),
          ),
          HomeButton(text: "Exit", icon: Icons.exit_to_app),
        ],
      ),
    );
  }
}
