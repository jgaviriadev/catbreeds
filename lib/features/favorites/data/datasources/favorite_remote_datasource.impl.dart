import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:cat_breeds/features/favorites/data/models/models.dart';

class FavoriteRemoteDatasourceImpl implements FavoriteDatasource {
  final ApiClient _apiClient;

  FavoriteRemoteDatasourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final response = await _apiClient.dio.get('/favourites');
    return List<FavoriteModel>.from(
      (response.data as List).map((e) => FavoriteModel.fromMap(e as Map<String, dynamic>)),
    );
  }

  @override
  Future<AddFavoriteResponseModel> addFavorite(AddFavoriteRequestModel request) async {
    final response = await _apiClient.dio.post(
      '/favourites',
      data: request.toMap(),
    );
    return AddFavoriteResponseModel.fromMap(response.data as Map<String, dynamic>);
  }

  @override
  Future<DeleteFavoriteResponseModel> deleteFavorite(int favoriteId) async {
    final response = await _apiClient.dio.delete('/favourites/$favoriteId');
    return DeleteFavoriteResponseModel.fromMap(response.data as Map<String, dynamic>);
  }
}
