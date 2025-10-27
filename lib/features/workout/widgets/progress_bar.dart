import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/widgets/gradient_surface.dart';

class WorkoutProgressBar extends StatelessWidget {
  final double value;
  const WorkoutProgressBar({super.key, required this.value});

  static const double height = 13.0;
  static final BorderRadius borderRadius = BorderRadius.circular(
    AppSpacing.radiusFull,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.glassBorderInactive,
        borderRadius: borderRadius,
      ),
      child: FractionallySizedBox(
        widthFactor: value,
        alignment: Alignment.centerLeft,
        child: GradientSurface(
          gradient: AppGradients.primary,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
