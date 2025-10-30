import 'package:flutter/material.dart';
import 'package:pull_up_club/common/themes/app_colors.dart';
import 'package:pull_up_club/common/themes/app_spacing.dart';
import 'package:pull_up_club/common/widgets/gradient_button.dart';
import 'package:pull_up_club/features/workout/providers/workout_provider.dart';
import 'package:pull_up_club/common/providers/app_provider.dart';
import 'package:pull_up_club/features/workout/widgets/reps_form.dart';
import '_base_workout_screen.dart';

class LaddersScreen extends BaseWorkoutScreen {
  const LaddersScreen({super.key});

  @override
  State<LaddersScreen> createState() => _LaddersState();
}

class _LaddersState extends BaseWorkoutState<LaddersScreen> {
  int _targetReps = 1;
  int _completedGroups = 0;
  bool _showCustomRepsForm = false;

  @override
  int get restDurationSeconds => 30;

  @override
  int getCompletedGroups(WorkoutProvider workoutProvider) => _completedGroups;

  @override
  int getTargetReps() => _targetReps;

  @override
  Widget getInputs(WorkoutProvider workoutProvider, AppProvider appProvider) {
    var buttons = [
      GradientButton(
        onPressed: () {
          finishSet(
            group: _completedGroups + 1,
            completedReps: getTargetReps(),
            workoutProvider: workoutProvider,
            appProvider: appProvider,
          );
          _targetReps++;
        },
        text: 'Done, continue this ladder',
        icon: Icons.trending_up,
        gradient: AppGradients.accentGreen,
      ),
      GradientButton(
        onPressed: () {
          // have to increment _completedGroups before calling finishSet
          // so that isFinished() is evaluated correctly
          _completedGroups++;
          finishSet(
            group: _completedGroups,
            completedReps: getTargetReps(),
            workoutProvider: workoutProvider,
            appProvider: appProvider,
          );
          _targetReps = 1;
        },
        text: isLastGroup(workoutProvider)
            ? 'Finish Workout'
            : 'Done, start new ladder',
        icon: isLastGroup(workoutProvider) ? Icons.check : Icons.refresh,
        gradient: AppGradients.accentPurple,
      ),
      GradientButton(
        onPressed: () {
          setState(() {
            _showCustomRepsForm = !_showCustomRepsForm;
          });
        },
        text: 'I did fewer',
        icon: Icons.close,
        gradient: AppGradients.light,
      ),
    ];
    var customRepsForm = RepsForm(
      onValidSubmit: (int reps) {
        // have to increment _completedGroups before calling finishSet
        // so that isFinished() is evaluated correctly
        _completedGroups++;
        finishSet(
          group: _completedGroups,
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

    return _showCustomRepsForm
        ? customRepsForm
        : Column(
            children: List<Widget>.generate(
              buttons.length * 2 - 1,
              (i) =>
                  i.isEven ? buttons[i ~/ 2] : SizedBox(height: AppSpacing.sm),
            ),
          );
  }
}
