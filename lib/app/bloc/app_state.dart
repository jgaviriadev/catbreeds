part of 'app_bloc.dart';

enum AppStatus { idle, loading }

enum AppThemeMode { light, dark }

class AppState extends Equatable {
  final AppStatus status;
  final AppThemeMode themeMode;

  const AppState({
    this.status = AppStatus.idle,
    this.themeMode = AppThemeMode.light,
  });

  AppState copyWith({
    AppStatus? status,
    AppThemeMode? themeMode,
  }) {
    return AppState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [
    status,
    themeMode,
  ];
}
