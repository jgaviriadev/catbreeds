import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';

class GetBreedImagesUseCase implements UseCase<List<BreedImageEntity>, GetBreedImagesParams> {
  final BreedRepository repository;

  GetBreedImagesUseCase({required this.repository});

  @override
  Future<Result<List<BreedImageEntity>>> call(GetBreedImagesParams params) {
    return repository.getBreedImages(
      breedIds: params.breedIds,
      limit: params.limit,
    );
  }
}

class GetBreedImagesParams {
  final String breedIds;
  final int limit;

  GetBreedImagesParams({
    required this.breedIds,
    required this.limit,
  });
}
