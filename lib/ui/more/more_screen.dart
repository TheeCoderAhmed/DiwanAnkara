import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../app/app_constants.dart';
import '../../routing/app_router.dart';
import '../../settings/theme_controller.dart';
import '../../settings/locale_controller.dart';
import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../places/place_details_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../services/translation_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/floating_navigation_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
    final themeMode = themeState.mode;
    final currentLocale = ref.watch(localeControllerProvider);
    final placesAsync = ref.watch(placesStreamProvider);
    final l10n = AppLocalizations.of(context);

    final appSettingsAsync = ref.watch(appSettingsProvider);
    final safetyEmail =
        appSettingsAsync.valueOrNull?.safetyEmail ?? 'ahm3dbusinesss@gmail.com';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.more)),
      body: Builder(
        builder: (context) {
          final sp = AppSpacing.of(context);
          return ListView(
            padding: EdgeInsets.fromLTRB(
              sp.screenPadding,
              8,
              sp.screenPadding,
              FloatingNavigationBar.totalHeight(context) + 16,
            ),
            children: [
              // ── General ──────────────────────────────────────────────
              _SectionLabel(label: l10n.general),
              _MoreItem(
                icon: LucideIcons.bookmark,
                title: l10n.savedPlaces,
                subtitle: l10n.savedPlacesSubtitle,
                onTap: () => context.push(const SavedPlacesRoute().location),
              ),
              const SizedBox(height: 8),
              _MoreItem(
                icon: LucideIcons.info,
                title: l10n.aboutUs,
                subtitle: l10n.aboutUsSubtitle,
                onTap: () {
                  final places = placesAsync.valueOrNull ?? [];
                  final aboutPlace = places
                      .where((p) => p.category == PlaceCategory.about)
                      .firstOrNull;

                  if (aboutPlace != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PlaceDetailsScreen(placeId: aboutPlace.id),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(l10n.loadingData)));
                  }
                },
              ),

              // ── Community ─────────────────────────────────────────────
              _SectionLabel(label: l10n.community),
              _MoreItem(
                icon: LucideIcons.heart,
                title: l10n.supportUs,
                subtitle: l10n.supportUsSubtitle,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const _SupportDialog(),
                  );
                },
              ),
              const SizedBox(height: 8),
              _MoreItem(
                icon: LucideIcons.users,
                title: l10n.committees,
                subtitle: l10n.committeesSubtitle,
                onTap: () =>
                    context.push(const ContributorsTimelineRoute().location),
              ),
              const SizedBox(height: 8),
              _MoreItem(
                icon: LucideIcons.shield,
                title: l10n.oversight,
                subtitle: l10n.oversightSubtitle,
                onTap: () => context.push(
                  const OversightCommitteesTimelineRoute().location,
                ),
              ),

              // ── Support ───────────────────────────────────────────────
              _SectionLabel(label: l10n.support),
              _MoreItem(
                icon: LucideIcons.alertTriangle,
                title: l10n.reportSafetyConcern,
                subtitle: l10n.reportSafetyConcernSubtitle,
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: safetyEmail,
                    query: 'subject=Report Safety Concern / إبلاغ عن مشكلة',
                  );
                  try {
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not launch email client'),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    // Ignore
                  }
                },
              ),
              const SizedBox(height: 8),
              _MoreItem(
                icon: _getThemeIcon(themeMode),
                title: l10n.appearance,
                subtitle: _getThemeLabel(context, themeMode),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    builder: (_) =>
                        _ThemeSelectionBottomSheet(currentState: themeState),
                  );
                },
              ),
              const SizedBox(height: 8),
              _MoreItem(
                icon: LucideIcons.globe,
                title: l10n.language,
                subtitle: _getLocaleLabel(currentLocale),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    builder: (_) => _LocaleSelectionBottomSheet(
                      currentLocale: currentLocale,
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final packageInfo = snapshot.data!;
                    return Center(
                      child: Text(
                        '${l10n.version}: ${packageInfo.version} (${packageInfo.buildNumber})',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

// 5.2 — Section label widget for grouping More screen items
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
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
              // 5.1 — Lucide icon with primary tint container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
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
                    ? LucideIcons.chevronLeft
                    : LucideIcons.chevronRight,
                size: 18,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportDialog extends ConsumerWidget {
  const _SupportDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);

    return settingsAsync.when(
      data: (settings) => _buildContent(context, settings.iban),
      loading: () => const _LoadingDialog(),
      error: (_, __) => _buildContent(context, 'TR330006100519786457841326'),
    );
  }

  Widget _buildContent(BuildContext context, String iban) {
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
          SelectableText(iban),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: iban));
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(l10n.copiedIban)));
              }
            },
            icon: const Icon(LucideIcons.copy, size: 18),
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

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [CircularProgressIndicator()],
      ),
    );
  }
}

