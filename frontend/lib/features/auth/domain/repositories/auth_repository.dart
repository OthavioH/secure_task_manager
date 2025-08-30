
abstract class AuthRepository {
  Future<Map<String,dynamic>> login(String username, String password);
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> deleteToken();
}