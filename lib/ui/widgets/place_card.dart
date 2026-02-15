import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../domain/models/place.dart';
import '../places/place_details_screen.dart';
import '../shared/cached_image_widget.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final bool isHorizontal;

  const PlaceCard({
    super.key,
    required this.place,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlaceDetailsScreen(placeId: place.id)),
        );
      },
      child: Container(
        width: isHorizontal ? 200 : double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
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
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: _buildImage(place.imageAsset),
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
                      style: const TextStyle(
                        fontFamily: 'Cairo', // User requested Cairo, keeping it.
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place.descriptionAr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
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
