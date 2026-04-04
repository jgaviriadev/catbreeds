import 'package:cat_breeds/core/core.dart';
import 'package:flutter/material.dart';

/// Defines the text styles used throughout the application.
///
/// These styles inherit the font family defined in the global theme configuration
/// (AppTheme), so you only need to specify size, weight, and color properties here.
/// To change the font family for the entire app, modify the ThemeData in AppTheme.
class AppTextStyles {
  static const textBlackStyle12 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const textBlackStyle14 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const textBlackStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const textBlackStyle18 = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static const textBlackStyleBold20 = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const textBlackStyleBold24 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const textBlackStyleBold32 = TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  /// Primary Color Text Style - used for main content and important information.
  static const textPrimaryStyle12 = TextStyle(
    color: AppColors.primary,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const textPrimaryStyle14 = TextStyle(
    color: AppColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// grey Text Style - used for secondary information, captions, and less important text.
   static const textGreyStyle16 = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const textGreyStyle14 = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const textGreyStyle12 = TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const textGreyStyle11 = TextStyle(
    color: Colors.grey,
    fontSize: 11,
    fontWeight: FontWeight.normal,
  );

  // white Text Style - used for text on dark backgrounds or buttons.
  static const textWhiteStyleBold = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const textWhiteStyleBold32 = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
}
