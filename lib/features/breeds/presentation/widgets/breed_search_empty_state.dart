import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BreedSearchEmptyState extends StatelessWidget {
  final String searchQuery;

  const BreedSearchEmptyState({
    required this.searchQuery,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.breeds_search_no_results.tr().replaceAll('{}', searchQuery),
            style: AppTextStyles.textGreyStyle16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
