
import 'package:simple_rpg_system/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:simple_rpg_system/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final LocalAuthDataSource _localAuthDataSource;
  final RemoteAuthDataSource _remoteAuthDataSource;

  AuthRepositoryImpl({
    required LocalAuthDataSource localAuthDataSource,
    required RemoteAuthDataSource remoteAuthDataSource,
  })  : _localAuthDataSource = localAuthDataSource,
        _remoteAuthDataSource = remoteAuthDataSource;

  @override
  Future<Map<String,dynamic>> login(String username, String password) {
    return _remoteAuthDataSource.login(username, password);
  }

  @override
  Future<void> deleteToken() {
    return _localAuthDataSource.deleteToken();
  }

  @override
  String? getToken() {
    return _localAuthDataSource.getToken();
  }

  @override
  Future<void> saveToken(String token) {
    return _localAuthDataSource.saveToken(token);
  }
  
}