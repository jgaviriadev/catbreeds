import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/breed_entity.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_card.dart';
import 'package:flutter/material.dart';

class BreedListView extends StatelessWidget {
  final List<BreedEntity> breeds;
  final bool isLoadingMore;
  final ScrollController? scrollController;
  final Function(BreedEntity)? onTap;

  const BreedListView({
    required this.breeds,
    required this.isLoadingMore,
    this.scrollController,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: breeds.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Show loading indicator at the end
        if (index >= breeds.length) {
          return _buildLoadingMoreIndicator();
        }

        final breed = breeds[index];
        return BreedCard(
          key: ValueKey(breed.id),
          imageUrl: breed.image?.url ?? '',
          imageId: breed.image?.id ?? '',
          breedName: breed.name ?? 'Unknown',
          origin: breed.origin ?? 'Unknown',
          intelligence: breed.intelligence ?? 0,
          description: breed.description ?? '',
          temperament: breed.temperament?.split(',').map((e) => e.trim()).toList() ?? [],
          onTap: onTap != null ? () => onTap!(breed) : null,
        );
      },
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 3,
      ),
    );
  }
}
