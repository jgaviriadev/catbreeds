part of 'breed_bloc.dart';

enum BreedStatus {
  initial,
  loading,
  loadingMore,
  success,
  error,
  searchLoading,
  searchSuccess,
  searchEmpty,
}

class BreedState {
  final BreedStatus status;
  final List<BreedEntity> breeds;
  final String? errorMessage;
  final int currentPage;
  final int totalCount;
  final bool hasReachedMax;
  final List<BreedEntity> searchResults;
  final String searchQuery;

  BreedState({
    this.status = BreedStatus.initial,
    this.breeds = const [],
    this.errorMessage,
    this.currentPage = 0,
    this.totalCount = 0,
    this.hasReachedMax = false,
    this.searchResults = const [],
    this.searchQuery = '',
  });

  BreedState copyWith({
    BreedStatus? status,
    List<BreedEntity>? breeds,
    String? errorMessage,
    int? currentPage,
    int? totalCount,
    bool? hasReachedMax,
    List<BreedEntity>? searchResults,
    String? searchQuery,
  }) {
    return BreedState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
  
  /// Helper to check if we're in search mode
  bool get isSearchMode => 
    status == BreedStatus.searchLoading || 
    status == BreedStatus.searchSuccess || 
    status == BreedStatus.searchEmpty;
}
