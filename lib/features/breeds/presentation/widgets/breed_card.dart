import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_origin_label.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_tag.dart';
import 'package:cat_breeds/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:cat_breeds/shared/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedCard extends StatelessWidget {
  final String imageUrl;
  final String imageId;
  final String breedName;
  final String origin;
  final int intelligence;
  final String description;
  final List<String> temperament;
  final VoidCallback? onTap;

  const BreedCard({
    required this.imageUrl,
    required this.imageId,
    required this.breedName,
    required this.origin,
    required this.intelligence,
    required this.description,
    super.key,
    this.temperament = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final cardColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
        final badgeColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
        final shadowColor = isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.1);
        final textColor = isDark ? AppColors.darkText : AppColors.lightText;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with overlays
              Stack(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Hero(
                        tag: 'breeds_image_$imageId',
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => ColoredBox(
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                          errorWidget: (context, url, error) => ColoredBox(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            child: const Center(
                              child: Icon(
                                Icons.pets,
                                size: 60,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Country badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: BreedOriginLabel(
                        origin: origin,
                        uppercase: true,
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: FavoriteButton(imageId: imageId),
                  ),
                ],
              ),
              // Content below image
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Breed name and intelligence
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            breedName,
                            style: AppTextStyles.textBlackStyleBold20.copyWith(color: textColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          LocaleKeys.breeds_intelligence_label.tr().replaceAll('{}', intelligence.toString()),
                          style: AppTextStyles.textBlackStyle12.copyWith(color: textColor.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      description,
                      style: AppTextStyles.textBlackStyle12.copyWith(color: textColor.withValues(alpha: 0.8)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // Temperament chips and button
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: temperament.take(2).map((temp) {
                              return BreedTag(
                                text: temp,
                                color: AppColors.primary,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        PrimaryButton(
                          text: LocaleKeys.breeds_see_more_button.tr(),
                          icon: Icons.arrow_forward,
                          isCompact: true,
                          onPressed: onTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
