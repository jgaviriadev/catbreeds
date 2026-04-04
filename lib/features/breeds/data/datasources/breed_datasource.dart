import 'package:cat_breeds/features/breeds/data/models/models.dart';

/// Datasource interface for authentication API calls
abstract class BreedDatasource {
  /// Fetches a paginated list of breeds from the API
  Future<BreedsPageModel> getBreeds(int page);
  
  /// Fetches breed images from the API
  Future<List<BreedImageModel>> getBreedImages({
    required String breedIds,
    required int limit,
  });
  
  /// Fetches a single breed image by ID
  Future<BreedImageModel> getBreedImageById(String imageId);
  
  /// Searches breeds by query text
  Future<List<BreedModel>> searchBreeds(String query);
}
