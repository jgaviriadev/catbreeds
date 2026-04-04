import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/di/breed_di.dart';
import 'package:cat_breeds/features/favorites/di/favorite_di.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Service Locator instance for dependency injection.
///
/// Use `sl<Type>()` to retrieve registered dependencies throughout the app.
final GetIt sl = GetIt.instance;

/// Initializes all application dependencies.
///
/// Must be called once at app startup before runApp().
/// Register dependencies in order: Core services → Shared → Features.
Future<void> initializeDependencies() async {
  // ============================================
  // Localization Initialization
  // ============================================
  await EasyLocalization.ensureInitialized();
  // ============================================
  // Firebase Initialization
  // ============================================
  // await Firebase.initializeApp();

  // ============================================
  // Core Services
  // ============================================
  sl.registerLazySingleton<Talker>(TalkerFlutter.init);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton<SharedPrefsService>(
      () => SharedPrefsService(sharedPreferences),
    )
    // ============================================
    // Network & API Services
    // ============================================
    // Register Dio separately to avoid circular dependency
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<NetworkService>(
      () => NetworkService(sl<Dio>()),
    )
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(
        talker: sl<Talker>(),
        networkService: sl<NetworkService>(),
        baseUrl: const String.fromEnvironment('api.url'),
        apiKey: const String.fromEnvironment('api.key'),
      ),
    )
    // ============================================
    // UI Services
    // ============================================
    ..registerLazySingleton<NotificationService>(NotificationService.new)
    // ============================================
    //Global BLoCs
    // ============================================
    ..registerLazySingleton<AppBloc>(
      () => AppBloc(prefs: sl<SharedPrefsService>()),
    );

  // ============================================
  // Use Cases
  // ============================================
  registerUseCases(sl);
  // ============================================
  // Feature-Specific Dependencies
  // ============================================
  registerBreedDependencies(sl);
  registerFavoriteDependencies(sl);
}
