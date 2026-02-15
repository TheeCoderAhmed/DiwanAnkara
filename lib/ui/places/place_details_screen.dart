import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../../domain/models/place.dart';
import '../../services/favorites_provider.dart';
import '../shared/cached_image_widget.dart';
import '../widgets/public_review_section.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import '../../services/translation_service.dart';

class PlaceDetailsScreen extends ConsumerStatefulWidget {
  const PlaceDetailsScreen({super.key, required this.placeId});

  final String placeId;

  @override
  ConsumerState<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends ConsumerState<PlaceDetailsScreen> {
  bool _isDescriptionExpanded = false;
  static const int _maxDescriptionLines = 4;
  
  String? _translatedDescription;
  bool _isTranslating = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _translateDescription();
  }
  
  Future<void> _translateDescription() async {
    final placesAsync = ref.read(placesStreamProvider);
    
    // Simple check to find current place - ideally pass Place object or use provider family
    placesAsync.whenData((places) {
       final place = places.where((p) => p.id == widget.placeId).firstOrNull;
       if (place == null) return;
       
       final currentLocale = Localizations.localeOf(context).languageCode;
       
       // Only translate if not Arabic (source) and not already translated
       // And strictly if the description is Arabic (which we assume for descriptionAr)
       if (currentLocale != 'ar' && _translatedDescription == null) {
          setState(() {
             _isTranslating = true;
          });
          
          TranslationService().translate(place.descriptionAr, currentLocale).then((result) {
             if (mounted) {
                setState(() {
                   _translatedDescription = result;
                   _isTranslating = false;
                });
             }
          });
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    final placesAsync = ref.watch(placesStreamProvider);
    final universitiesAsync = ref.watch(universitiesStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Check if this is a university ID
    final isUniversityId = widget.placeId.startsWith('uni_');

    if (isUniversityId) {
      // Handle university details
      return universitiesAsync.when(
        data: (universities) {
          // Find university by matching ID hash
          final uni = universities.firstWhere(
            (u) => 'uni_${u.name.hashCode}' == widget.placeId,
            orElse: () => universities.isNotEmpty ? universities.first : throw Exception('No university found'),
          );
          
          // Convert to Place object
          final documents = <PlaceDocument>[];
          
          debugPrint("=== University Details ===");
          debugPrint("Name: ${uni.name}");
          debugPrint("Logo URL raw value: '${uni.logoUrl}'");
          debugPrint("Logo URL is null: ${uni.logoUrl == null}");
          debugPrint("Logo URL isEmpty: ${uni.logoUrl?.isEmpty}");
          debugPrint("Logo URL starts with http: ${uni.logoUrl?.startsWith('http')}");
          debugPrint("Introduction Doc URL: ${uni.introductionDocUrl}");
          debugPrint("Bachelor Doc URL: ${uni.bachelorDocUrl}");
          debugPrint("Associate Doc URL: ${uni.associateDocUrl}");
          
          if (uni.introductionDocUrl != null && uni.introductionDocUrl!.isNotEmpty) {
            documents.add(PlaceDocument(
            title: AppLocalizations.of(context).universityIntroduction,
              filePath: uni.introductionDocUrl!,
            ));
            debugPrint("✓ Added introduction document");
          }
          
          if (uni.bachelorDocUrl != null && uni.bachelorDocUrl!.isNotEmpty) {
            documents.add(PlaceDocument(
              title: AppLocalizations.of(context).bachelorPrograms,
              filePath: uni.bachelorDocUrl!,
            ));
            debugPrint("✓ Added bachelor document");
          }
          
          if (uni.associateDocUrl != null && uni.associateDocUrl!.isNotEmpty) {
            documents.add(PlaceDocument(
              title: AppLocalizations.of(context).associatePrograms,
              filePath: uni.associateDocUrl!,
            ));
            debugPrint("✓ Added associate document");
          }
          
          debugPrint("Total documents created: ${documents.length}");
          
          final place = Place(
            id: widget.placeId,
            category: PlaceCategory.university,
            nameTr: uni.name,
            descriptionAr: AppLocalizations.of(context).universityInTurkey,
            lat: 0,
            lng: 0,
            imageAsset: uni.logoUrl ?? '',
            isPopular: false,
            // Do NOT map single fields to avoid duplicates in UI
            // pdfUrl: uni.introductionDocUrl, 
            // docUrl: uni.bachelorDocUrl,     
            documents: documents,
          );
          
          return _buildPlaceDetails(context, place, isDark);
        },
        error: (e, _) => Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context).university)),
          body: Center(
            child: Text(
              '${AppLocalizations.of(context).error}: $e',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return placesAsync.when(
      data: (places) {
        var place = places.where((p) => p.id == widget.placeId).firstOrNull;
        if (place == null) {
          return Scaffold(
            body: Center(
              child: Text(
                AppLocalizations.of(context).placeNotFound,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        }

        // Special handling for 'About'/Who We Are:
        // Merge sibling 'about' items (which represent files/guides) into the main place's documents
        if (place.category == PlaceCategory.about) {
           final otherDocs = places.where((p) => 
               p.category == PlaceCategory.about && 
               p.id != place!.id &&
               ((p.pdfUrl != null && p.pdfUrl!.isNotEmpty) || (p.docUrl != null && p.docUrl!.isNotEmpty))
           );
           
           if (otherDocs.isNotEmpty) {
             final extraDocuments = otherDocs.map((p) => PlaceDocument(
               title: p.nameTr,
               filePath: p.pdfUrl ?? p.docUrl ?? '',
             )).toList();
             
             // Create a new Place instance with the merged documents
             place = Place(
               id: place.id,
               category: place.category,
               nameTr: place.nameTr,
               descriptionAr: place.descriptionAr,
               lat: place.lat,
               lng: place.lng,
               imageAsset: place.imageAsset,
               isPopular: place.isPopular,
               documents: [...place.documents, ...extraDocuments],
               pdfUrl: place.pdfUrl,
               docUrl: place.docUrl,
               mapsLink: place.mapsLink,
               order: place.order,
             );
           }
        }

        return _buildPlaceDetails(context, place, isDark);
      },
      error: (e, _) => Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).place)),
        body: Center(
          child: Text(
            '${AppLocalizations.of(context).error}: $e',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildPlaceDetails(BuildContext context, Place place, bool isDark) {
    final favorites = ref.watch(favoritesProvider);
    final isSaved = favorites.contains(place.id);

    return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Parallax SliverAppBar
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                stretch: true,
                backgroundColor: isDark ? Colors.black : Colors.white,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      LucideIcons.arrowRight,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        LucideIcons.heart,
                        color: isSaved ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        ref.read(favoritesProvider.notifier).toggleFavorite(place.id);
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    place.nameTr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(left: 16, right: 56, bottom: 16),
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Hero(
                    tag: 'place_image_${place.id}',
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        place.imageAsset.isNotEmpty && place.imageAsset.startsWith('http')
                            ? CachedImageWidget(
                                imageUrl: place.imageAsset,
                                fit: place.category == PlaceCategory.project ? BoxFit.contain : BoxFit.cover,
                              )
                            : place.imageAsset.isNotEmpty
                                ? Image.asset(
                                    place.imageAsset,
                                    fit: place.category == PlaceCategory.project ? BoxFit.contain : BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _buildImagePlaceholder(place.pdfUrl != null),
                                  )
                                : _buildImagePlaceholder(place.pdfUrl != null),
                        // Bottom gradient for text readability (Hide for projects as they are flyers/logos)
                        if (place.category != PlaceCategory.project)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                                stops: const [0.5, 1.0],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          place.category.getLabel(context),
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: const Color(0xFF0D9488),
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        place.nameTr,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                      ),
                      const SizedBox(height: 16),

                      // Description with fade effect
                      _isTranslating 
                          ? const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : _buildDescription(context, _translatedDescription ?? place.descriptionAr, isDark),
                      const SizedBox(height: 24),

                      // Navigate button (use mapsLink if available, otherwise use coords)
                      if (place.mapsLink != null || (place.lat != 0 && place.lng != 0))
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () async {
                              HapticFeedback.mediumImpact();
                              final Uri uri;
                              if (place.mapsLink != null && place.mapsLink!.isNotEmpty) {
                                uri = Uri.parse(place.mapsLink!);
                              } else {
                                uri = Uri.parse(
                                  'https://www.google.com/maps/search/?api=1&query=${place.lat},${place.lng}',
                                );
                              }
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(LucideIcons.navigation),
                            label: Text(AppLocalizations.of(context).navigate),
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF0D9488),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: 24),

                      // Documents Section (Unified)
                      _buildDocuments(context, place),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Public Review Section
              SliverToBoxAdapter(
                child: PublicReviewSection(
                  targetId: place.id,
                  targetType: place.category.jsonValue,
                  targetName: place.nameTr,
                ),
              ),

              // Extra bottom padding for better scrollability
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        );
      }

  Widget _buildDocuments(BuildContext context, Place place) {
    // 1. Check for Single Files (The New Logic) - Relaxed & Debugged
    final docUrl = place.docUrl?.trim();
    final pdfUrl = place.pdfUrl?.trim();

    // Debug prints to verify data arrival
    if (docUrl != null) debugPrint("Doc URL: $docUrl");
    if (pdfUrl != null) debugPrint("PDF URL: $pdfUrl");
    debugPrint("Documents List Count: ${place.documents.length}");
    for (var doc in place.documents) {
      debugPrint("  - Document: ${doc.title} -> ${doc.filePath}");
    }

    final bool hasPdf = pdfUrl != null && pdfUrl.isNotEmpty;
    final bool hasDoc = docUrl != null && docUrl.isNotEmpty;
    // 2. Check for List (The Old Logic - kept just in case)
    final bool hasList = place.documents.isNotEmpty;

    if (!hasPdf && !hasDoc && !hasList) {
      debugPrint("NO DOCUMENTS FOUND - All sources empty");
      return const SizedBox.shrink(); // Hide completely if empty
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
             AppLocalizations.of(context).attachedDocuments,
            style: const TextStyle(
              fontFamily: 'Cairo', // User requested Cairo
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Button for PDF Link
        if (hasPdf)
          _buildDocTile(AppLocalizations.of(context).pdfFile, LucideIcons.fileText, Colors.red, place.pdfUrl!),
        // Button for Word Link (Universities use this!)
        if (hasDoc)
          _buildDocTile(AppLocalizations.of(context).introductoryDocument, LucideIcons.file, Colors.blue, place.docUrl!),
        // List items (if any exist in the list)
        ...place.documents.map((doc) =>
            _buildDocTile(doc.title, LucideIcons.file, Colors.orange, doc.filePath)),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDocTile(String title, IconData icon, Color color, String url) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontFamily: 'Cairo')), // User requested Cairo
        trailing: const Icon(LucideIcons.download, size: 20),
        onTap: () async {
          final uri = Uri.parse(url);
          try {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } catch (e) {
            debugPrint('Could not launch $url: $e');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context).cannotOpenFile(e.toString()))),
            );
          }
        },
      ),
    );
  }

  Widget _buildDescription(BuildContext context, String description, bool isDark) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          height: 1.6,
          color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black.withValues(alpha: 0.8),
        );

