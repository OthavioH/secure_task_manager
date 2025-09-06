import 'package:simple_rpg_system/features/auth/domain/models/user_tokens_model.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_tokens_repository.dart';
import 'package:simple_rpg_system/features/auth/exceptions/refresh_token_exception.dart';
import 'package:simple_rpg_system/features/user/domain/models/user_model.dart';
import 'package:simple_rpg_system/features/user/domain/repositories/user_repository.dart';

class AuthService {
  final AuthRepository _authRepository;
  final AuthTokensRepository _authTokensRepository;
  final UserRepository _userRepository;

  AuthService({
    required AuthRepository authRepository,
    required AuthTokensRepository authTokensRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _authTokensRepository = authTokensRepository,
       _userRepository = userRepository;

  Future<void> login(String username, String password) async {
    final loginJSON = await _authRepository.login(username, password);
    await _authTokensRepository.saveToken(
      UserTokensModel.fromJson(loginJSON['tokens']),
    );
    await _userRepository.saveLoggedUser(UserModel.fromJson(loginJSON['user']));
  }

  Future<UserTokensModel> refreshToken() async {
    final tokens = _authTokensRepository.getToken();
    if(tokens == null) {
      throw InvalidRefreshTokenException();
    }
    final response = await _authRepository.refreshToken(tokens.refreshToken);

    final tokensJSON = response['tokens'];
    if(tokensJSON == null) {
      throw RefreshTokenException();
    }

    final newTokens = UserTokensModel.fromJson(tokensJSON);

    _authTokensRepository.saveToken(newTokens);

    return newTokens;
  }

  UserTokensModel? getToken() {
    return _authTokensRepository.getToken();
  }

  Future<void> deleteToken() async {
    await _authTokensRepository.deleteToken();
  }

  void logout() {
    _authTokensRepository.deleteToken();
  }
}
