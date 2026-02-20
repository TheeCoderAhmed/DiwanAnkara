import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/theme_controller.dart';
import 'fluid_shader_background.dart';
import 'neumorphic_background.dart';
import 'nordic_background.dart';
import 'paper_background.dart';

/// Clean ambient background that responds to AppStyle and ThemeMode.
class AmbientBackground extends ConsumerWidget {
  const AmbientBackground({
    super.key,
    required this.child,
    this.scrollOffset = 0.0,
  });

  final Widget child;

  /// Scroll offset for parallax effect in light mode (0.0 = top of page)
  final double scrollOffset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
    final isLight =
        themeState.mode == ThemeMode.light ||
        (themeState.mode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.light);

    return Stack(
      children: [
        // Background layer based on style
        _buildBackground(context, themeState, isLight),

        // Content
        child,
      ],
    );
  }

  Widget _buildBackground(
    BuildContext context,
    ThemeState themeState,
    bool isLight,
  ) {
    return switch (themeState.style) {
      AppStyle.classic =>
        isLight
            ? NeumorphicBackground(scrollOffset: scrollOffset)
            : FluidShaderBackground(scrollOffset: scrollOffset),
      AppStyle.paper => PaperBackground(scrollOffset: scrollOffset),
      AppStyle.nordic => NordicBackground(scrollOffset: scrollOffset),
    };
  }
}
