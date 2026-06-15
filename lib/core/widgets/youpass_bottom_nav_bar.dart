import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';

class YouPassBottomNavDestination {
  const YouPassBottomNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badgeCount = 0,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int badgeCount;
}

class YouPassBottomNavBar extends StatelessWidget {
  const YouPassBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final List<YouPassBottomNavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? const Color(0xFF141414)
        : AppColors.profileCardBackground;
    final borderColor =
        isDark ? const Color(0xFF2A2A2A) : AppColors.homeDividerGrey;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor)),
        boxShadow: [
          BoxShadow(
            color: AppColors.scrimBase.withValues(alpha: isDark ? 0.35 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
          child: Row(
            children: [
              for (var index = 0; index < destinations.length; index++)
                Expanded(
                  child: _YouPassBottomNavItem(
                    destination: destinations[index],
                    isSelected: selectedIndex == index,
                    onTap: () => onDestinationSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _YouPassBottomNavItem extends StatelessWidget {
  const _YouPassBottomNavItem({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final YouPassBottomNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor =
        isDark ? AppColors.homeAccentYellow : AppColors.primaryMustard;
    final inactiveColor =
        isDark ? const Color(0xFF8A8A8A) : AppColors.secondaryGrey;
    final activeBackground = isDark
        ? AppColors.homeAccentYellow.withValues(alpha: 0.14)
        : AppColors.drawerMenuHighlight;
    final labelColor =
        isSelected ? (isDark ? Colors.white : AppColors.homeBlack) : inactiveColor;

    return Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? activeBackground : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      isSelected ? destination.selectedIcon : destination.icon,
                      size: 24,
                      color: isSelected ? activeColor : inactiveColor,
                    ),
                    if (destination.badgeCount > 0)
                      Positioned(
                        right: -10,
                        top: -4,
                        child: _NavBadge(count: destination.badgeCount),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  destination.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: labelColor,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBadge extends StatelessWidget {
  const _NavBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final displayCount = count > 9 ? '9+' : '$count';

    return Container(
      constraints: const BoxConstraints(minWidth: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.favoriteActive,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.backgroundWhite, width: 1.5),
      ),
      child: Text(
        displayCount,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
    );
  }
}
