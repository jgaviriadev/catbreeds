part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

/// Load all favorites from API
class LoadFavoritesEvent extends FavoritesEvent {}

/// Toggle favorite status (add or remove)
class ToggleFavoriteEvent extends FavoritesEvent {
  final String imageId;
  final String subId;

  ToggleFavoriteEvent({
    required this.imageId,
    required this.subId,
  });
}

/// Refresh favorites list
class RefreshFavoritesEvent extends FavoritesEvent {}

/// Get breed detail by image ID
class GetBreedDetailEvent extends FavoritesEvent {
  final String imageId;

  GetBreedDetailEvent(this.imageId);
}

/// Clear selected breed after navigation
class ClearSelectedBreedEvent extends FavoritesEvent {}
