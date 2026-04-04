import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const BreedInfoItem({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final bgColor = isDark ? Colors.grey[850] : Colors.grey[100];
        final labelColor = isDark ? Colors.grey[400] : Colors.grey[600];
        final valueColor = isDark ? Colors.grey[200] : Colors.black87;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyles.textGreyStyle11.copyWith(
                  color: labelColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.textBlackStyle14.copyWith(color: valueColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
