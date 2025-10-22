import 'package:flutter/material.dart';
import 'package:pull_up_ritual/core/themes/app_colors.dart';
// import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  scaffoldBackgroundColor: Colors.transparent,

  // TODO: define ColorTheme
  // TODO: define TextTheme

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
