
import 'package:simple_rpg_system/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteAuthDataSource _remoteAuthDataSource;

  AuthRepositoryImpl({
    required RemoteAuthDataSource remoteAuthDataSource,
  }) : _remoteAuthDataSource = remoteAuthDataSource;

  @override
  Future<Map<String,dynamic>> login(String username, String password) {
    return _remoteAuthDataSource.login(username, password);
  }
  
  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) {
    return _remoteAuthDataSource.refreshTOken(refreshToken);
  }
  
  
}