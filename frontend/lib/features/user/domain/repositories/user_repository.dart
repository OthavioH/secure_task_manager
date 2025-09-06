
import 'package:simple_rpg_system/features/user/domain/models/user_model.dart';

abstract class UserRepository {
  Future<Map<String,dynamic>> createAccount({
    required String username,
    required String password,
  });

  Future<UserModel?> getLoggedUser();

  Future<bool> saveLoggedUser(UserModel user);

  Future<void> deleteLoggedUser();
}