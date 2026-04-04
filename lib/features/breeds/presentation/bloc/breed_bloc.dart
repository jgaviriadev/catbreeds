import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_initial_breeds_data_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/search_breeds_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'breed_event.dart';
part 'breed_state.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  final GetBreedsWithImagesUseCase _getBreedsWithImagesUseCase;
  final SearchBreedsUseCase _searchBreedsUseCase;

  BreedBloc({
    required GetBreedsWithImagesUseCase getBreedsWithImagesUseCase,
    required SearchBreedsUseCase searchBreedsUseCase,
  }) : _getBreedsWithImagesUseCase = getBreedsWithImagesUseCase,
       _searchBreedsUseCase = searchBreedsUseCase,
       super(BreedState()) {
    on<LoadInitialBreedsEvent>(_onLoadInitialBreeds);
    on<LoadMoreBreedsEvent>(_onLoadMoreBreeds);
    on<RefreshBreedsEvent>(_onRefreshBreeds);
    on<SearchBreedsEvent>(_onSearchBreeds);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onLoadInitialBreeds(
    LoadInitialBreedsEvent event,
    Emitter<BreedState> emit,
  ) async {
    emit(
      state.copyWith(status: BreedStatus.loading),
    );

    final result = await _getBreedsWithImagesUseCase(0);

    result.when(
      success: (breedsPage) {
        final hasReachedMax = breedsPage.breeds.length >= breedsPage.totalCount;
        
        emit(
          state.copyWith(
            status: BreedStatus.success,
            breeds: breedsPage.breeds,
            currentPage: breedsPage.currentPage,
            totalCount: breedsPage.totalCount,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
      error: (failure) {
        emit(
          state.copyWith(
            status: BreedStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreBreeds(
    LoadMoreBreedsEvent event,
    Emitter<BreedState> emit,
  ) async {
    final isLoadingMore = state.status == BreedStatus.loadingMore;
    if (state.hasReachedMax || isLoadingMore) return;

    emit(
      state.copyWith(
        status: BreedStatus.loadingMore,
      ),
    );

    final nextPage = state.currentPage + 1;
    final result = await _getBreedsWithImagesUseCase(nextPage);

    result.when(
      success: (breedsPage) {
        final allBreeds = [...state.breeds, ...breedsPage.breeds];
        final hasReachedMax = allBreeds.length >= breedsPage.totalCount;

        emit(
          state.copyWith(
            status: BreedStatus.success,
            breeds: allBreeds,
            currentPage: breedsPage.currentPage,
            totalCount: breedsPage.totalCount,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
      error: (failure) {
        emit(
          state.copyWith(
            status: BreedStatus.success,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshBreeds(
    RefreshBreedsEvent event,
    Emitter<BreedState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BreedStatus.loading,
        breeds: [],
        currentPage: 0,
        totalCount: 0,
        hasReachedMax: false,
        errorMessage: null,
      ),
    );

    final result = await _getBreedsWithImagesUseCase(0);

    result.when(
      success: (breedsPage) {
        final hasReachedMax = breedsPage.breeds.length >= breedsPage.totalCount;
        
        emit(
          state.copyWith(
            status: BreedStatus.success,
            breeds: breedsPage.breeds,
            currentPage: breedsPage.currentPage,
            totalCount: breedsPage.totalCount,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
      error: (failure) {
        emit(
          state.copyWith(
            status: BreedStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _onSearchBreeds(
    SearchBreedsEvent event,
    Emitter<BreedState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          status: BreedStatus.success,
          searchQuery: '',
          searchResults: [],
        ),
      );
      return;
    }

    emit(state.copyWith(searchQuery: query));

    final localResults = _filterBreedsLocally(query);

    if (localResults.isNotEmpty) {
      // Show local results immediately
      emit(
        state.copyWith(
          status: BreedStatus.searchSuccess,
          searchResults: localResults,
        ),
      );
      return;
    }

    emit(state.copyWith(status: BreedStatus.searchLoading));

    final result = await _searchBreedsUseCase(query);

    result.when(
      success: (breeds) {
        emit(
          state.copyWith(
            status: breeds.isEmpty ? BreedStatus.searchEmpty : BreedStatus.searchSuccess,
            searchResults: breeds,
          ),
        );
      },
      error: (failure) {
        emit(
          state.copyWith(
            status: BreedStatus.searchEmpty,
            searchResults: [],
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<BreedState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BreedStatus.success,
        searchQuery: '',
        searchResults: [],
        errorMessage: null,
      ),
    );
  }

  List<BreedEntity> _filterBreedsLocally(String query) {
    final lowerQuery = query.toLowerCase();
    return state.breeds.where((breed) {
      return breed.name?.toLowerCase().contains(lowerQuery) ?? false;
    }).toList();
  }
}
