import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/presentation/views/create_account_screen/create_account_screen.dart';
import 'package:simple_rpg_system/features/auth/presentation/views/login_screen/login_screen.dart';

class AuthRoutes {
  AuthRoutes._();

  static const String loginRoute = '/login';
  static const String createAccountRoute = '/sign-up';

  static List<GoRoute> get routes => [
    GoRoute(
      path: loginRoute,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: createAccountRoute,
      builder: (context, state) => const CreateAccountScreen(),
    ),
  ];
}
