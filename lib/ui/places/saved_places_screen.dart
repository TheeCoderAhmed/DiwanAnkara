import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../../routing/app_router.dart';
import '../../services/favorites_provider.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import '../shared/ambient_background.dart';
import '../shared/empty_state.dart';

class SavedPlacesScreen extends ConsumerWidget {
  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesStreamProvider);
    final savedIds = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).savedPlaces),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AmbientBackground(
        child: placesAsync.when(
          data: (allPlaces) {
            // Filter places to show only saved ones
            final savedPlaces = allPlaces
                .where((place) => savedIds.contains(place.id))
                .toList();

            if (savedPlaces.isEmpty) {
              return EmptyState(
                message: AppLocalizations.of(context).noSavedPlaces,
                icon: LucideIcons.heartOff,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedPlaces.length,
              itemBuilder: (context, index) {
                final place = savedPlaces[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      LucideIcons.mapPin,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      place.nameTr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(place.category.getLabel(context)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            LucideIcons.heart,
                            color: Colors.red,
                            fill: 1.0,
                          ),
                          onPressed: () {
                            ref
                                .read(favoritesProvider.notifier)
                                .toggleFavorite(place.id);
                          },
                        ),
                        const Icon(LucideIcons.chevronLeft),
                      ],
                    ),
                    onTap: () {
                      context.push(
                        const PlaceDetailsRoute().location(id: place.id),
                      );
                    },
                  ),
                );
              },
            );
          },
          error: (error, _) => EmptyState(
            message: AppLocalizations.of(context).errorLoadingData(error.toString()),
            icon: LucideIcons.alertCircle,
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
