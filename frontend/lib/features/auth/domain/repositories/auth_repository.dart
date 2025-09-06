
abstract class AuthRepository {
  Future<Map<String,dynamic>> login(String username, String password);
  Future<Map<String,dynamic>> refreshToken(String refreshToken);
}