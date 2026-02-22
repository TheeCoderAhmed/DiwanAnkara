import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import '../../settings/theme_controller.dart';

/// The fixed interior height of the navigation bar capsule (without insets).
const double kNavBarInnerHeight = 64.0;

/// The horizontal + top margin around the floating capsule.
const double kNavBarSideMargin = 7.0;

class FloatingNavigationBar extends ConsumerWidget {
  const FloatingNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  /// Returns the total vertical space consumed by the floating nav bar on the
  /// current device, including the bottom safe-area inset.
  static double totalHeight(BuildContext context) {
    return kNavBarSideMargin +
        kNavBarInnerHeight +
        kNavBarSideMargin +
        MediaQuery.paddingOf(context).bottom;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = ref.watch(themeControllerProvider).style;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return switch (style) {
      AppStyle.paper => _PaperNavBar(
        currentIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        isDark: isDark,
        bottomInset: bottomInset,
      ),
      AppStyle.nordic => _NordicNavBar(
        currentIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        isDark: isDark,
        bottomInset: bottomInset,
      ),
      AppStyle.classic => _ClassicNavBar(
        currentIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        isDark: isDark,
        bottomInset: bottomInset,
      ),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 🌊  CLASSIC — Blurred glass pill (unchanged feel, teal active dot)
// ─────────────────────────────────────────────────────────────────────────────
class _ClassicNavBar extends StatelessWidget {
  const _ClassicNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.isDark,
    required this.bottomInset,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isDark;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      margin: EdgeInsets.fromLTRB(
        kNavBarSideMargin,
        kNavBarSideMargin,
        kNavBarSideMargin,
        kNavBarSideMargin + bottomInset,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isDark
                    ? primary.withValues(alpha: 0.18)
                    : primary.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: isDark ? 0.08 : 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: _SharedNavigationBar(
              currentIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              isDark: isDark,
              indicatorColor: primary.withValues(alpha: 0.12),
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 📰  PAPER — Flat cream newspaper footer bar, no radius, thin sepia border
// ─────────────────────────────────────────────────────────────────────────────
class _PaperNavBar extends StatelessWidget {
  const _PaperNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.isDark,
    required this.bottomInset,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isDark;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF141414) : const Color(0xFFFFFDF5);
    final borderColor =
        isDark ? const Color(0xFF2E2E2E) : const Color(0xFFDDD8C4);
    final inkPrimary =
        isDark ? const Color(0xFFE4E4E4) : const Color(0xFF1A1008);
    final accentSepia =
        isDark ? const Color(0xFFC49A6C) : const Color(0xFF8B4513);


    return Container(
      // Extend all the way to the bottom screen edge so the bar's background
      // colour fills the system gesture area (edge-to-edge compliance).
      // The content row is pushed up by bottomInset via inner padding.
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: borderColor, width: 1.5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SizedBox(
          height: kNavBarInnerHeight,
          child: Row(
            children: List.generate(4, (i) {
              final isSelected = currentIndex == i;
              final icon = _iconForIndex(i);
              final label = _labelForIndex(context, i);
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onDestinationSelected(i);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ink-dot indicator above active icon
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isSelected ? 4 : 0,
                        height: isSelected ? 4 : 0,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: accentSepia,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Icon(
                        icon,
                        size: 20,
                        color: isSelected
                            ? accentSepia
                            : inkPrimary.withValues(alpha: 0.4),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? accentSepia
                              : inkPrimary.withValues(alpha: 0.4),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ❄️  NORDIC — Borderless flat bar, rectangular underline active indicator
// ─────────────────────────────────────────────────────────────────────────────
class _NordicNavBar extends StatelessWidget {
  const _NordicNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.isDark,
    required this.bottomInset,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isDark;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF111827) : Colors.white;
    final primary = Theme.of(context).colorScheme.primary;
    final inactive = isDark
        ? Colors.white.withValues(alpha: 0.35)
        : Colors.black.withValues(alpha: 0.3);

    return Container(
      // Extend to the bottom screen edge — background colour fills the gesture
      // area. Content row sits above the inset via inner padding.
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.07)
                : Colors.black.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SizedBox(
          height: kNavBarInnerHeight,
          child: Row(
            children: List.generate(4, (i) {
              final isSelected = currentIndex == i;
              final icon = _iconForIndex(i);
              final label = _labelForIndex(context, i);

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onDestinationSelected(i);
                  },
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Rectangular underline — IDE-tab style at the TOP of the bar
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        height: 2,
                        width: isSelected ? 28.0 : 0.0,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 20,
                              color: isSelected ? primary : inactive,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w300,
                                color: isSelected ? primary : inactive,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared NavigationBar widget (used by Classic only)
// ─────────────────────────────────────────────────────────────────────────────
class _SharedNavigationBar extends StatelessWidget {
  const _SharedNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.isDark,
    required this.indicatorColor,
    required this.indicatorShape,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isDark;
  final Color indicatorColor;
  final ShapeBorder indicatorShape;

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.black.withValues(alpha: 0.5);

    NavigationDestination dest(IconData icon, String label, int index) {
      final isSelected = currentIndex == index;
      return NavigationDestination(
        icon: Icon(icon, color: isSelected ? activeColor : inactiveColor),
        selectedIcon: Icon(icon, color: activeColor),
        label: label,
      );
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(
          MediaQuery.textScalerOf(context).scale(1.0).clamp(0.8, 1.0),
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
        height: kNavBarInnerHeight,
        indicatorColor: indicatorColor,
        indicatorShape: indicatorShape,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          dest(LucideIcons.home, AppLocalizations.of(context).home, 0),
          dest(
            LucideIcons.layoutGrid,
            AppLocalizations.of(context).directory,
            1,
          ),
          dest(
            LucideIcons.calendarDays,
            AppLocalizations.of(context).eventsTab,
            2,
          ),
          dest(
            LucideIcons.moreHorizontal,
            AppLocalizations.of(context).more,
            3,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────
IconData _iconForIndex(int i) => switch (i) {
  0 => LucideIcons.home,
  1 => LucideIcons.layoutGrid,
  2 => LucideIcons.calendarDays,
  _ => LucideIcons.moreHorizontal,
};

String _labelForIndex(BuildContext context, int i) {
  final l10n = AppLocalizations.of(context);
  return switch (i) {
    0 => l10n.home,
    1 => l10n.directory,
    2 => l10n.eventsTab,
    _ => l10n.more,
  };
}
