import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/auth/domain/providers/auth_service_providers.dart';
import 'package:simple_rpg_system/shared/controllers/auth_guard_state.dart';

final authGuardControllerProvider = AsyncNotifierProvider.autoDispose<AuthGuardController, AuthGuardState>(AuthGuardController.new);

class AuthGuardController extends AutoDisposeAsyncNotifier<AuthGuardState> {
  @override
  FutureOr<AuthGuardState> build() {
    final authService = ref.watch(authServiceProvider);


    final token = authService.getToken();
    log("token $token");

    if (token != null) {
      return AuthGuardAuthorizedState();
    }
    return AuthGuardNotAuthorizedState();
  }
}
