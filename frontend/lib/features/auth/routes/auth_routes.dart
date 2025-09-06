import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/presentation/views/login_screen/login_screen.dart';

class AuthRoutes {
  AuthRoutes._();

  static const String loginRoute = '/login';

  static List<GoRoute> get routes => [
    GoRoute(
      path: loginRoute,
      builder: (context, state) => const LoginScreen(),
    ),
  ];
}
