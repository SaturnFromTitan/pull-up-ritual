import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';
import '../themes/app_typography.dart';
import 'gradient_surface.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon;
  final LinearGradient gradient;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.gradient = AppGradients.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: GradientSurface(
        gradient: gradient,
        height: AppSpacing.buttonHeight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: AppSpacing.sm),
            Text(text, style: AppTypography.headlineLarge),
          ],
        ),
      ),
    );
  }
}
