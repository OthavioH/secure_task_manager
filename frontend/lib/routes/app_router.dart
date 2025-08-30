import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/home/presentation/home_screen/home_screen.dart';

class AppRouter {
  AppRouter._();

  static final String homeRoute = '/';

  static GoRouter get router => GoRouter(
    initialLocation: AuthRoutes.loginRoute,
    routes: [
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      ...AuthRoutes.routes,
    ],
  );
}
