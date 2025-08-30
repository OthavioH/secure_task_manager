

import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthDataSource {
  final SharedPreferences _sharedPreferences;

  LocalAuthDataSource(this._sharedPreferences);

  final String _authTokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(_authTokenKey, token);
  }

  String? getToken() {
    return _sharedPreferences.getString(_authTokenKey);
  }

  Future<void> deleteToken() async {
    await _sharedPreferences.remove(_authTokenKey);
  }
}