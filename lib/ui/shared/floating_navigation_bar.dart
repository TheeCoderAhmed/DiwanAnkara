import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class FloatingNavigationBar extends StatelessWidget {
  const FloatingNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                HapticFeedback.selectionClick();
                onDestinationSelected(index);
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              height: 64,
              indicatorColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                _buildDestination(
                  context,
                  icon: LucideIcons.home,
                  label: AppLocalizations.of(context).home,
                  isSelected: currentIndex == 0,
                  isDark: isDark,
                ),
                _buildDestination(
                  context,
                  icon: LucideIcons.layoutGrid,
                  label: AppLocalizations.of(context).directory,
                  isSelected: currentIndex == 1,
                  isDark: isDark,
                ),
                _buildDestination(
                  context,
                  icon: LucideIcons.moreHorizontal,
                  label: AppLocalizations.of(context).more,
                  isSelected: currentIndex == 2,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildDestination(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    final activeColor = const Color(0xFF0D9488);
    final inactiveColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.black.withValues(alpha: 0.5);

    return NavigationDestination(
      icon: Icon(
        icon,
        color: isSelected ? activeColor : inactiveColor,
      ),
      selectedIcon: Icon(
        icon,
        color: activeColor,
      ),
      label: label,
    );
  }
}
