import 'package:cat_breeds/features/favorites/data/models/models.dart';

/// Datasource interface for favorites API calls
abstract class FavoriteDatasource {
  /// Fetches a list of favorites from the API
  Future<List<FavoriteModel>> getFavorites();
  
  /// Adds a favorite to the API
  Future<AddFavoriteResponseModel> addFavorite(AddFavoriteRequestModel request);
  
  /// Deletes a favorite from the API
  Future<DeleteFavoriteResponseModel> deleteFavorite(int favoriteId);
}
