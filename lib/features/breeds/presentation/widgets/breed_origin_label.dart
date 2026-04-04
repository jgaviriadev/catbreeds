import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedOriginLabel extends StatelessWidget {
  final String origin;
  final String? countryCode;
  final bool showCountryCode;
  final bool uppercase;

  const BreedOriginLabel({
    required this.origin,
    super.key,
    this.countryCode,
    this.showCountryCode = true,
    this.uppercase = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayOrigin = uppercase ? origin.toUpperCase() : origin;

    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final iconColor = isDark ? Colors.grey[400] : Colors.grey;
        final textColor = isDark ? Colors.grey[400] : Colors.grey[600];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: iconColor,
            ),
            const SizedBox(width: 4),
            Text(
              displayOrigin,
              style: AppTextStyles.textGreyStyle14.copyWith(color: textColor),
            ),
            if (showCountryCode && countryCode != null) ...[
              const SizedBox(width: 8),
              Text(
                '($countryCode)',
                style: AppTextStyles.textGreyStyle12.copyWith(color: textColor),
              ),
            ],
          ],
        );
      },
    );
  }
}
