import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';

class DeleteFavoriteUseCase implements UseCase<bool, int> {
  final FavoriteRepository repository;

  DeleteFavoriteUseCase({required this.repository});

  @override
  Future<Result<bool>> call(int favoriteId) {
    return repository.deleteFavorite(favoriteId);
  }
}
