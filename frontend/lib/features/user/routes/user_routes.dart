import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/user/presentation/views/create_account_screen/create_account_screen.dart';

class UserRoutes {
  UserRoutes._();

  static const String createAccountRoute = '/sign-up';

  static List<GoRoute> get routes => [
    GoRoute(
      path: createAccountRoute,
      builder: (context, state) => const CreateAccountScreen(),
    ),
  ];
}
