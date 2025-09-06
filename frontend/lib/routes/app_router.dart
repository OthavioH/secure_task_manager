import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/user_tasks_screen.dart';
import 'package:simple_rpg_system/features/user/routes/user_routes.dart';

class AppRouter {
  AppRouter._();

  static final String homeRoute = '/';

  static GoRouter get router => GoRouter(
    initialLocation: AuthRoutes.loginRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const UserTasksScreen(),
      ),
      ...AuthRoutes.routes,
      ...UserRoutes.routes,
    ],
  );
}
