import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/categories.dart';
import '../../routing/app_router.dart';
import '../shared/section_header.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import '../../data/firestore/firestore_providers.dart';
import '../shared/floating_navigation_bar.dart';

class DirectoryScreen extends ConsumerWidget {
  const DirectoryScreen({super.key});

  static const _categories = <String>[
    'Universities',
    'Hospitals',
    'Malls',
    'Restaurants',
    'Markets',
    'Historic',
    'Libraries',
    'Transport',
    'Government Offices',
    'Parks',
    'Activities',
    'Housing',
    'Residency Guide',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.directory)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          FloatingNavigationBar.totalHeight(context) + 16,
        ),
        children: [
          SectionHeader(title: l10n.sections, horizontalPadding: 0),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return _CategoryCard(
                title: _localizedLabel(context, cat),
                icon: _iconFor(cat),
                color: _colorFor(cat),
                onTap: () async {
                  // Residency Guide - Query from AppSettings and open file directly
                  if (cat == 'Residency Guide') {
                    try {
                      final appSettings = ref
                          .read(appSettingsProvider)
                          .valueOrNull;
                      final String? fileUrl = appSettings?.residencyGuideUrl;

                      if (fileUrl == null || fileUrl.isEmpty) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                ).fileLinkNotAvailable,
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      final uri = Uri.parse(fileUrl);
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${AppLocalizations.of(context).error}: $e',
                            ),
                          ),
                        );
                      }
                    }
                    return;
                  }

                  // Special handling for Housing - open PDF directly
                  if (cat == 'Housing') {
                    try {
                      final categoryVariants = ['دليل السكنات', 'السكنات'];
                      QuerySnapshot? snapshot;

                      for (final category in categoryVariants) {
                        snapshot = await FirebaseFirestore.instance
                            .collection('places')
                            .where('category', isEqualTo: category)
                            .limit(1)
                            .get();
                        if (snapshot.docs.isNotEmpty) break;
                      }

                      if (snapshot == null || snapshot.docs.isEmpty) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context).noHousingGuide,
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      final doc = snapshot.docs.first;
                      final data = doc.data() as Map<String, dynamic>;

                      String? pdfUrl = data['pdf_url'] as String?;
                      if (pdfUrl == null || pdfUrl.isEmpty)
                        pdfUrl = data['pdfUrl'] as String?;
                      if (pdfUrl == null || pdfUrl.isEmpty)
                        pdfUrl = data['file_url'] as String?;
                      if (pdfUrl == null || pdfUrl.isEmpty)
                        pdfUrl = data['fileUrl'] as String?;

                      if (pdfUrl == null || pdfUrl.isEmpty) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                ).pdfLinkNotAvailable,
                              ),
                            ),
                          );
                        }
                        return;
                      }

                      final uri = Uri.parse(pdfUrl);
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${AppLocalizations.of(context).error}: $e',
                            ),
                          ),
                        );
                      }
                    }
                    return;
                  }

                  final placeCategory = switch (cat) {
                    'Universities' => PlaceCategory.university,
                    'Hospitals' => PlaceCategory.hospital,
                    'Malls' => PlaceCategory.mall,
                    'Restaurants' => PlaceCategory.restaurant,
                    'Markets' => PlaceCategory.market,
                    'Historic' => PlaceCategory.historic,
                    'Libraries' => PlaceCategory.library,
                    'Transport' => PlaceCategory.transport,
                    'Government Offices' => PlaceCategory.govOffice,
                    'Housing' => PlaceCategory.housing,
                    'Parks' => PlaceCategory.parks,
                    'Activities' => PlaceCategory.activities,
                    _ => null,
                  };
                  if (placeCategory != null) {
                    context.push(
                      const PlaceListRoute().location(
                        category: placeCategory.jsonValue,
                      ),
                    );
                    return;
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static String _localizedLabel(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context);
    return switch (key) {
      'Universities' => l10n.catUniversity,
      'Hospitals' => l10n.catHospital,
      'Malls' => l10n.catMall,
      'Restaurants' => l10n.catRestaurant,
      'Markets' => l10n.catMarket,
      'Historic' => l10n.catHistoric,
      'Libraries' => l10n.catLibrary,
      'Transport' => l10n.catTransport,
      'Government Offices' => l10n.catGovOffice,
      'Housing' => l10n.housingGuide,
      'Parks' => l10n.catParks,
      'Activities' => l10n.catActivities,
      'Residency Guide' => l10n.residencyGuide,
      _ => key,
    };
  }

  // 4.1 — Lucide icon set for all categories
  static IconData _iconFor(String key) {
    return switch (key) {
      'Universities' => LucideIcons.graduationCap,
      'Hospitals' => LucideIcons.stethoscope,
      'Malls' => LucideIcons.shoppingBag,
      'Restaurants' => LucideIcons.utensils,
      'Markets' => LucideIcons.shoppingCart,
      'Historic' => LucideIcons.landmark,
      'Libraries' => LucideIcons.bookOpen,
      'Transport' => LucideIcons.bus,
      'Government Offices' => LucideIcons.building2,
      'Housing' => LucideIcons.home,
      'Parks' => LucideIcons.trees,
      'Activities' => LucideIcons.partyPopper,
      'Residency Guide' => LucideIcons.fileText,
      _ => LucideIcons.layoutGrid,
    };
  }

  // 4.2 — Category-specific accent colors
  static Color _colorFor(String key) {
    return switch (key) {
      'Universities' => const Color(0xFF6366F1), // indigo
      'Hospitals' => const Color(0xFFEF4444), // red
      'Malls' => const Color(0xFFF59E0B), // amber
      'Restaurants' => const Color(0xFFFF6B35), // orange
      'Markets' => const Color(0xFF10B981), // emerald
      'Historic' => const Color(0xFF8B5CF6), // violet
      'Libraries' => const Color(0xFF3B82F6), // blue
      'Transport' => const Color(0xFF0EA5E9), // sky
      'Government Offices' => const Color(0xFF14B8A6), // teal
      'Housing' => const Color(0xFF84CC16), // lime
      'Parks' => const Color(0xFF22C55E), // green
      'Activities' => const Color(0xFFEC4899), // pink
      'Residency Guide' => const Color(0xFFF97316), // orange-600
      _ => const Color(0xFF6B7280), // gray
    };
  }
}

// 4.2 — Colorful card with themed icon container
class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 26, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
