import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFF6339A);
  static const Color primaryVariant = Color(0xFFFF6900);

  // Background colors - Purple to blue gradient
  static const Color background = Color(0xFF9810FA); // Purple start
  static const Color surface = Color(0xFF155DFC); // Blue middle
  static const Color surfaceVariant = Color(0xFF372AAC); // Dark blue end

  // Text colors - White for dark background
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onSurfaceVariant = Color(0xFFFFFFFF);
  static const Color onSurfaceSecondary = Color(0xCCFFFFFF); // 80% opacity
  static const Color onSurfaceTertiary = Color(0x80FFFFFF); // 50% opacity

  // Accent colors
  static const Color accent = Color(0xFFFDC700);
  static const Color onAccent = Color(0xFF733E0A);

  // Glassmorphism colors - White overlays for dark background
  static const Color glassBackground = Color(0x1AFFFFFF); // 10% white opacity
  static const Color glassBorder = Color(0xB3FFFFFF); // 70% white opacity
  static const Color glassBorderSecondary = Color(
    0x33FFFFFF,
  ); // 20% white opacity

  // Button colors
  static const Color buttonBackground = Color(0x33FFFFFF); // 20% white opacity
  static const Color buttonIcon = Color(0xFFFFFFFF);

  // Gradient colors
  static const List<Color> primaryGradient = [primary, primaryVariant];
  static const List<Color> backgroundGradient = [
    Color(0xFF9810FA), // Purple start (0%)
    Color(0xFF155DFC), // Blue middle (50%)
    Color(0xFF372AAC), // Dark blue end (100%)
  ];

  // Shadow colors
  static const Color shadow = Color(0x1A000000); // 10% opacity
  static const Color shadowStrong = Color(0x33000000); // 20% opacity
}
