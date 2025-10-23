import 'package:flutter/material.dart';
import 'package:pull_up_ritual/core/themes/app_colors.dart';
import 'package:pull_up_ritual/core/themes/app_spacing.dart';
import 'package:pull_up_ritual/core/themes/app_typography.dart';

class GradientNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const GradientNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  static const double _barTopPadding = 9.7; // ~9.662
  static const double _itemRadius = AppSpacing.radiusLarge;
  static const double _iconSize = 27.0; // ~26.992
  static const double _gap = 4.5; // ~4.492

  // Figma colors
  static const Color _inactiveColor = AppColors.onLightInactive;
  static const LinearGradient _selectedGradient = AppGradients.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: _barTopPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(destinations.length, (index) {
              final destination = destinations[index];
              final bool isSelected = index == selectedIndex;
              final Widget iconWidget =
                  (isSelected && destination.selectedIcon != null)
                  ? destination.selectedIcon!
                  : destination.icon;
              return _NavItem(
                isSelected: isSelected,
                icon: iconWidget,
                label: destination.label,
                onTap: () => onDestinationSelected(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final bool isSelected;
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = AppTypography.labelLarge.copyWith(
      color: isSelected ? Colors.white : GradientNavigationBar._inactiveColor,
      height: 18 / 13.5, // leading 18 per Figma
      letterSpacing: -0.1121, // per Figma
      fontWeight: FontWeight.w400, // Inter Regular per Figma
    );

    final Widget coloredIcon = IconTheme(
      data: IconThemeData(
        size: GradientNavigationBar._iconSize,
        color: isSelected ? Colors.white : GradientNavigationBar._inactiveColor,
      ),
      child: icon,
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected ? GradientNavigationBar._selectedGradient : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(
            GradientNavigationBar._itemRadius,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            coloredIcon,
            SizedBox(height: GradientNavigationBar._gap),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}
