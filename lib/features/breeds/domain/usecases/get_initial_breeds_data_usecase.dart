import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_image_by_id_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breeds_usecase.dart';

/// UseCase to get breeds with their images populated
class GetBreedsWithImagesUseCase implements UseCase<BreedsPageEntity, int> {
  final GetBreedsUseCase _getBreedsUseCase;
  final GetBreedImageByIdUseCase _getBreedImageByIdUseCase;

  GetBreedsWithImagesUseCase({
    required GetBreedsUseCase getBreedsUseCase,
    required GetBreedImageByIdUseCase getBreedImageByIdUseCase,
  }) : _getBreedsUseCase = getBreedsUseCase,
       _getBreedImageByIdUseCase = getBreedImageByIdUseCase;

  @override
  Future<Result<BreedsPageEntity>> call(int page) async {
    /// Get all breeds with pagination metadata
    final breedsPageResult = await _getBreedsUseCase(page);

    return breedsPageResult.when(
      success: (breedsPage) async {
        final breedsWithImages = <BreedEntity>[];

        /// Get image for each breed
        for (final breed in breedsPage.breeds) {
          if (!breed.referenceImageId.isNullOrEmpty) {
            final imageResult = await _getBreedImageByIdUseCase(breed.referenceImageId!);

            final breedWithImage = imageResult.when(
              success: (image) => breed.copyWith(image: image),
              error: (_) => breed, // If image fetch fails, continue without it
            );

            breedsWithImages.add(breedWithImage);
          } else {
            breedsWithImages.add(breed);
          }
        }

        return Success(
          BreedsPageEntity(
            breeds: breedsWithImages,
            totalCount: breedsPage.totalCount,
            currentPage: breedsPage.currentPage,
          ),
        );
      },
      error: Error.new,
    );
  }
}
