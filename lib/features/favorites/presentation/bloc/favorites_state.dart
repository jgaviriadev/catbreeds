part of 'favorites_bloc.dart';

enum FavoritesStatus {
  initial,
  loading,
  success,
  error,
  loadingDetail, // Loading breed detail
}

class FavoritesState {
  /// Set of image IDs that are marked as favorites
  final Set<String> favoriteImageIds;
  
  /// Set of image IDs currently being toggled (for loading state)
  final Set<String> loadingIds;
  
  /// Map of imageId -> favoriteId (needed for DELETE endpoint)
  final Map<String, int> favoriteIdMap;
  
  /// Complete list of favorite entities with image data
  final List<FavoriteEntity> favorites;
  
  /// Selected breed for navigation
  final BreedEntity? selectedBreed;
  
  final FavoritesStatus status;
  final String? errorMessage;

  FavoritesState({
    this.favoriteImageIds = const {},
    this.loadingIds = const {},
    this.favoriteIdMap = const {},
    this.favorites = const [],
    this.selectedBreed,
    this.status = FavoritesStatus.initial,
    this.errorMessage,
  });

  FavoritesState copyWith({
    Set<String>? favoriteImageIds,
    Set<String>? loadingIds,
    Map<String, int>? favoriteIdMap,
    List<FavoriteEntity>? favorites,
    BreedEntity? selectedBreed,
    bool clearSelectedBreed = false,
    FavoritesStatus? status,
    String? errorMessage,
  }) {
    return FavoritesState(
      favoriteImageIds: favoriteImageIds ?? this.favoriteImageIds,
      loadingIds: loadingIds ?? this.loadingIds,
      favoriteIdMap: favoriteIdMap ?? this.favoriteIdMap,
      favorites: favorites ?? this.favorites,
      selectedBreed: clearSelectedBreed ? null : (selectedBreed ?? this.selectedBreed),
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Check if an image is a favorite
  bool isFavorite(String imageId) => favoriteImageIds.contains(imageId);

  /// Check if an image is currently being toggled
  bool isLoading(String imageId) => loadingIds.contains(imageId);

  /// Get the favorite ID for deletion
  int? getFavoriteId(String imageId) => favoriteIdMap[imageId];
}
