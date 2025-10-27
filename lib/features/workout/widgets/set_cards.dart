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
    : assert(
        numExpectedCards == null || numExpectedCards >= values.length,
        'numExpectedCards must be >= values.length',
      ),
      numExpectedCards = numExpectedCards ?? values.length;

  static const int _columnCount = 5;

  @override
  Widget build(BuildContext context) {
    var children = List.generate(
      numExpectedCards,
      (i) => i < values.length
          ? _SetCard(value: values[i])
          : const _SetCard.placeholder(),
    );

    if (children.length < _columnCount && children.length % 2 == 1) {
      // this is a dirty hack to visually center the entries in the grid
      // i like using GridView.count as I don't have to manually define the
      // SetCard dimensions. But I didn't find a convenient way to center
      // the cards when there are fewer entries than columns.
      final int numPlaceholders = (_columnCount - numExpectedCards) ~/ 2;
      children.insertAll(
        0,
        List.generate(numPlaceholders, (i) => const _SetCard.hidden()),
      );
    }

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
        children: children,
      ),
    );
  }
}

class _SetCard extends StatelessWidget {
  const _SetCard({required this.value});
  const _SetCard.placeholder() : value = _placeholderValue;
  const _SetCard.hidden() : value = _hiddenValue;

  static const String _hiddenValue = "";
  static const String _placeholderValue = "?";
  final String value;

  @override
  Widget build(BuildContext context) {
    final double opacity;
    switch (value) {
      case _hiddenValue:
        opacity = 0.0;
      case _placeholderValue:
        opacity = 0.3;
      default:
        opacity = 1.0;
    }
    return Opacity(
      opacity: opacity,
      child: GradientSurface(
        gradient: AppGradients.secondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: defaultBoxShadows,
        child: Center(child: Text(value, style: AppTypography.headlineSmall)),
      ),
    );
  }
}
