import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/core/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AppBloc>(),
      child: BlocSelector<AppBloc, AppState, AppThemeMode>(
        selector: (state) => state.themeMode,
        builder: (context, themeMode) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              title: 'Cat Breeds',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: appRouter,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: (context, child) => Stack(
                children: [
                  child!,
                  BlocSelector<AppBloc, AppState, bool>(
                    selector: (state) => state.status == AppStatus.loading,
                    builder: (context, isLoading) {
                      if (!isLoading) return const SizedBox.shrink();
                      return const GlobalLoadingOverlay();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
