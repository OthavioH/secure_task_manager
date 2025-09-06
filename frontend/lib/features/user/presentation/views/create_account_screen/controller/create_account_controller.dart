import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/user/presentation/views/create_account_screen/controller/create_account_state.dart';
import 'package:simple_rpg_system/features/user/providers/user_service_providers.dart';

final createAccountControllerProvider =
    NotifierProvider.autoDispose<CreateAccountController, CreateAccountState>(
      CreateAccountController.new,
    );

class CreateAccountController extends AutoDisposeNotifier<CreateAccountState> {
  @override
  CreateAccountState build() {
    return CreateAccountInitial();
  }

  void createAccount({
    required String username,
    required String password,
  }) async {
    try {
      state = CreateAccountLoading();

      final userService = ref.watch(userServiceProvider);

      await userService.createAccount(
        username: username,
        password: password,
      );

      state = CreateAccountSuccess();
    } catch (e) {
      state = CreateAccountFailure(e.toString());
    }
  }
}
