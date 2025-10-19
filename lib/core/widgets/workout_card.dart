import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';
import '../themes/app_typography.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final bool isSelected;
  final bool isRecommended;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.isSelected = false,
    this.isRecommended = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isRecommended ? 101.659 : 121.903,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.glassBackground
              : AppColors.glassBackground,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: isSelected
                ? AppColors.glassBorder
                : AppColors.glassBorderSecondary,
            width: 1.337,
          ),
        ),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Row(
                children: [
                  // Icon container with gradient background
                  Container(
                    width: AppSpacing.cardIconSize,
                    height: AppSpacing.cardIconSize,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(child: icon),
                  ),

                  SizedBox(width: AppSpacing.cardGap),

                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title, style: AppTypography.headlineMedium),
                        const SizedBox(height: 2.246),
                        Flexible(
                          child: Text(
                            description,
                            style: AppTypography.headlineSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Recommended badge
            if (isRecommended)
              Positioned(
                top: -30,
                right: 0,
                child: Container(
                  width: AppSpacing.badgeWidth,
                  height: AppSpacing.badgeHeight,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                  ),
                  child: Center(
                    child: Text('Recommended', style: AppTypography.labelLarge),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
