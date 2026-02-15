import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';
import '../../settings/theme_controller.dart';
import '../../settings/locale_controller.dart';
import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../places/place_details_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../services/translation_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final currentLocale = ref.watch(localeControllerProvider);
    final placesAsync = ref.watch(placesStreamProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.more),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          _MoreItem(
            icon: Icons.bookmark_outline,
            title: l10n.savedPlaces,
            subtitle: l10n.savedPlacesSubtitle,
            onTap: () {
              context.push(const SavedPlacesRoute().location);
            },
          ),
          const SizedBox(height: 12),
          _MoreItem(
            icon: Icons.info_outline,
            title: l10n.aboutUs,
            subtitle: l10n.aboutUsSubtitle,
            onTap: () {
              final places = placesAsync.valueOrNull ?? [];
              final aboutPlace = places.where((p) => p.category == PlaceCategory.about).firstOrNull;
              
              if (aboutPlace != null) {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceDetailsScreen(placeId: aboutPlace.id),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.loadingData)),
                );
              }
            },
          ),
          const SizedBox(height: 12),
          _MoreItem(
            icon: Icons.favorite_outline,
            title: l10n.supportUs,
            subtitle: l10n.supportUsSubtitle,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const _SupportDialog(),
              );
            },
          ),
          const SizedBox(height: 12),
          _MoreItem(
            icon: Icons.people_outline,
            title: l10n.committees,
            subtitle: l10n.committeesSubtitle,
            onTap: () {
              context.push(const ContributorsTimelineRoute().location);
            },
          ),
          const SizedBox(height: 12),
          _MoreItem(
            icon: Icons.shield_outlined,
            title: l10n.oversight,
            subtitle: l10n.oversightSubtitle,
            onTap: () {
              context.push(const OversightCommitteesTimelineRoute().location);
            },
          ),
          const SizedBox(height: 12),
          _MoreItem(
            icon: Icons.report_outlined,
            title: l10n.reportSafetyConcern,
            subtitle: l10n.reportSafetyConcernSubtitle,
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'ahm3dbusinesss@gmail.com',
                query: 'subject=Report Safety Concern / إبلاغ عن مشكلة أمان',
              );
              try {
                if (await canLaunchUrl(emailLaunchUri)) {
                   await launchUrl(emailLaunchUri);
                } else {
                   if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not launch email client')),
                    );
                   }
                }
              } catch (e) {
                 // Ignore
              }
            },
          ),
          const SizedBox(height: 12),
          _MoreItem(
            icon: _getThemeIcon(themeMode),
            title: l10n.appearance,
            subtitle: _getThemeLabel(context, themeMode),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => _ThemeSelectionBottomSheet(currentMode: themeMode),
              );
            },
          ),
           const SizedBox(height: 12),
          _MoreItem(
            icon: Icons.language,
            title: l10n.language,
            subtitle: _getLocaleLabel(currentLocale),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => _LocaleSelectionBottomSheet(currentLocale: currentLocale),
              );
            },
          ),

        ],
      ),
    );
  }
}

class _MoreItem extends StatelessWidget {
  const _MoreItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_left
                    : Icons.chevron_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportDialog extends StatelessWidget {
  const _SupportDialog();

  @override
  Widget build(BuildContext context) {
    const iban = 'TR330006100519786457841326'; // Example IBAN
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.supportUs),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.supportDesc),
          const SizedBox(height: 16),
          const Text('IBAN:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const SelectableText(iban),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              await Clipboard.setData(const ClipboardData(text: iban));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.copiedIban)),
                );
              }
            },
            icon: const Icon(Icons.copy),
            label: Text(l10n.copy),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
    );
  }
}

class _ThemeSelectionBottomSheet extends ConsumerWidget {
  const _ThemeSelectionBottomSheet({required this.currentMode});
  
  final ThemeMode currentMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
        child: RadioGroup<ThemeMode>(
          groupValue: currentMode,
          onChanged: (mode) {
            if (mode != null) {
              ref.read(themeControllerProvider.notifier).setThemeMode(mode);
              Navigator.of(context).pop();
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  l10n.selectTheme,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 16),
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                title: Text(l10n.system),
                subtitle: Text(l10n.themeFollowSystem),
                secondary: const Icon(Icons.brightness_auto),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                title: Text(l10n.light),
                subtitle: Text(l10n.themeAlwaysLight),
                secondary: const Icon(Icons.light_mode),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                title: Text(l10n.dark),
                subtitle: Text(l10n.themeAlwaysDark),
                secondary: const Icon(Icons.dark_mode),
              ),
            ],
          ),
        ),
    );
  }
}

class _LocaleSelectionBottomSheet extends ConsumerWidget {
  const _LocaleSelectionBottomSheet({required this.currentLocale});
  
  final Locale? currentLocale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: RadioGroup<String>(
        groupValue: currentLocale?.languageCode ?? 'system',
        onChanged: (code) {
          if (code != null) {
            final locale = code == 'system' ? null : Locale(code);
            ref.read(localeControllerProvider.notifier).setLocale(locale);
            Navigator.of(context).pop();

            // Check/Download translation model if not system and not Arabic
            if (code != 'system' && code != 'ar') {
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.downloadingLanguageModel)),
               );
               
               TranslationService().downloadModel(code).then((success) {
                 if (context.mounted && success) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(l10n.languageModelDownloaded)),
                   );
                 }
               });
            }
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                l10n.selectLanguage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              value: 'system',
              title: Text(l10n.system),
              subtitle: Text(l10n.themeFollowSystem),
              secondary: const Icon(Icons.brightness_auto),
            ),
            RadioListTile<String>(
              value: 'ar',
              title: Text(l10n.arabic),
              secondary: const Icon(Icons.language),
            ),
            RadioListTile<String>(
              value: 'en',
              title: Text(l10n.english),
              secondary: const Icon(Icons.language),
            ),
            RadioListTile<String>(
              value: 'tr',
              title: Text(l10n.turkish),
              secondary: const Icon(Icons.language),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper functions for theme display
IconData _getThemeIcon(ThemeMode mode) {
  return switch (mode) {
    ThemeMode.system => Icons.brightness_auto,
    ThemeMode.light => Icons.light_mode,
    ThemeMode.dark => Icons.dark_mode,
  };
}

String _getThemeLabel(BuildContext context, ThemeMode mode) {
  final l10n = AppLocalizations.of(context);
  return switch (mode) {
    ThemeMode.system => l10n.system,
    ThemeMode.light => l10n.light,
    ThemeMode.dark => l10n.dark,
  };
}

String _getLocaleLabel(Locale? locale) {
  if (locale == null) return 'System'; // Or l10n.system if passed l10n
  return switch (locale.languageCode) {
    'ar' => 'العربية',
    'en' => 'English',
    'tr' => 'Türkçe',
    _ => locale.languageCode,
  };
}


