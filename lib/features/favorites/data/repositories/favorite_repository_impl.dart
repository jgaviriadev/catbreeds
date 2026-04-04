import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:cat_breeds/features/favorites/data/mappers/favorite_mapper.dart';
import 'package:cat_breeds/features/favorites/data/models/models.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDatasource dataSource;

  FavoriteRepositoryImpl({required this.dataSource});

  @override
  Future<Result<List<FavoriteEntity>>> getFavorites() {
    return handleRepositoryCall<List<FavoriteEntity>>(
      action: () async {
        final data = await dataSource.getFavorites();
        return data.map((model) => model.toEntity()).toList();
      },
      operation: 'Get Favorites',
    );
  }

  @override
  Future<Result<bool>> addFavorite({
    required String imageId,
    required String subId,
  }) {
    return handleRepositoryCall<bool>(
      action: () async {
        final request = AddFavoriteRequestModel(
          imageId: imageId,
          subId: subId,
        );
        final response = await dataSource.addFavorite(request);
        return response.isSuccess;
      },
      operation: 'Add Favorite',
    );
  }

  @override
  Future<Result<bool>> deleteFavorite(int favoriteId) {
    return handleRepositoryCall<bool>(
      action: () async {
        final response = await dataSource.deleteFavorite(favoriteId);
        return response.isSuccess;
      },
      operation: 'Delete Favorite',
    );
  }
}
