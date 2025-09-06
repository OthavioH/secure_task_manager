import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/auth/exceptions/login_exception.dart';
import 'package:simple_rpg_system/features/auth/exceptions/refresh_token_exception.dart';

class RemoteAuthDataSource {
  final Dio _httpClient;

  RemoteAuthDataSource(this._httpClient);

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _httpClient.post(
        "/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      return response.data;
    } on DioException catch (error,st) {
      log("DioException while trying to authenticate user", error: error, stackTrace: st);

      final statusCode = error.response?.statusCode;

      if(statusCode == 401) {
        throw WrongCredentialsLoginException();
      }

      throw LoginException();
    } catch (e,st) {
      log("Unknown exception while trying to authenticate user", error: e, stackTrace: st);
      throw LoginException();
    }
  }
  Future<Map<String, dynamic>> refreshTOken(String refreshToken) async {
    try {
      final response = await _httpClient.post(
        "/auth/refresh",
        options: Options(
          headers: {
            'Authorizaztion': 'Bearer $refreshToken'
          },
        )
      );

      return response.data;
    } on DioException catch (error,st) {
      log("DioException while trying to authenticate user", error: error, stackTrace: st);

      final statusCode = error.response?.statusCode;

      if(statusCode == 401) {
        throw InvalidRefreshTokenException();
      }

      throw RefreshTokenException();
    } catch (e,st) {
      log("Unknown exception while trying to authenticate user", error: e, stackTrace: st);
      throw RefreshTokenException();
    }
  }
}