    // Short description - no fade needed
    if (description.length < 200 || _isDescriptionExpanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description, style: textStyle),
          if (description.length >= 200)
            TextButton(
              onPressed: () {
                HapticFeedback.selectionClick();
                setState(() => _isDescriptionExpanded = false);
              },
              child: Text(AppLocalizations.of(context).showLess),
            ),
        ],
      );
    }

    // Long description with fade effect
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withValues(alpha: 0),
            ],
            stops: const [0.7, 1.0],
          ).createShader(bounds),
          blendMode: BlendMode.dstIn,
          child: Text(
            description,
            style: textStyle,
            maxLines: _maxDescriptionLines,
            overflow: TextOverflow.clip,
          ),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.selectionClick();
            setState(() => _isDescriptionExpanded = true);
          },
          child: Text(AppLocalizations.of(context).readMore),
        ),
      ],
    );
  }

  /// Builds a placeholder when no image is available.
  /// Shows document icon if the item is a PDF-only entry.
  Widget _buildImagePlaceholder(bool isPdfItem) {
    return Container(
      color: const Color(0xFF1E293B),
      child: Center(
        child: Icon(
          isPdfItem ? LucideIcons.fileText : LucideIcons.image,
          color: Colors.white54,
          size: 48,
        ),
      ),
    );
  }
}


