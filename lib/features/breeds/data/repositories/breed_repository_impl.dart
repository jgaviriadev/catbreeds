import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/data/datasources/breed_datasource.dart';
import 'package:cat_breeds/features/breeds/data/mappers/mappers.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';

class BreedRepositoryImpl implements BreedRepository {
  final BreedDatasource dataSource;

  BreedRepositoryImpl({required this.dataSource});

  @override
  Future<Result<BreedsPageEntity>> getBreeds(int page) {
    return handleRepositoryCall<BreedsPageEntity>(
      action: () async {
        final data = await dataSource.getBreeds(page);
        return data.toEntity(page);
      },
      operation: 'Get Breeds',
    );
  }

  @override
  Future<Result<List<BreedImageEntity>>> getBreedImages({
    required String breedIds,
    required int limit,
  }) {
    return handleRepositoryCall<List<BreedImageEntity>>(
      action: () async {
        final data = await dataSource.getBreedImages(
          breedIds: breedIds,
          limit: limit,
        );
        return data.map((model) => model.toEntity()).toList();
      },
      operation: 'Get Breed Images',
    );
  }

  @override
  Future<Result<BreedImageEntity>> getBreedImageById(String imageId) {
    return handleRepositoryCall<BreedImageEntity>(
      action: () async {
        final data = await dataSource.getBreedImageById(imageId);
        return data.toEntity();
      },
      operation: 'Get Breed Image By Id',
    );
  }

  @override
  Future<Result<List<BreedEntity>>> searchBreeds(String query) {
    return handleRepositoryCall<List<BreedEntity>>(
      action: () async {
        final data = await dataSource.searchBreeds(query);
        return data.map((model) => model.toEntity()).toList();
      },
      operation: 'Search Breeds',
    );
  }
}
