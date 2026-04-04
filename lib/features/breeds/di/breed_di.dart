import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/data/datasources/breed_datasource.dart';
import 'package:cat_breeds/features/breeds/data/datasources/breed_remote_datasource.impl.dart';
import 'package:cat_breeds/features/breeds/data/repositories/breed_repository_impl.dart';
import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_initial_breeds_data_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/search_breeds_usecase.dart';
import 'package:cat_breeds/features/breeds/presentation/bloc/breed_bloc.dart';
import 'package:get_it/get_it.dart';

/// Registers all breed-related dependencies (countries, cities, geographic data).
/// Use cases are registered in [registerUseCases] in core/di/use_cases_di.dart.
void registerBreedDependencies(GetIt sl) {
  // ============================================
  // Presentation Layer - BLoC
  // ============================================
  sl
    ..registerFactory<BreedBloc>(
      () => BreedBloc(
        getBreedsWithImagesUseCase: sl<GetBreedsWithImagesUseCase>(),
        searchBreedsUseCase: sl<SearchBreedsUseCase>(),
      ),
    )
    // ============================================
    // Data Layer - Repositories
    // ============================================
    ..registerLazySingleton<BreedRepository>(
      () => BreedRepositoryImpl(
        dataSource: sl<BreedDatasource>(),
      ),
    )
    // ============================================
    // Data Layer - Data Sources
    // ============================================
    ..registerLazySingleton<BreedDatasource>(
      () => BreedRemoteDatasourceImpl(
        apiClient: sl<ApiClient>(),
      ),
    );
}
