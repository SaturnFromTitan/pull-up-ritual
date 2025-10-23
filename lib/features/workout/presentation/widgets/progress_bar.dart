import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';

class WorkoutProgressBar extends StatelessWidget {
  final double value;
  const WorkoutProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      minHeight: 10,
    );
  }
}
