import 'package:flutter/material.dart';
import 'package:pull_up_ritual/core/themes/app_spacing.dart';
import 'package:pull_up_ritual/core/widgets/gradient_surface.dart'
    show GradientSurface;
import '../themes/app_colors.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;

  const ScreenScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
  });

  static const double _screenPaddingHorizontal = AppSpacing.md;
  static const double _screenPaddingVertical = AppSpacing.lg;

  @override
  Widget build(BuildContext context) {
    return GradientSurface(
      gradient: AppGradients.background,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _screenPaddingHorizontal,
              vertical: _screenPaddingVertical,
            ),
            child: child,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
