import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lucide_icons/lucide_icons.dart';
import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../../routing/app_router.dart';
import '../shared/cached_image_widget.dart';
import 'widgets/medical_advice_modal.dart';
import 'widgets/park_advice_modal.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({super.key, required this.category});

  final String category; // jsonValue (e.g. 'gov_office', 'university')

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHospital = category == 'hospital';
    final isActivity = category == 'activities';
    
    // Special handling for universities - fetch from universities collection
    if (category == 'university') {
      final universitiesAsync = ref.watch(universitiesStreamProvider);
      
      return Scaffold(
        appBar: AppBar(title: Text(_localizedCategory(context, category))),
        body: universitiesAsync.when(
          data: (universities) {
            if (universities.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context).noUniversitiesFound),
                  ],
                ),
              );
            }
            
            return ListView.separated(
              padding: const EdgeInsets.only(bottom: 200),
              itemCount: universities.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final uni = universities[index];
                return ListTile(
                  leading: CachedImageWidget(
                    imageUrl: uni.logoUrl,
                    width: 48,
                    height: 48,
                    borderRadius: BorderRadius.circular(8),
                    errorIcon: Icons.school_outlined,
                  ),
                  title: Text(uni.name),
                  subtitle: Text(AppLocalizations.of(context).university),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to our new enriched UniversityDetailScreen
                    context.push(
                      const UniversityDetailsRoute().location(id: uni.id),
                      extra: uni,
                    );
                  },
                );
              },
            );
          },
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('${AppLocalizations.of(context).error}: $e'),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      );
    }
    
    // Use Firestore stream for live data (for all other categories)
    final placesAsync = ref.watch(placesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_localizedCategory(context, category)),
        actions: [
          if (isHospital)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: () => MedicalAdviceModal.show(context),
                borderRadius: BorderRadius.circular(8),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'معلومة',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF0D9488),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(LucideIcons.info, size: 20, color: Color(0xFF0D9488)),
                  ],
                ),
              ),
            ),
          if (isActivity)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: () => ParkAdviceModal.show(context),
                borderRadius: BorderRadius.circular(8),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'معلومة',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF0D9488),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(LucideIcons.info, size: 20, color: Color(0xFF0D9488)),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: placesAsync.when(
        data: (places) {
          // Filter places by category
          // ALSO: Filter out the 'medical_advice' entry from the list as it's now in the header icon
          final filteredPlaces = places
              .where((p) => p.category.jsonValue == category && p.id != 'medical_advice')
              .toList();
          
          if (filteredPlaces.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(AppLocalizations.of(context).noItemsInSection),
                ],
              ),
            );
          }
          
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 200),
            itemCount: filteredPlaces.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final p = filteredPlaces[index];
              return ListTile(
                leading: _buildLeadingImage(p.imageAsset, p.pdfUrl != null),
                title: Text(p.nameTr),
                subtitle: Text(
                  p.descriptionAr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  // Special handling for housing category - open PDF directly
                  if (category == 'housing' && p.pdfUrl != null && p.pdfUrl!.isNotEmpty) {
                    final uri = Uri.parse(p.pdfUrl!);
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    // Normal navigation to details screen
                    context.push(const PlaceDetailsRoute().location(id: p.id));
                  }
                },
              );
            },
          );
        },
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('${AppLocalizations.of(context).error}: $e'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  /// Maps route category parameter to localized display name
  static String _localizedCategory(BuildContext context, String c) {
    final cat = PlaceCategoryX.fromJsonValue(c);
    if (cat == PlaceCategory.other) return c;
    return cat.getLabel(context);
  }

  /// Builds a leading image widget for the list tile.
  /// Shows network image, asset image, or placeholder icon.
  Widget _buildLeadingImage(String imageAsset, bool isPdfItem) {
    return CachedImageWidget(
      imageUrl: imageAsset,
      width: 48,
      height: 48,
      borderRadius: BorderRadius.circular(8),
      errorIcon: isPdfItem ? Icons.description_outlined : Icons.place_outlined,
    );
  }
}


