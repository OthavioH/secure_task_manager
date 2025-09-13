import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:simple_rpg_system/features/auth/exceptions/login_exception.dart';
import 'package:simple_rpg_system/features/auth/exceptions/refresh_token_exception.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Dio _httpClient;

  AuthRepositoryImpl({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  @override
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
    } on DioException catch (error, st) {
      log(
        "DioException while trying to authenticate user",
        error: error,
        stackTrace: st,
      );

      final statusCode = error.response?.statusCode;

      throw LoginException.fromStatusCode(statusCode);
    } catch (e, st) {
      log(
        "Unknown exception while trying to authenticate user",
        error: e,
        stackTrace: st,
      );
      throw const LoginException();
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final response = await _httpClient.post(
        "/auth/refresh",
        options: Options(
          headers: {'Authorization': 'Bearer $refreshToken'},
        ),
      );

      return response.data;
    } on DioException catch (error, st) {
      log(
        "DioException while trying to authenticate user",
        error: error,
        stackTrace: st,
      );

      final statusCode = error.response?.statusCode;

      throw RefreshTokenException.fromStatusCode(statusCode);
    } catch (e, st) {
      log(
        "Unknown exception while trying to authenticate user",
        error: e,
        stackTrace: st,
      );
      throw const RefreshTokenException();
    }
  }
}
