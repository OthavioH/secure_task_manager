import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/user_tasks_screen.dart';
import 'package:simple_rpg_system/features/user/routes/user_routes.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/task_status_settings_screen.dart';
import 'package:simple_rpg_system/shared/controllers/auth_guard_controller.dart';
import 'package:simple_rpg_system/shared/controllers/auth_guard_state.dart';
import 'package:simple_rpg_system/shared/providers/shared_preferences_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final _container = ProviderContainer();

class AppRouter {
  AppRouter._();

  static final String homeRoute = '/';
  static final String settingsRoute = '/settings';

  static GoRouter get router => GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AuthRoutes.loginRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const UserTasksScreen(),
      ),
      GoRoute(
        path: settingsRoute,
        builder: (context, state) => const TaskStatusSettingsScreen(),
      ),
      ...AuthRoutes.routes,
      ...UserRoutes.routes,
    ],
    redirect: (context, state) async {
      await _container.read(sharedPreferencesProvider.future);
      final authState = await _container.read(
        authGuardControllerProvider.future,
      );

      final isLoggedIn = authState is AuthGuardAuthorizedState;

      final isGoingToLogin = state.uri.toString() == AuthRoutes.loginRoute;
      if (!isLoggedIn && !isGoingToLogin) {
        return AuthRoutes.loginRoute;
      }
      if(isLoggedIn && isGoingToLogin) {
        return AppRouter.homeRoute;
      }
      return null;
    },
  );
}
