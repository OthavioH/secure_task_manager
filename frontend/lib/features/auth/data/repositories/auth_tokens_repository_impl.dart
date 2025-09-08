
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_rpg_system/features/auth/domain/models/user_tokens_model.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_tokens_repository.dart';

class AuthTokensRepositoryImpl extends AuthTokensRepository {
  final SharedPreferences _sharedPreferences;

  AuthTokensRepositoryImpl(this._sharedPreferences);

  final String _authTokenKey = 'auth_token';

  @override
  Future<void> deleteToken() {
    return _sharedPreferences.remove(_authTokenKey);
  }

  @override
  UserTokensModel? getToken() {
    final tokenStringJSON = _sharedPreferences.getString(_authTokenKey);
    if(tokenStringJSON == null) {
      return null;
    }
    final tokenJSON = jsonDecode(tokenStringJSON);

    return UserTokensModel.fromJson(tokenJSON);
  }

  @override
  Future<void> saveToken(UserTokensModel token) {
    final tokenStringJSON = jsonEncode(token.toJson());
    return _sharedPreferences.setString(_authTokenKey, tokenStringJSON);
  }
  
}