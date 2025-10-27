import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_theme.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/gradient_surface.dart';

class SetCards extends StatelessWidget {
  final List<String> values;
  const SetCards({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: values.isEmpty ? 0 : null,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingSmall),
      child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 4 / 3,
        children: [for (var value in values) _SetCard(value: value)],
      ),
    );
  }
}

class _SetCard extends StatelessWidget {
  const _SetCard({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return GradientSurface(
      gradient: AppGradients.secondary,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      boxShadow: defaultBoxShadows,
      child: Center(child: Text(value, style: AppTypography.headlineSmall)),
    );
  }
}
