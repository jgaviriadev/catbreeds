import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';

abstract class FavoriteRepository {
  Future<Result<List<FavoriteEntity>>> getFavorites();
  Future<Result<bool>> addFavorite({
    required String imageId,
    required String subId,
  });
  Future<Result<bool>> deleteFavorite(int favoriteId);
}
