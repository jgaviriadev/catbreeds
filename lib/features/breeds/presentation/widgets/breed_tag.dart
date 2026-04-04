import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedTag extends StatelessWidget {
  final String text;
  final Color? color;

  const BreedTag({
    required this.text,
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final textColor = isDark ? (color ?? AppColors.tertiary).withValues(alpha: 0.8) : (color ?? AppColors.tertiary);
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color?.withValues(alpha: .1) ?? AppColors.tertiary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: AppTextStyles.textBlackStyle12.copyWith(
              color: textColor,
            ),
          ),
        );
      },
    );
  }
}
