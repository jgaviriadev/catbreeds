import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/core/router/shell_navigation_page.dart';
import 'package:cat_breeds/features/breeds/domain/entities/entities.dart';
import 'package:cat_breeds/features/breeds/presentation/pages/breed_detail_page.dart';
import 'package:cat_breeds/features/breeds/presentation/pages/breed_page.dart';
import 'package:cat_breeds/features/favorites/presentation/pages/favorites_page.dart';
import 'package:cat_breeds/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Main application router using GoRouter with named navigation.
///
/// Routes are organized by feature. Import feature route files and spread them here.
/// Includes TalkerRouteObserver for automatic navigation logging.
final appRouter = GoRouter(
  observers: [
    TalkerRouteObserver(sl<Talker>()), // Logs navigation events
  ],
  initialLocation: '/splash',
  routes: [
    // ───────────────── SPLASH ─────────────────
    GoRoute(
      name: SplashPage.routeName,
      path: '/splash',
      pageBuilder: (context, state) => const MaterialPage(
        name: SplashPage.routeName,
        child: SplashPage(),
      ),
    ),
    // ───────────────── GLOBAL - OUT MAIN SHELL ─────────────────
    GoRoute(
      name: BreedDetailPage.routeName,
      path: '/breed-detail',
      pageBuilder: (context, state) {
        final extraData = state.extra! as Map<String, dynamic>;
        final breed = extraData['breed'] as BreedEntity;
        final heroTag = extraData['heroTag'] as String?;
        return MaterialPage(
          name: BreedDetailPage.routeName,
          child: BreedDetailPage(breed: breed, heroTag: heroTag),
        );
      },
    ),
    // ───────────────── MAIN SHELL ─────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellNavigationPage(navigationShell: navigationShell);
      },
      branches: [
        // BREEDS TAB
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: BreedPage.routeName,
              path: '/breed',
              pageBuilder: (context, state) => const NoTransitionPage(
                name: BreedPage.routeName,
                child: BreedPage(),
              ),
            ),
          ],
        ),

        // FAVORITES TAB
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: FavoritesPage.routeName,
              path: '/favorites',
              pageBuilder: (context, state) => const NoTransitionPage(
                name: FavoritesPage.routeName,
                child: FavoritesPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
