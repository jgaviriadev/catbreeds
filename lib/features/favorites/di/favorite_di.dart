import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_breed_image_by_id_usecase.dart';
import 'package:cat_breeds/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:cat_breeds/features/favorites/data/datasources/favorite_remote_datasource.impl.dart';
import 'package:cat_breeds/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/delete_favorite_usecase.dart';
import 'package:cat_breeds/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:cat_breeds/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:get_it/get_it.dart';

/// Registers all favorite-related dependencies.
/// Use cases are registered in [registerUseCases] in core/di/use_cases.dart.
void registerFavoriteDependencies(GetIt sl) {
  // ============================================
  // Presentation Layer - BLoC (Global Singleton)
  // ============================================
  sl
    ..registerLazySingleton<FavoritesBloc>(
      () => FavoritesBloc(
        getFavoritesUseCase: sl<GetFavoritesUseCase>(),
        addFavoriteUseCase: sl<AddFavoriteUseCase>(),
        deleteFavoriteUseCase: sl<DeleteFavoriteUseCase>(),
        getBreedImageByIdUseCase: sl<GetBreedImageByIdUseCase>(),
      )..add(LoadFavoritesEvent()), // Auto-load favorites on init
    )
    // ============================================
    // Data Layer - Repositories
    // ============================================
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(
        dataSource: sl<FavoriteDatasource>(),
      ),
    )
    // ============================================
    // Data Layer - Data Sources
    // ============================================
    ..registerLazySingleton<FavoriteDatasource>(
      () => FavoriteRemoteDatasourceImpl(
        apiClient: sl<ApiClient>(),
      ),
    );
}
