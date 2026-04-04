import 'package:cat_breeds/features/favorites/domain/entities/favorite_entity.dart';
import 'package:cat_breeds/features/favorites/presentation/widgets/favorite_card.dart';
import 'package:flutter/material.dart';

class FavoritesGridView extends StatelessWidget {
  final List<FavoriteEntity> favorites;
  final Future<void> Function() onRefresh;
  final void Function(String imageId) onItemTap;

  const FavoritesGridView({
    required this.favorites,
    required this.onRefresh,
    required this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favorite = favorites[index];
          final imageUrl = favorite.image?.url;
          final imageId = favorite.imageId;

          if (imageUrl == null || imageId == null) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.pets, size: 50, color: Colors.grey),
            );
          }

          return FavoriteCard(
            imageUrl: imageUrl,
            imageId: imageId,
            onTap: () => onItemTap(imageId),
          );
        },
      ),
    );
  }
}
