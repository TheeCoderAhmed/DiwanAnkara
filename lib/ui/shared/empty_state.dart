import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message, this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final mutedIcon = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.35);
    final mutedText = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.45);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? LucideIcons.inbox, size: 64, color: mutedIcon),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: mutedText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
