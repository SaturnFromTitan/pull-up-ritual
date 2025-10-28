import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/screen_scaffold.dart';
import 'package:pull_up_ritual/common/widgets/home_button.dart';
import 'package:pull_up_ritual/common/widgets/total_card.dart';
import 'package:pull_up_ritual/features/workout/widgets/set_cards.dart';

import 'package:pull_up_ritual/features/workout/models.dart';
import 'package:pull_up_ritual/common/utils/utils.dart';

class SuccessScreen extends StatelessWidget {
  final Workout workout;

  const SuccessScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final durationText = formatMinutesSeconds(workout.durationSeconds() ?? 0);
    final totalReps = workout.totalReps();

    return ScreenScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Workout Completed!',
              style: AppTypography.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                // color: AppColors.surfaceLight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingBig,
                    horizontal: AppSpacing.paddingSmall,
                  ),
                  child: Column(
                    children: [
                      Text(
                        workout.workoutType.name,
                        style: AppTypography.headlineLarge,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: TotalCard(
                              text: "Total Reps",
                              value: totalReps.toString(),
                              emoji: "💪",
                            ),
                          ),
                          Expanded(
                            child: TotalCard(
                              text: "Duration",
                              value: durationText,
                              emoji: "⏱️",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SetCards(values: getSetCardValues(workout)),
            HomeButton(text: "Home", gradient: AppGradients.primary),
          ],
        ),
      ),
    );
  }
}
