import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_image_by_id_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_images_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breeds_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_initial_breeds_data_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/search_breeds_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/delete_favorite_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:get_it/get_it.dart';

/// Registers all use case dependencies for the application.
///
/// Use cases are registered here centrally to avoid confusion when a use case
/// from one feature is used in another feature's BLoC.
void registerUseCases(GetIt sl) {
  // ============================================
  // BREEDS Use Cases
  // ============================================
  sl
    ..registerLazySingleton<GetBreedsUseCase>(
      () => GetBreedsUseCase(
        repository: sl<BreedRepository>(),
      ),
    )
    ..registerLazySingleton<GetBreedImagesUseCase>(
      () => GetBreedImagesUseCase(
        repository: sl<BreedRepository>(),
      ),
    )
    ..registerLazySingleton<GetBreedImageByIdUseCase>(
      () => GetBreedImageByIdUseCase(
        repository: sl<BreedRepository>(),
      ),
    )
    ..registerLazySingleton<GetBreedsWithImagesUseCase>(
      () => GetBreedsWithImagesUseCase(
        getBreedsUseCase: sl<GetBreedsUseCase>(),
        getBreedImageByIdUseCase: sl<GetBreedImageByIdUseCase>(),
      ),
    )
    ..registerLazySingleton<SearchBreedsUseCase>(
      () => SearchBreedsUseCase(
        repository: sl<BreedRepository>(),
      ),
    )
    // ============================================
    // FAVORITES Use Cases
    // ============================================
    ..registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(
        repository: sl<FavoriteRepository>(),
      ),
    )
    ..registerLazySingleton<AddFavoriteUseCase>(
      () => AddFavoriteUseCase(
        repository: sl<FavoriteRepository>(),
      ),
    )
    ..registerLazySingleton<DeleteFavoriteUseCase>(
      () => DeleteFavoriteUseCase(
        repository: sl<FavoriteRepository>(),
      ),
    );
}
