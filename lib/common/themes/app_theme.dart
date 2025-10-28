import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
// import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  // surface and text colors
  scaffoldBackgroundColor: Colors.transparent,
  colorScheme: ColorScheme.light(
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onLight,
    onSurfaceVariant: AppColors.onLightSecondary,
    onPrimary: AppColors.onColor,
    onPrimaryContainer: AppColors.onColor,
    onSecondary: AppColors.onColor,
    onSecondaryContainer: AppColors.onColor,
    shadow: AppColors.shadow,
  ),

  // Text theme
  textTheme: const TextTheme(
    displayLarge: AppTypography.displayLarge,
    displayMedium: AppTypography.displayMedium,
    displaySmall: AppTypography.displaySmall,
    headlineLarge: AppTypography.headlineLarge,
    headlineMedium: AppTypography.headlineMedium,
    headlineSmall: AppTypography.headlineSmall,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
  ),

  // Dialog, cards & chips
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
    ),
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
    ),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
    ),
  ),
);

final List<BoxShadow> defaultBoxShadows = const [
  BoxShadow(
    color: AppColors.shadow,
    blurRadius: AppSpacing.radiusSmall,
    offset: Offset(0, 4),
  ),
];
