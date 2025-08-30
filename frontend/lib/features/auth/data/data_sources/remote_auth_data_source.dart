
import 'package:dio/dio.dart';

class RemoteAuthDataSource {
  final Dio _httpClient;

  RemoteAuthDataSource(this._httpClient);

  Future<Map<String,dynamic>> login(String username, String password) async {
    throw UnimplementedError();
  }

  Future<void> logout() async {
    throw UnimplementedError();
  }
}