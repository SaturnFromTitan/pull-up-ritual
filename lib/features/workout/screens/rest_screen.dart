import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/screen_scaffold.dart';
import 'package:pull_up_ritual/features/workout/widgets/progress_bar.dart';
import 'package:pull_up_ritual/features/workout/widgets/set_cards.dart';
import 'package:pull_up_ritual/features/workout/providers/workout_provider.dart';
import 'package:pull_up_ritual/common/utils/utils.dart';

class RestScreen extends StatelessWidget {
  final double progress;
  const RestScreen({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    var workoutProvider = context.watch<WorkoutProvider>();

    if (!workoutProvider.isResting()) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pop(context),
      );
    }

    return ScreenScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(workoutProvider.workout.workoutType.name),
          WorkoutProgressBar(value: progress),
          Column(
            children: [
              Text('😴', style: AppTypography.displayMedium),
              SizedBox(height: AppSpacing.xxl),
              Text(
                formatMinutesSeconds(workoutProvider.restTimeRemaining),
                style: AppTypography.displayMedium,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SetCards(values: getSetCardValues(workoutProvider.workout)),
          ),
          ElevatedButton(
            onPressed: () {
              workoutProvider.resume();
              // no need to call Navigator.pop(...) here as the state change
              // causes this function to rerun and call the same code that
              // would run if the timer reached 0.
            },
            child: Text('Skip'),
          ),
        ],
      ),
    );
  }
}
