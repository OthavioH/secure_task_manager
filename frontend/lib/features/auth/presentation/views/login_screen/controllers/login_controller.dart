import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/auth/domain/providers/auth_service_providers.dart';
import 'package:simple_rpg_system/features/auth/presentation/views/login_screen/controllers/login_state.dart';

final loginControllerProvider = NotifierProvider.autoDispose<LoginController, LoginState>(
  LoginController.new,
);

class LoginController extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    return LoginInitial();
  }

  void login({
    required String username,
    required String password,
  }) async {
    try {
      state = LoginLoading();

      final authService = ref.watch(authServiceProvider);

      await authService.login(username, password);

      state = LoginSuccess();
    } catch (e) {
      state = LoginFailure(e.toString());
    }
  }
}
