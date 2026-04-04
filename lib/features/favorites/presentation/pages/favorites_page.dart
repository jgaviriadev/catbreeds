import 'dart:async';

import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/presentation/pages/breed_detail_page.dart';
import 'package:cat_breeds/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:cat_breeds/features/favorites/presentation/widgets/favorites_grid_view.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:cat_breeds/shared/widgets/empty_state_widget.dart';
import 'package:cat_breeds/shared/widgets/error_retry_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  static const String routeName = '/favorites';
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<FavoritesBloc>(),
      child: BlocConsumer<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          // Navigate when breed detail is loaded
          if (state.selectedBreed != null) {
            final heroTag = state.selectedBreed!.image?.id != null
                ? 'favorites_image_${state.selectedBreed!.image!.id}'
                : null;
            unawaited(
              context.pushNamed(
                BreedDetailPage.routeName,
                extra: {'breed': state.selectedBreed, 'heroTag': heroTag},
              ),
            );
            // Clear after navigation
            context.read<FavoritesBloc>().add(ClearSelectedBreedEvent());
          }

          // Show error messages
          if (state.status == FavoritesStatus.error && state.errorMessage != null) {
            sl<NotificationService>().showError(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                _buildBody(context, state),
                // Loading overlay when fetching breed detail
                if (state.status == FavoritesStatus.loadingDetail)
                  ColoredBox(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, FavoritesState state) {
    if (state.status == FavoritesStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FavoritesStatus.error && state.favorites.isEmpty) {
      return ErrorRetryWidget(
        errorMessage: state.errorMessage ?? LocaleKeys.favorites_error_loading.tr(),
        onRetry: () {
          context.read<FavoritesBloc>().add(LoadFavoritesEvent());
        },
      );
    }

    if (state.favorites.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.favorite_border,
        title: LocaleKeys.favorites_empty_title.tr(),
        subtitle: LocaleKeys.favorites_empty_subtitle.tr(),
      );
    }

    return FavoritesGridView(
      favorites: state.favorites,
      onRefresh: () async {
        context.read<FavoritesBloc>().add(LoadFavoritesEvent());
      },
      onItemTap: (imageId) {
        context.read<FavoritesBloc>().add(GetBreedDetailEvent(imageId));
      },
    );
  }
}
