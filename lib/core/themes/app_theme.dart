import 'package:flutter/material.dart';
import 'package:pull_up_ritual/core/themes/app_colors.dart';
// import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  scaffoldBackgroundColor: Colors.transparent,

  colorScheme: ColorScheme.light(
    onSurface: AppColors.onLight,
    primary: Colors.transparent,
    onPrimary: AppColors.onColor,
    secondary: Colors.transparent,
    onSecondary: AppColors.onColor,
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
    labelLarge: AppTypography.labelLarge,
    labelMedium: AppTypography.labelMedium,
    labelSmall: AppTypography.labelSmall,
  ),

  // Dialog theme
  dialogTheme: DialogThemeData(
    // backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
    ),
    titleTextStyle: AppTypography.headlineMedium.copyWith(
      color: AppColors.onLight,
    ),
    contentTextStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.onLight,
    ),
  ),
);
