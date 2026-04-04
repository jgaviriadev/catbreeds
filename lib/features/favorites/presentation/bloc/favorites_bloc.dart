import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_image_by_id_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/entities/entities.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/delete_favorite_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

/// Global BLoC for favorites management
/// Singleton that maintains the single source of truth for favorites across the app
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;
  final GetBreedImageByIdUseCase _getBreedImageByIdUseCase;

  FavoritesBloc({
    required GetFavoritesUseCase getFavoritesUseCase,
    required AddFavoriteUseCase addFavoriteUseCase,
    required DeleteFavoriteUseCase deleteFavoriteUseCase,
    required GetBreedImageByIdUseCase getBreedImageByIdUseCase,
  }) : _getFavoritesUseCase = getFavoritesUseCase,
       _addFavoriteUseCase = addFavoriteUseCase,
       _deleteFavoriteUseCase = deleteFavoriteUseCase,
       _getBreedImageByIdUseCase = getBreedImageByIdUseCase,
       super(FavoritesState()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<RefreshFavoritesEvent>(_onRefreshFavorites);
    on<GetBreedDetailEvent>(_onGetBreedDetail);
    on<ClearSelectedBreedEvent>(_onClearSelectedBreed);
  }

  /// Load all favorites from API
  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    final result = await _getFavoritesUseCase(const NoParams());

    result.when(
      success: (favorites) {
        final imageIds = <String>{};
        final idMap = <String, int>{};

        for (final favorite in favorites) {
          if (favorite.imageId != null && favorite.id != null) {
            imageIds.add(favorite.imageId!);
            idMap[favorite.imageId!] = favorite.id!;
          }
        }

        emit(
          state.copyWith(
            status: FavoritesStatus.success,
            favoriteImageIds: imageIds,
            favoriteIdMap: idMap,
            favorites: favorites,
          ),
        );
      },
      error: (failure) {
        emit(
          state.copyWith(
            status: FavoritesStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  /// Toggle favorite with optimistic update
  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final imageId = event.imageId;
    final isFavorite = state.isFavorite(imageId);

    // Add to loading set
    final newLoadingIds = Set<String>.from(state.loadingIds)..add(imageId);

    if (isFavorite) {
      // REMOVE FAVORITE
      final favoriteId = state.getFavoriteId(imageId);
      if (favoriteId == null) {
        // No favoriteId found, remove from loading
        emit(
          state.copyWith(
            loadingIds: Set.from(state.loadingIds)..remove(imageId),
          ),
        );
        return;
      }

      // Optimistic update: remove from favorites immediately
      final newFavoriteIds = Set<String>.from(state.favoriteImageIds)..remove(imageId);
      final newFavorites = state.favorites.where((f) => f.imageId != null && f.imageId != imageId).toList();

      emit(
        state.copyWith(
          favoriteImageIds: newFavoriteIds,
          favorites: newFavorites,
          loadingIds: newLoadingIds,
        ),
      );

      // Call API
      final result = await _deleteFavoriteUseCase(favoriteId);

      result.when(
        success: (_) {
          // Success: remove from map and loading
          final newIdMap = Map<String, int>.from(state.favoriteIdMap)..remove(imageId);
          final updatedLoadingIds = Set<String>.from(state.loadingIds)..remove(imageId);

          emit(
            state.copyWith(
              favoriteIdMap: newIdMap,
              loadingIds: updatedLoadingIds,
            ),
          );
        },
        error: (failure) {
          // Revert optimistic update

          // Reload favorites to revert to correct state
          add(RefreshFavoritesEvent());
          final revertedFavoriteIds = Set<String>.from(state.favoriteImageIds)..add(imageId);
          final updatedLoadingIds = Set<String>.from(state.loadingIds)..remove(imageId);

          emit(
            state.copyWith(
              favoriteImageIds: revertedFavoriteIds,
              loadingIds: updatedLoadingIds,
              errorMessage: failure.message,
            ),
          );
        },
      );
    } else {
      // ADD FAVORITE
      // Optimistic update: add to favorites immediately
      final newFavoriteIds = Set<String>.from(state.favoriteImageIds)..add(imageId);

      emit(
        state.copyWith(
          favoriteImageIds: newFavoriteIds,
          loadingIds: newLoadingIds,
        ),
      );

      // Call API
      final result = await _addFavoriteUseCase(
        AddFavoriteParams(imageId: imageId, subId: event.subId),
      );

      result.when(
        success: (success) {
          // Success: store the favoriteId in map and remove from loading
          // Note: AddFavoriteUseCase returns bool, we need to get favoriteId
          // We'll need to modify the response handling to get the ID
          // For now, we'll reload favorites to get the correct ID
          add(RefreshFavoritesEvent());
        },
        error: (failure) {
          // Revert optimistic update
          final revertedFavoriteIds = Set<String>.from(state.favoriteImageIds)..remove(imageId);
          final updatedLoadingIds = Set<String>.from(state.loadingIds)..remove(imageId);

          emit(
            state.copyWith(
              favoriteImageIds: revertedFavoriteIds,
              loadingIds: updatedLoadingIds,
              errorMessage: failure.message,
            ),
          );
        },
      );
    }
  }

  /// Refresh favorites (silent reload)
  Future<void> _onRefreshFavorites(
    RefreshFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await _getFavoritesUseCase(const NoParams());

    result.when(
      success: (favorites) {
        final imageIds = <String>{};
        final idMap = <String, int>{};

        for (final favorite in favorites) {
          if (favorite.imageId != null && favorite.id != null) {
            imageIds.add(favorite.imageId!);
            idMap[favorite.imageId!] = favorite.id!;
          }
        }

        emit(
          state.copyWith(
            favoriteImageIds: imageIds,
            favoriteIdMap: idMap,
            favorites: favorites,
            loadingIds: {}, // Clear all loading states
          ),
        );
      },
      error: (failure) {
        // Silent fail, keep current state
        emit(state.copyWith(loadingIds: {}));
      },
    );
  }

  /// Get breed detail by image ID
  Future<void> _onGetBreedDetail(
    GetBreedDetailEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loadingDetail));

    final result = await _getBreedImageByIdUseCase(event.imageId);

    result.when(
      success: (breedImage) {
        if (breedImage.breeds?.isNotEmpty ?? false) {
          // Construir la imagen para el breed (viene null del API)
          final breedImageEntity = BreedImageEntity(
            id: breedImage.id,
            url: breedImage.url,
            width: breedImage.width,
            height: breedImage.height,
            breeds: null, // No necesitamos recursión
          );

          // Agregar la imagen al breed
          final breedWithImage = breedImage.breeds!.first.copyWith(
            image: breedImageEntity,
          );

          emit(
            state.copyWith(
              status: FavoritesStatus.success,
              selectedBreed: breedWithImage,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FavoritesStatus.error,
              errorMessage: 'No breed information available for this image',
            ),
          );
        }
      },
      error: (failure) {
        emit(
          state.copyWith(
            status: FavoritesStatus.error,
            errorMessage: failure.message ?? 'Error loading breed details',
          ),
        );
      },
    );
  }

  /// Clear selected breed after navigation
  void _onClearSelectedBreed(
    ClearSelectedBreedEvent event,
    Emitter<FavoritesState> emit,
  ) {
    emit(state.copyWith(clearSelectedBreed: true));
  }
}
