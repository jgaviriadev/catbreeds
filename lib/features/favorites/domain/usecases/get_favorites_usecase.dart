import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';

class GetFavoritesUseCase implements UseCase<List<FavoriteEntity>, NoParams> {
  final FavoriteRepository repository;

  GetFavoritesUseCase({required this.repository});

  @override
  Future<Result<List<FavoriteEntity>>> call(NoParams params) {
    return repository.getFavorites();
  }
}
