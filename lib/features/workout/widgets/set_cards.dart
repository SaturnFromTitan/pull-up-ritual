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

  static const int _maxCardsPerRow = 5;
  static const double _containerPadding = AppSpacing.paddingSmall;
  static const double _cardSpacing = AppSpacing.sm;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            (constraints.maxWidth -
                _containerPadding * 2 -
                _cardSpacing * (_maxCardsPerRow - 1)) /
            _maxCardsPerRow;
        final cardHeight = 2 / 3 * cardWidth;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.glassBackground,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          padding: const EdgeInsets.all(_containerPadding),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: _cardSpacing,
            runSpacing: AppSpacing.md,
            children: List.generate(
              numExpectedCards,
              (i) => _SetCard(
                value: i < values.length ? values[i] : null,
                width: cardWidth,
                height: cardHeight,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SetCard extends StatelessWidget {
  const _SetCard({this.value, required this.width, required this.height});

  static const String _placeholderValue = "?";
  final String? value;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: value == null ? 0.1 : 1.0,
      child: GradientSurface(
        height: height,
        width: width,
        gradient: value == null ? AppGradients.light : AppGradients.secondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: defaultBoxShadows,
        child: Center(
          child: Text(
            value ?? _placeholderValue,
            style: AppTypography.headlineSmall,
          ),
        ),
      ),
    );
  }
}
