import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../domain/models/place.dart';
import '../places/place_details_screen.dart';
import '../shared/cached_image_widget.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final bool isHorizontal;

  const PlaceCard({super.key, required this.place, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).cardTheme;
    final shape =
        (cardTheme.shape as RoundedRectangleBorder?) ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaceDetailsScreen(placeId: place.id),
          ),
        );
      },
      child: Container(
        width: isHorizontal ? 200 : double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cardTheme.color,
          borderRadius: shape.borderRadius,
          border: shape.side != BorderSide.none
              ? Border.fromBorderSide(shape.side)
              : null,
          boxShadow: cardTheme.shadowColor != null
              ? [
                  BoxShadow(
                    color: cardTheme.shadowColor!,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- IMAGE SECTION ---
            Expanded(
              flex: 3,
              child: Hero(
                tag: 'place_image_${place.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: (shape.borderRadius as BorderRadius).topLeft,
                  ),
                  child: _buildImage(place.imageAsset),
                ),
              ),
            ),
            // --- TEXT SECTION ---
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.nameTr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place.descriptionAr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // THE MAGIC FIX: Checks if it is a URL or a Local Asset
  Widget _buildImage(String rawPath) {
    return CachedImageWidget(
      imageUrl: rawPath,
      width: double.infinity,
      fit: BoxFit.cover,
      errorIcon: LucideIcons.imageOff,
    );
  }
}
