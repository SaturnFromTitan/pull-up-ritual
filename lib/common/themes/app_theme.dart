import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
// import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  scaffoldBackgroundColor: Colors.transparent,

  colorScheme: ColorScheme.light(
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onLight,
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

  // Dialog theme
  dialogTheme: DialogThemeData(
    // backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
    ),
    titleTextStyle: AppTypography.headlineMedium,
    contentTextStyle: AppTypography.bodyMedium,
  ),
);

final List<BoxShadow> defaultBoxShadows = const [
  BoxShadow(
    color: AppColors.shadow,
    blurRadius: AppSpacing.radiusSmall,
    offset: Offset(0, 4),
  ),
];
