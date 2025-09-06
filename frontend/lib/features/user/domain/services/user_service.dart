

import 'package:simple_rpg_system/features/user/domain/repositories/user_repository.dart';

class UserService {
  final UserRepository userRepository;

  UserService({
    required this.userRepository,
  });

  Future<void> createAccount({
    required String username,
    required String password,
  }) async {
    await userRepository.createAccount(username: username, password: password);
  } 
}