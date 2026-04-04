import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';

abstract class BreedRepository {
  Future<Result<BreedsPageEntity>> getBreeds(int page);
  Future<Result<List<BreedImageEntity>>> getBreedImages({
    required String breedIds,
    required int limit,
  });
  Future<Result<BreedImageEntity>> getBreedImageById(String imageId);
  Future<Result<List<BreedEntity>>> searchBreeds(String query);
}
