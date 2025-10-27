import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_theme.dart';
import '../themes/app_spacing.dart';
import '../themes/app_typography.dart';
import 'gradient_surface.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget icon;
  final LinearGradient gradient;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? 0.5 : 1.0,
        child: GradientSurface(
          gradient: gradient,
          height: AppSpacing.buttonHeight,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          boxShadow: defaultBoxShadows,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: AppSpacing.sm),
              Text(text, style: AppTypography.headlineLarge),
            ],
          ),
        ),
      ),
    );
  }
}
