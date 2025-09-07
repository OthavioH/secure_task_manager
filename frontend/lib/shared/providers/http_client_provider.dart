import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/core/config/environment_config.dart';
import 'package:simple_rpg_system/features/auth/data/interceptors/auth_interceptor.dart';
import 'package:simple_rpg_system/features/auth/data/providers/auth_repository_providers.dart';
import 'package:simple_rpg_system/features/auth/data/repositories/auth_repository_impl.dart';

final authInterceptorProvider = Provider.family<AuthInterceptor, Dio>((
  ref,
  dio,
) {
  return AuthInterceptor(
    authTokensRepository: ref.watch(
      authTokensRepositoryProvider,
    ),
    authRepository: AuthRepositoryImpl(
      httpClient: dio,
    ),
    dio: dio,
  );
});

final httpClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: EnvironmentConfig.instance.apiURL,
    ),
  );
  final authInterceptor = ref.watch(authInterceptorProvider(dio.clone()));
  dio.interceptors.add(authInterceptor);
  return dio;
});
