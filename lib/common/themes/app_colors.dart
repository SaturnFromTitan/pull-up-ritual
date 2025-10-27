import 'package:flutter/material.dart';

class AppColors {
  // surface colors
  static const Color surfaceLight = Colors.white;
  // we're using gradients instead of primary and secondary colors

  // Text colors
  static const Color onColor = Colors.white;
  static const Color onColorSecondary = Color(0xCCFFFFFF);
  static const Color onLight = Color(0xFF2D3748);
  static const Color onLightInactive = Color(0xFF4A5565);

  // Shadow colors
  static const Color shadow = Color(0x1A000000); // 10% black opacity

  // Glassmorphism colors - White overlays for dark background
  static const Color glassBackground = Color(0x1AFFFFFF); // 10% white opacity
  static const Color glassBorderActive = Color(0xB3FFFFFF); // 70% white opacity
  static const Color glassBorderInactive = Color(
    0x33FFFFFF,
  ); // 20% white opacity}

  // Gradient color lists
  static const List<Color> gradientPrimary = [
    Color(0xFFF6339A),
    Color(0xFFFF6900),
  ];
  static const List<Color> gradientSecondary = [
    Color(0xFF00C950), // Green
    Color(0xFF2B7FFF), // Blue
  ];
  static const List<Color> gradientBackground = [
    Color(0xFF9810FA), // Purple start (0%)
    Color(0xFF155DFC), // Blue middle (50%)
    Color(0xFF372AAC), // Dark blue end (100%)
  ];
  static const List<Color> gradientAccentPurple = [
    Color(0xFF8B5CF6),
    Color(0xFF6D28D9),
  ];
  static const List<Color> gradientAccentGreen = [
    Color(0xFF22C55E),
    Color(0xFF16A34A),
  ];
  static const List<Color> gradientRepCount = [
    Color(0xFF155DFC),
    Color(0xFF0092B8),
  ];
}

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: AppColors.gradientPrimary,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient secondary = LinearGradient(
    colors: AppColors.gradientSecondary,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient background = LinearGradient(
    colors: AppColors.gradientBackground,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient accentPurple = LinearGradient(
    colors: AppColors.gradientAccentPurple,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient accentGreen = LinearGradient(
    colors: AppColors.gradientAccentGreen,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient repCount = LinearGradient(
    colors: AppColors.gradientRepCount,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

Color getTextColorOnGradient(LinearGradient gradient, BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  final onLight = scheme.onSurface; // for light/white surfaces
  final onColor = scheme.onPrimary; // for colored surfaces

  final c0 = gradient.colors.first;
  final c1 = gradient.colors.last;
  final mid = Color.lerp(c0, c1, 0.5)!;

  final brightness = ThemeData.estimateBrightnessForColor(mid);
  return brightness == Brightness.dark ? onColor : onLight;
}
