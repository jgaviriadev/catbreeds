import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final VoidCallback onClear;

  const BreedSearchField({
    required this.controller,
    required this.searchQuery,
    required this.onClear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final containerColor = isDark ? AppColors.darkSurface : Colors.white;
        final fillColor = isDark ? Colors.grey[900] : Colors.grey[100];
        final borderColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;
        final clearIconColor = isDark ? Colors.grey[400] : Colors.grey[600];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: containerColor,
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: LocaleKeys.breeds_search_hint.tr(),
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: clearIconColor),
                      onPressed: onClear,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        );
      },
    );
  }
}
