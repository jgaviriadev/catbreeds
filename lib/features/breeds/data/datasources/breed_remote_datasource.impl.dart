// import 'dart:convert';

import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/data/datasources/breed_datasource.dart';
import 'package:cat_breeds/features/breeds/data/models/models.dart';

class BreedRemoteDatasourceImpl implements BreedDatasource {
  final ApiClient _apiClient;

  BreedRemoteDatasourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<BreedsPageModel> getBreeds(int page) async {
    final response = await _apiClient.get(
      '/breeds',
      query: {
        'page': page,
        'limit': 10,
      },
    );
    
    final totalCount = int.tryParse(
      response.headers.value('pagination-count') ?? '67',
    ) ?? 67;
    
    final breeds = List<BreedModel>.from(
      (response.data as List).map((e) => BreedModel.fromMap(e as Map<String, dynamic>)),
    );
    
    return BreedsPageModel(
      breeds: breeds,
      totalCount: totalCount,
    );
  }

  @override
  Future<List<BreedImageModel>> getBreedImages({
    required String breedIds,
    required int limit,
  }) async {
    final response = await _apiClient.get(
      '/images/search',
      query: {
        'limit': limit,
        'breed_ids': breedIds,
      },
    );
    return List<BreedImageModel>.from(
      (response.data as List).map((e) => BreedImageModel.fromMap(e as Map<String, dynamic>)),
    );
  }

  @override
  Future<BreedImageModel> getBreedImageById(String imageId) async {
    final response = await _apiClient.get(
      '/images/$imageId',
    );
    return BreedImageModel.fromMap(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<BreedModel>> searchBreeds(String query) async {
    final response = await _apiClient.get(
      '/breeds/search',
      query: {
        'q': query,
        'attach_image': 1,
      },
    );
    return List<BreedModel>.from(
      (response.data as List).map((e) => BreedModel.fromMap(e as Map<String, dynamic>)),
    );
  }
}
