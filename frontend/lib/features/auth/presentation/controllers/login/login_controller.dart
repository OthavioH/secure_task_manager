
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/auth/domain/providers/auth_service_providers.dart';
import 'package:simple_rpg_system/features/auth/presentation/controllers/login/login_state.dart';

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(LoginController.new);

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginInitial();
  }

  void login({
    required String username,
    required String password,
  }) async {
    state = LoginLoading();
    
    final authService = ref.watch(authServiceProvider);

    await authService.login(username, password);
  }
}