
import 'dart:convert';

import 'package:simple_rpg_system/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:simple_rpg_system/features/auth/domain/models/user_tokens_model.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_tokens_repository.dart';

class AuthTokensRepositoryImpl extends AuthTokensRepository {
  final LocalAuthDataSource _localAuthDataSource;

  AuthTokensRepositoryImpl({
    required LocalAuthDataSource localAuthDataSource,
  })  : _localAuthDataSource = localAuthDataSource;

  @override
  Future<void> deleteToken() {
    return _localAuthDataSource.deleteToken();
  }

  @override
  UserTokensModel? getToken() {
    final tokenStringJSON = _localAuthDataSource.getToken();
    if(tokenStringJSON == null) {
      return null;
    }
    final tokenJSON = jsonDecode(tokenStringJSON);

    return UserTokensModel.fromJson(tokenJSON);
  }

  @override
  Future<void> saveToken(UserTokensModel token) {
    final tokenStringJSON = jsonEncode(token.toJson());
    return _localAuthDataSource.saveToken(tokenStringJSON);
  }
  
}