import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_rpg_system/features/user/domain/models/user_model.dart';
import 'package:simple_rpg_system/features/user/domain/repositories/user_repository.dart';
import 'package:simple_rpg_system/features/user/exception/create_account_exception.dart';

class UserRepositoryImpl extends UserRepository {
  final Dio _httpClient;
  final SharedPreferences _sharedPreferences;

  UserRepositoryImpl(
    this._httpClient,
    this._sharedPreferences,
  );

  final String _loggedUserKey = 'loggerUser';

  @override
  Future<Map<String, dynamic>> createAccount({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post(
        '/users',
        data: {
          "username": username,
          "password": password,
        },
      );

      return response.data;
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while creating account",
        error: error,
        stackTrace: stackTrace,
      );

      final statusCode = error.response?.statusCode;
      if (statusCode == 409) {
        throw UserAlreadyExistsException();
      }

      throw CreateAccountException();
    } catch (error, stackTrace) {
      log("Error creating account", error: error, stackTrace: stackTrace);
      throw CreateAccountException();
    }
  }

  @override
  Future<UserModel?> getLoggedUser() async {
    final userStringJSON = _sharedPreferences.getString(_loggedUserKey);

    if (userStringJSON == null) return null;

    final userJSON = jsonDecode(userStringJSON);

    final user = UserModel.fromJson(userJSON);

    return user;
  }

  @override
  Future<bool> saveLoggedUser(UserModel user) async {
    final userStringJSON = jsonEncode(user.toJson());

    return _sharedPreferences.setString(_loggedUserKey, userStringJSON);
  }

  @override
  Future<void> deleteLoggedUser() async {
    await _sharedPreferences.remove(_loggedUserKey);
  }
}
