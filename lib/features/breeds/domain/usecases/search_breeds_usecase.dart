import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';

class SearchBreedsUseCase implements UseCase<List<BreedEntity>, String> {
  final BreedRepository repository;

  SearchBreedsUseCase({required this.repository});

  @override
  Future<Result<List<BreedEntity>>> call(String query) {
    return repository.searchBreeds(query);
  }
}
