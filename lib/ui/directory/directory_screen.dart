import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/categories.dart';
import '../../routing/app_router.dart';
import '../shared/section_header.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class DirectoryScreen extends ConsumerWidget {
  const DirectoryScreen({super.key});

  static const _categories = <String>[
    'Universities',
    'Hospitals',
    'Malls',
    'Historic',
    'Libraries',
    'Transport',
    'Government Offices',
    'Housing',
    'Residency Guide',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).directory)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          SectionHeader(title: AppLocalizations.of(context).sections),
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
                onTap: () async {
                  // Residency Guide - Query Firestore and open file directly
                  if (cat == 'Residency Guide') {
                    try {
                      // Query for Residency category (user will update DB to use this category)
                      final snapshot = await FirebaseFirestore.instance
                          .collection('places')
                          .where('category', isEqualTo: 'الاقامة الطلابية')
                          .limit(1)
                          .get();
                      
                      if (snapshot.docs.isEmpty) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context).noResidencyGuide)),
                          );
                        }
                        return;
                      }
                      
                      final doc = snapshot.docs.first;
                      final data = doc.data();
                      
                      // CRITICAL: Check docUrl FIRST (for Word/Doc files)
                      String? fileUrl = data['document_url'] as String?;
                      if (fileUrl == null || fileUrl.isEmpty) {
                        fileUrl = data['documentUrl'] as String?;
                      }
                      
                      // ELSE check pdfUrl
                      if (fileUrl == null || fileUrl.isEmpty) {
                        fileUrl = data['pdf_url'] as String?;
                      }
                      if (fileUrl == null || fileUrl.isEmpty) {
                        fileUrl = data['pdfUrl'] as String?;
                      }
                      if (fileUrl == null || fileUrl.isEmpty) {
                        fileUrl = data['file_url'] as String?;
                      }
                      if (fileUrl == null || fileUrl.isEmpty) {
                        fileUrl = data['fileUrl'] as String?;
                      }
                      
                      if (fileUrl == null || fileUrl.isEmpty) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context).fileLinkNotAvailable)),
                          );
                        }
                        return;
                      }
                      
                      // Launch file URL immediately (do not navigate to details page)
                      final uri = Uri.parse(fileUrl);
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${AppLocalizations.of(context).error}: $e')),
                        );
                      }
                    }
                    return;
                  }

                  // Special handling for Housing - open PDF directly
                  if (cat == 'Housing') {
                    try {
                      // Try multiple category variants for housing
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
                            SnackBar(content: Text(AppLocalizations.of(context).noHousingGuide)),
                          );
                        }
                        return;
                      }
                      
                      final doc = snapshot.docs.first;
                      final data = doc.data() as Map<String, dynamic>;
                      
                      // Check multiple PDF URL keys
                      String? pdfUrl = data['pdf_url'] as String?;
                      if (pdfUrl == null || pdfUrl.isEmpty) {
                        pdfUrl = data['pdfUrl'] as String?;
                      }
                      if (pdfUrl == null || pdfUrl.isEmpty) {
                        pdfUrl = data['file_url'] as String?;
                      }
                      if (pdfUrl == null || pdfUrl.isEmpty) {
                        pdfUrl = data['fileUrl'] as String?;
                      }
                      
                      if (pdfUrl == null || pdfUrl.isEmpty) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context).pdfLinkNotAvailable)),
                          );
                        }
                        return;
                      }
                      
                      // Launch PDF URL immediately
                      final uri = Uri.parse(pdfUrl);
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${AppLocalizations.of(context).error}: $e')),
                        );
                      }
                    }
                    return;
                  }

                  final placeCategory = switch (cat) {
                    'Universities' => PlaceCategory.university,
                    'Hospitals' => PlaceCategory.hospital,
                    'Malls' => PlaceCategory.mall,
                    'Historic' => PlaceCategory.historic,
                    'Libraries' => PlaceCategory.library,
                    'Transport' => PlaceCategory.transport,
                    'Government Offices' => PlaceCategory.govOffice,
                    'Housing' => PlaceCategory.housing,
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
      'Historic' => l10n.catHistoric,
      'Libraries' => l10n.catLibrary,
      'Transport' => l10n.catTransport,
      'Government Offices' => l10n.catGovOffice,
      'Housing' => l10n.housingGuide,
      'Residency Guide' => l10n.residencyGuide,
      _ => key,
    };
  }


  static IconData _iconFor(String key) {
    return switch (key) {
      'Universities' => Icons.school_outlined,
      'Hospitals' => Icons.local_hospital_outlined,
      'Malls' => Icons.storefront_outlined,
      'Historic' => Icons.account_balance_outlined,
      'Libraries' => Icons.local_library_outlined,
      'Transport' => Icons.directions_bus_outlined,
      'Government Offices' => Icons.apartment_outlined,
      'Housing' => Icons.home_outlined,
      'Residency Guide' => Icons.picture_as_pdf_outlined,
      _ => Icons.grid_view_outlined,
    };
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 34),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


