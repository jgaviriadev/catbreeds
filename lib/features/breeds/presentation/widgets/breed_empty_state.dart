import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BreedEmptyState extends StatelessWidget {
  const BreedEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets_outlined,
            size: 80,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.breeds_empty_state.tr(),
            style: AppTextStyles.textBlackStyle18,
          ),
        ],
      ),
    );
  }
}
