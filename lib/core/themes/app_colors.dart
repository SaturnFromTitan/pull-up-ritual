import 'package:flutter/material.dart';

class AppColors {
  // Text colors
  static const Color onColor = Colors.white;
  static const Color onColorSecondary = Color(0xCCFFFFFF);
  static const Color onLight = Color(0xFFB0B0B0);

  // Gradient color lists
  static const List<Color> gradientPrimary = [
    Color(0xFFF6339A),
    Color(0xFFFF6900),
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

  // Glassmorphism colors - White overlays for dark background  - TODO: rename these
  static const Color glassBackground = Color(0x1AFFFFFF); // 10% white opacity
  static const Color glassBorder = Color(0xB3FFFFFF); // 70% white opacity
  static const Color glassBorderSecondary = Color(
    0x33FFFFFF,
  ); // 20% white opacity}

  // Shadow colors
  static const Color shadow = Color(0x1A000000); // 10% opacity
}

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: AppColors.gradientPrimary,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient background = LinearGradient(
    colors: AppColors.gradientBackground,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0], // 0%, 50%, 100%
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
}
