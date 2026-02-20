import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class ParkAdviceModal extends StatelessWidget {
  const ParkAdviceModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ParkAdviceModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(75),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.palmtree,
                      color: const Color(0xFF0D9488),
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.parkAdvices,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildAdviceItem(
                  context,
                  LucideIcons.thermometerSun,
                  l10n.seasonalRules,
                  l10n.seasonalRulesContent,
                ),
                _buildAdviceItem(
                  context,
                  LucideIcons.flame,
                  l10n.fuelTypes,
                  l10n.fuelTypesContent,
                ),
                _buildAdviceItem(
                  context,
                  LucideIcons.clock,
                  l10n.arrivalTime,
                  l10n.arrivalTimeContent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceItem(
    BuildContext context,
    IconData icon,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF0D9488)),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
