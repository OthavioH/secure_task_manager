

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/auth/domain/providers/auth_service_providers.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_state.dart';

final signOutControllerProvider = NotifierProvider.autoDispose<SignOutController, SignOutState>(SignOutController.new);

class SignOutController extends AutoDisposeNotifier<SignOutState> {
  @override
  SignOutState build() {
    return SignOutInitial();
  }

  Future<void> signOut() async {
    state = SignOutLoading();

    try {
      final authService = ref.watch(authServiceProvider);

      authService.logout();
      state = SignOutSuccess();
    } catch (e) {
      state = SignOutError('Failed to sign out');
    }
  }
}