
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<void> login(String username, String password) async {
    final loginJSON = await _authRepository.login(username, password);
    final token = loginJSON['token'];
    await _authRepository.saveToken(token);
  }

  String? getToken() {
    return _authRepository.getToken();
  }

  Future<void> deleteToken() async {
    await _authRepository.deleteToken();
  }
}