import 'package:cat_breeds/features/breeds/presentation/widgets/breed_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BreedSkeletonLoader extends StatelessWidget {
  final int itemCount;

  const BreedSkeletonLoader({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const BreedCard(
            imageUrl: '',
            imageId: '',
            breedName: 'Loading Breed Name',
            origin: 'Country',
            intelligence: 4,
            description: 'Loading description for this amazing cat breed...',
            temperament: ['Loading', 'Skeleton'],
          );
        },
      ),
    );
  }
}
