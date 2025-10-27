import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_theme.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/gradient_surface.dart';

class SetCards extends StatelessWidget {
  final List<String> values;
  final int numExpectedCards;
  const SetCards({super.key, required this.values, int? numExpectedCards})
    : numExpectedCards = numExpectedCards ?? values.length;

  static const int _columnCount = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingSmall),
      child: GridView.count(
        crossAxisCount: _columnCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 4 / 3,
        children: List.generate(
          numExpectedCards,
          (i) => i < values.length ? _SetCard(value: values[i]) : _SetCard(),
        ),
      ),
    );
  }
}

class _SetCard extends StatelessWidget {
  const _SetCard({this.value = placeholderValue});

  static const String placeholderValue = "?";
  final String value;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: value == placeholderValue ? 0.3 : 1.0,
      child: GradientSurface(
        gradient: AppGradients.secondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: defaultBoxShadows,
        child: Center(child: Text(value, style: AppTypography.headlineSmall)),
      ),
    );
  }
}
