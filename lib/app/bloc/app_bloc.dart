import 'dart:async';

import 'package:cat_breeds/core/services/shared_prefs_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

/// Global app-level bloc for managing application-wide state.
class AppBloc extends Cubit<AppState> {
  final SharedPrefsService _prefs;

  AppBloc({required SharedPrefsService prefs}) : _prefs = prefs, super(const AppState());

  /// Loads saved theme preference from SharedPreferences.
  ///
  /// Called on app startup to restore user's theme choice.
  void loadTheme() {
    final isDark = _prefs.prefs.getBool('is_dark_mode') ?? false;
    final themeMode = isDark ? AppThemeMode.dark : AppThemeMode.light;
    emit(state.copyWith(themeMode: themeMode));
  }

  void showLoading() {
    emit(state.copyWith(status: AppStatus.loading));
  }

  void hideLoading() {
    emit(state.copyWith(status: AppStatus.idle));
  }

  void setThemeMode(AppThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
    unawaited(_saveThemePreference(themeMode));
  }

  void toggleTheme() {
    final newTheme = state.themeMode == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    emit(state.copyWith(themeMode: newTheme));
    unawaited(_saveThemePreference(newTheme));
  }

  /// Saves theme preference to SharedPreferences.
  Future<void> _saveThemePreference(AppThemeMode themeMode) async {
    final isDark = themeMode == AppThemeMode.dark;
    await _prefs.prefs.setBool('is_dark_mode', isDark);
  }
}