class _ThemeSelectionBottomSheet extends ConsumerWidget {
  const _ThemeSelectionBottomSheet({required this.currentState});

  final ThemeState currentState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                l10n.selectTheme,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            RadioGroup<ThemeMode>(
              groupValue: currentState.mode,
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeControllerProvider.notifier).setThemeMode(mode);
                  Navigator.of(context).pop();
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    title: Text(l10n.system),
                    subtitle: Text(l10n.themeFollowSystem),
                    secondary: const Icon(LucideIcons.monitorSmartphone),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    title: Text(l10n.light),
                    subtitle: Text(l10n.themeAlwaysLight),
                    secondary: const Icon(LucideIcons.sun),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    title: Text(l10n.dark),
                    subtitle: Text(l10n.themeAlwaysDark),
                    secondary: const Icon(LucideIcons.moon),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('نمط التصميم'),
              subtitle: Text(switch (currentState.style) {
                AppStyle.classic => 'كلاسيكي',
                AppStyle.paper => 'ورق وحبر',
                AppStyle.nordic => 'نورديك',
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StyleChip(style: AppStyle.classic, label: 'كلاسيكي'),
                _StyleChip(style: AppStyle.paper, label: 'ورق وحبر'),
                _StyleChip(style: AppStyle.nordic, label: 'نورديك'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _StyleChip extends ConsumerWidget {
  final AppStyle style;
  final String label;

  const _StyleChip({required this.style, required this.label});

  // 5.3 — Preview palette for each style
  static const _palettes = {
    AppStyle.classic: [Color(0xFF0D9488), Color(0xFF06B6D4), Color(0xFF8B5CF6)],
    AppStyle.paper: [Color(0xFF6B4C35), Color(0xFF8B7355), Color(0xFFD4B896)],
    AppStyle.nordic: [Color(0xFF4A6FA5), Color(0xFF6B8CAE), Color(0xFFB8CCD8)],
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStyle = ref.watch(themeControllerProvider).style;
    final isSelected = currentStyle == style;
    final palette = _palettes[style] ?? [];
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () => ref.read(themeControllerProvider.notifier).setStyle(style),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? primary : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? primary.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Color swatch dots
            Row(
              mainAxisSize: MainAxisSize.min,
              children: palette
                  .map(
                    (c) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primary : null,
              ),
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
            // 5.4 — Flag emojis for language options
            RadioListTile<String>(
              value: 'system',
              title: Text(l10n.system),
              subtitle: Text(l10n.themeFollowSystem),
              secondary: const Text('⚙️', style: TextStyle(fontSize: 24)),
            ),
            RadioListTile<String>(
              value: 'ar',
              title: Text(l10n.arabic),
              secondary: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
            ),
            RadioListTile<String>(
              value: 'en',
              title: Text(l10n.english),
              secondary: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
            ),
            RadioListTile<String>(
              value: 'tr',
              title: Text(l10n.turkish),
              secondary: const Text('🇹🇷', style: TextStyle(fontSize: 24)),
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
    ThemeMode.system => LucideIcons.monitorSmartphone,
    ThemeMode.light => LucideIcons.sun,
    ThemeMode.dark => LucideIcons.moon,
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
  if (locale == null) return 'System';
  return switch (locale.languageCode) {
    'ar' => '🇸🇦 العربية',
    'en' => '🇬🇧 English',
    'tr' => '🇹🇷 Türkçe',
    _ => locale.languageCode,
  };
}
