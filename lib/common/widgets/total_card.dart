import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';

class TotalCard extends StatelessWidget {
  final String text;
  final String value;
  final String emoji;
  const TotalCard({
    super.key,
    required this.value,
    required this.text,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingSmall),
        child: Column(
          children: [
            Text(
              emoji,
              style: AppTypography.headlineLarge.copyWith(fontSize: 30),
            ),
            Text(
              value,
              style: AppTypography.headlineLarge.copyWith(fontSize: 26),
            ),
            Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                fontSize: 16,
                color: AppColors.onLightInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
