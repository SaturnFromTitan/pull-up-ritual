import 'package:flutter/material.dart';

/// Drop-in wrapper for your colorful cards/headers
class GradientSurface extends StatelessWidget {
  final LinearGradient gradient;
  final Widget child;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final double? height;
  final double? width;

  const GradientSurface({
    super.key,
    required this.gradient,
    required this.child,
    this.borderRadius,
    this.boxShadow,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onLight = scheme.onSurface; // for light/white surfaces
    final onColor = scheme.onPrimary; // for colored surfaces
    final textColor = _onForGradient(gradient, onLight, onColor);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: textColor),
        child: IconTheme.merge(
          data: IconThemeData(color: textColor),
          child: child,
        ),
      ),
    );
  }
}

Color _onForGradient(LinearGradient g, Color onLight, Color onColor) {
  // Sample the midpoint (cheap and usually good enough).
  // If you want better accuracy, sample multiple stops and pick the
  // foreground that maximizes contrast.
  final c0 = g.colors.first;
  final c1 = g.colors.last;
  final mid = Color.lerp(c0, c1, 0.5)!;
  return _onForColor(mid, onLight, onColor);
}

Color _onForColor(Color c, Color onLight, Color onColor) {
  final b = ThemeData.estimateBrightnessForColor(c);
  // You can choose your own mapping here:
  return b == Brightness.dark ? onColor : onLight;
}
