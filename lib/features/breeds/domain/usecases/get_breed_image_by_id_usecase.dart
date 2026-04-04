import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';

class GetBreedImageByIdUseCase implements UseCase<BreedImageEntity, String> {
  final BreedRepository repository;

  GetBreedImageByIdUseCase({required this.repository});

  @override
  Future<Result<BreedImageEntity>> call(String imageId) {
    return repository.getBreedImageById(imageId);
  }
}
