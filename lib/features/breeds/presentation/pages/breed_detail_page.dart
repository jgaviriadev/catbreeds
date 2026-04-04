import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_characteristic_bar.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_info_grid.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_origin_label.dart';
import 'package:cat_breeds/features/breeds/presentation/widgets/breed_tag.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedDetailPage extends StatelessWidget {
  static const String routeName = '/breed_detail';
  final BreedEntity breed;
  final String? heroTag;

  const BreedDetailPage({
    required this.breed,
    this.heroTag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final imageHeight = screenHeight * 0.45;
    
    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final bgColor = isDark ? AppColors.darkSurface : AppColors.lightBackground;
        final errorBgColor = isDark ? Colors.grey[800] : Colors.grey[300];
        final errorIconColor = isDark ? Colors.grey[600] : Colors.grey;
        final dragIndicatorColor = isDark ? Colors.grey[700] : Colors.grey[300];
        final textColor = isDark ? AppColors.darkText : AppColors.lightText;
        final lifespanBgColor = isDark 
            ? AppColors.primary.withValues(alpha: 0.2) 
            : AppColors.primary.withValues(alpha: 0.1);

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (breed.image?.url != null)
                    Hero(
                      tag: heroTag ?? 'breed_detail_${breed.image!.id}',
                      child: CachedNetworkImage(
                        imageUrl: breed.image!.url,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: errorBgColor,
                            child: Icon(Icons.pets, size: 100, color: errorIconColor),
                          );
                        },
                      ),
                    )
                  else
                    Container(
                      color: errorBgColor,
                      child: Icon(Icons.pets, size: 100, color: errorIconColor),
                    ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable Content
            Positioned(
              top: imageHeight - 30,
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Drag indicator
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: dragIndicatorColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Breed Name and Origin
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                breed.name ?? LocaleKeys.breed_detail_unknown_breed.tr(),
                                style: AppTextStyles.textBlackStyleBold32.copyWith(color: textColor),
                              ),
                              const SizedBox(height: 8),
                              BreedOriginLabel(
                                origin: breed.origin ?? LocaleKeys.breed_detail_unknown_origin.tr(),
                                countryCode: breed.countryCode,
                              ),
                              if (breed.lifeSpan != null) ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: lifespanBgColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.cake, size: 16, color: AppColors.primary),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${breed.lifeSpan} ${LocaleKeys.breed_detail_years.tr()}',
                                            style: AppTextStyles.textPrimaryStyle14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Characteristics Bars
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              if (breed.intelligence != null)
                                BreedCharacteristicBar(
                                  label: LocaleKeys.breed_detail_intelligence.tr(),
                                  value: breed.intelligence!,
                                  level: _getLevel(breed.intelligence!),
                                ),
                              const SizedBox(height: 16),
                              if (breed.adaptability != null)
                                BreedCharacteristicBar(
                                  label: LocaleKeys.breed_detail_adaptability.tr(),
                                  value: breed.adaptability!,
                                  level: _getLevel(breed.adaptability!),
                                ),
                              const SizedBox(height: 16),
                              if (breed.vocalisation != null)
                                BreedCharacteristicBar(
                                  label: LocaleKeys.breed_detail_vocalness.tr(),
                                  value: breed.vocalisation!,
                                  level: _getLevel(breed.vocalisation!),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Temperament Tags
                        if (breed.temperament != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: breed.temperament!
                                  .split(',')
                                  .take(3)
                                  .map((trait) => BreedTag(text: trait.trim()))
                                  .toList(),
                            ),
                          ),
                        const SizedBox(height: 32),
                        // Title Section
                        if (breed.temperament != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              '${LocaleKeys.breed_detail_title_prefix.tr()} ${breed.temperament!.split(',').first.trim()}',
                              style: AppTextStyles.textBlackStyleBold24.copyWith(color: textColor),
                            ),
                          ),
                        const SizedBox(height: 16),
                        // Description
                        if (breed.description != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              breed.description!,
                              style: AppTextStyles.textBlackStyle.copyWith(color: textColor),
                            ),
                          ),

                        const SizedBox(height: 32),
                        // Additional Info Grid
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.breed_detail_additional_info.tr(),
                                style: AppTextStyles.textBlackStyleBold20.copyWith(color: textColor),
                              ),
                              const SizedBox(height: 16),
                              BreedInfoGrid(breed: breed),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),        );
      },    );
  }

  String _getLevel(int value) {
    if (value >= 4) return LocaleKeys.breed_detail_level_high.tr();
    if (value >= 3) return LocaleKeys.breed_detail_level_medium.tr();
    return LocaleKeys.breed_detail_level_low.tr();
  }
}
