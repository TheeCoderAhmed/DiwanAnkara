import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../../domain/models/place.dart';
import '../../routing/app_router.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({super.key, required this.category});

  final String category; // jsonValue (e.g. 'gov_office', 'university')

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              itemCount: universities.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final uni = universities[index];
                return ListTile(
                  leading: uni.logoUrl != null && uni.logoUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            uni.logoUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildPlaceholder(false),
                          ),
                        )
                      : _buildPlaceholder(false),
                  title: Text(uni.name),
                  subtitle: Text(AppLocalizations.of(context).university),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Convert UniversityModel to Place for navigation
                    final documents = <PlaceDocument>[];
                    
                    // Add introduction document if available
                    if (uni.introductionDocUrl != null && uni.introductionDocUrl!.isNotEmpty) {
                      documents.add(PlaceDocument(
                        title: AppLocalizations.of(context).universityIntroduction,
                        filePath: uni.introductionDocUrl!,
                      ));
                    }
                    
                    // Add bachelor document if available
                    if (uni.bachelorDocUrl != null && uni.bachelorDocUrl!.isNotEmpty) {
                      documents.add(PlaceDocument(
                        title: AppLocalizations.of(context).bachelorPrograms,
                        filePath: uni.bachelorDocUrl!,
                      ));
                    }
                    
                    // Add associate document if available
                    if (uni.associateDocUrl != null && uni.associateDocUrl!.isNotEmpty) {
                      documents.add(PlaceDocument(
                        title: AppLocalizations.of(context).associatePrograms,
                        filePath: uni.associateDocUrl!,
                      ));
                    }
                    
                    final place = Place(
                      id: 'uni_${uni.name.hashCode}',
                      category: PlaceCategory.university,
                      nameTr: uni.name,
                      descriptionAr: AppLocalizations.of(context).universityInTurkey,
                      lat: 0,
                      lng: 0,
                      imageAsset: uni.logoUrl ?? '',
                      isPopular: false,
                      documents: documents,
                    );
                    
                    // Navigate to details screen
                    context.push(const PlaceDetailsRoute().location(id: place.id));
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
      appBar: AppBar(title: Text(_localizedCategory(context, category))),
      body: placesAsync.when(
        data: (places) {
          // Filter places by category (comparing enum jsonValue to route param)
          final filteredPlaces = places
              .where((p) => p.category.jsonValue == category)
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
    if (imageAsset.isNotEmpty && imageAsset.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageAsset,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(isPdfItem),
        ),
      );
    } else if (imageAsset.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imageAsset,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(isPdfItem),
        ),
      );
    }
    return _buildPlaceholder(isPdfItem);
  }

  Widget _buildPlaceholder(bool isPdfItem) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        isPdfItem ? Icons.description_outlined : Icons.place_outlined,
        color: const Color(0xFF1E293B),
      ),
    );
  }
}


