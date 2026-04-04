import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';

class GetBreedsUseCase implements UseCase<BreedsPageEntity, int> {
  final BreedRepository repository;

  GetBreedsUseCase({required this.repository});

  @override
  Future<Result<BreedsPageEntity>> call(int page) {
    return repository.getBreeds(page);
  }
}
