import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Generic favorite button widget
/// Automatically reads from FavoritesBloc to determine state
/// Can be used in any feature (breeds, home, detail, etc.)
class FavoriteButton extends StatelessWidget {
  final String imageId;
  final String subId;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const FavoriteButton({
    required this.imageId,
    super.key,
    this.subId = 'default-user',
    this.size = 20,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    // Use BlocSelector for optimized rebuilds
    // Only rebuilds when isFavorite or isLoading changes for THIS imageId
    return BlocSelector<FavoritesBloc, FavoritesState, ({bool isFavorite, bool isLoading})>(
      selector: (state) => (
        isFavorite: state.isFavorite(imageId),
        isLoading: state.isLoading(imageId),
      ),
      builder: (context, data) {
        return GestureDetector(
          onTap: data.isLoading
              ? null // Disable tap while loading
              : () {
                  context.read<FavoritesBloc>().add(
                    ToggleFavoriteEvent(
                      imageId: imageId,
                      subId: subId,
                    ),
                  );
                },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: data.isLoading
                ? SizedBox(
                    width: size,
                    height: size,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Icon(
                    data.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: data.isFavorite ? (activeColor ?? Colors.red) : (inactiveColor ?? AppColors.primary),
                    size: size,
                  ),
          ),
        );
      },
    );
  }
}
