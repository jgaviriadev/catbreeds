import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedCharacteristicBar extends StatelessWidget {
  final String label;
  final int value;
  final String level;

  const BreedCharacteristicBar({
    required this.label,
    required this.value,
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value / 5.0).clamp(0.0, 1.0);

    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final backgroundColor = isDark ? Colors.grey[800] : Colors.grey[200];
        final labelColor = isDark ? Colors.grey[400] : Colors.grey[600];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: AppTextStyles.textGreyStyle12.copyWith(color: labelColor),
                ),
                Text(
                  level,
                  style: AppTextStyles.textPrimaryStyle12,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: backgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
          ],
        );
      },
    );
  }
}
