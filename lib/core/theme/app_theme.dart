import 'package:cat_breeds/core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the application's theme configurations for light and dark modes.
///
/// This class provides pre-configured ThemeData objects that can be applied
/// to the MaterialApp to maintain consistent styling throughout the app.
class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkSurface,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.darkSurface,
    ),
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  );
}
