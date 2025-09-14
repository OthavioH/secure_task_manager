import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/domain/models/user_tokens_model.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_tokens_repository.dart';
import 'package:simple_rpg_system/features/auth/exceptions/refresh_token_exception.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/routes/app_router.dart';

class AuthInterceptor extends Interceptor {
  final AuthTokensRepository _authTokensRepository;
  final Dio _dio;
  final AuthRepository _authRepository;

  AuthInterceptor({
    required AuthTokensRepository authTokensRepository,
    required Dio dio,
    required AuthRepository authRepository,
  }) : _authTokensRepository = authTokensRepository,
       _dio = dio,
       _authRepository = authRepository;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authorizationHeader = options.headers['Authorization'];
    if(authorizationHeader == null) {
      final tokens = _authTokensRepository.getToken();
      if(tokens != null) {
        options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final tokens = _authTokensRepository.getToken();

        if (tokens == null) {
          return handler.reject(err);
        }

        final newTokens = await _authRepository.refreshToken(
          tokens.refreshToken,
        );

        final newTokensJSON = newTokens['tokens'];

        if (newTokensJSON == null) {
          return handler.reject(err);
        }

        final newTokensModel = UserTokensModel.fromJson(newTokensJSON);

        await _authTokensRepository.saveToken(newTokensModel);

        final options = err.requestOptions;
        options.headers['Authorization'] =
            'Bearer ${newTokensModel.accessToken}';

        final response = await _dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (e) {
        if(e.response?.statusCode == 401) {
          log("Refresh token expired", error: e, stackTrace: e.stackTrace);
          _authTokensRepository.deleteToken();
          navigatorKey.currentContext?.go(AuthRoutes.loginRoute);
          return handler.reject(err);
        }
        return handler.reject(e);
      } on RefreshTokenException catch (error, stackTrace) {
        log("Refresh token expired", error: error, stackTrace: stackTrace);
        _authTokensRepository.deleteToken();
        navigatorKey.currentContext?.go(AuthRoutes.loginRoute);
        return handler.reject(err);
      }
    }

    super.onError(err, handler);
  }
}
