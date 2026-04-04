import 'dart:async';

import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/presentation/bloc/breed_bloc.dart';
import 'package:cat_breeds/features/breeds/presentation/pages/breed_detail_page.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_empty_state.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_error_widget.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_list_view.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_search_empty_state.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_search_field.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_skeleton_loader.dart';
import 'package:cat_breeds/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BreedPage extends StatefulWidget {
  static const String routeName = '/breed';
  const BreedPage({super.key});

  @override
  State<BreedPage> createState() => _BreedPageState();
}

class _BreedPageState extends State<BreedPage> {
  final BreedBloc _breedBloc = sl<BreedBloc>();
  final FavoritesBloc _favoritesBloc = sl<FavoritesBloc>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _breedBloc.add(LoadInitialBreedsEvent());
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _breedBloc),
        BlocProvider.value(value: _favoritesBloc),
      ],
      child: BlocBuilder<BreedBloc, BreedState>(
        builder: (context, state) {
          // Initial loading state
          if (state.status == BreedStatus.loading) {
            return const BreedSkeletonLoader();
          }

          // Error state
          if (state.status == BreedStatus.error) {
            return BreedErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () => _breedBloc.add(RefreshBreedsEvent()),
            );
          }

          // Empty state
          if (state.breeds.isEmpty && state.status == BreedStatus.success) {
            return const BreedEmptyState();
          }

          // Success state with breeds list
          final isSearchMode = state.isSearchMode;
          final breedsToShow = isSearchMode ? state.searchResults : state.breeds;
          final isLoadingMore = state.status == BreedStatus.loadingMore;
          final isSearchLoading = state.status == BreedStatus.searchLoading;

          return Column(
            children: [
              // Search TextField
              BreedSearchField(
                controller: _searchController,
                searchQuery: state.searchQuery,
                onClear: () {
                  _searchController.clear();
                  _breedBloc.add(ClearSearchEvent());
                },
              ),

              // Loading indicator for search
              if (isSearchLoading)
                const LinearProgressIndicator(
                  color: AppColors.primary,
                ),

              // Empty search results
              if (state.status == BreedStatus.searchEmpty)
                Expanded(
                  child: BreedSearchEmptyState(
                    searchQuery: state.searchQuery,
                  ),
                ),

              // Breeds list
              if (state.status != BreedStatus.searchEmpty && state.status != BreedStatus.searchLoading)
                Expanded(
                  child: BreedListView(
                    breeds: breedsToShow,
                    isLoadingMore: isLoadingMore,
                    scrollController: isSearchMode ? null : _scrollController,
                    onTap: (breed) {
                      final heroTag = breed.image?.id != null ? 'breeds_image_${breed.image!.id}' : null;
                      unawaited(
                        context.pushNamed(
                          BreedDetailPage.routeName,
                          extra: {'breed': breed, 'heroTag': heroTag},
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();

    final query = _searchController.text.trim();

    if (query.isEmpty) {
      _breedBloc.add(ClearSearchEvent());
      return;
    }

    if (query.length < 3) {
      return;
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _breedBloc.add(SearchBreedsEvent(query));
    });
  }

  void _onScroll() {
    final state = _breedBloc.state;
    if (state.isSearchMode) return;
    final direction = _scrollController.position.userScrollDirection;
    final isLoadingMore = state.status == BreedStatus.loadingMore;
    if (direction == ScrollDirection.reverse && _isNearBottom && !isLoadingMore && !state.hasReachedMax) {
      _breedBloc.add(LoadMoreBreedsEvent());
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final position = _scrollController.position;
    return position.extentAfter < 300;
  }
}
