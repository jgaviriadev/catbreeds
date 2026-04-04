import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_breeds/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final String imageUrl;
  final String imageId;
  final VoidCallback onTap;

  const FavoriteCard({
    required this.imageUrl,
    required this.imageId,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Cat Image
              Hero(
                tag: 'favorites_image_$imageId',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.pets,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // Gradient overlay
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Favorite Button
              Positioned(
                top: 8,
                right: 8,
                child: FavoriteButton(
                  imageId: imageId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
