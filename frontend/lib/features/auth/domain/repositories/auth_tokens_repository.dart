
import 'package:simple_rpg_system/features/auth/domain/models/user_tokens_model.dart';

abstract class AuthTokensRepository {
  Future<void> saveToken(UserTokensModel tokens);
  UserTokensModel? getToken();
  Future<void> deleteToken();
}