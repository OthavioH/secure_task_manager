import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:simple_rpg_system/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:simple_rpg_system/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:simple_rpg_system/features/auth/data/repositories/auth_tokens_repository_impl.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:simple_rpg_system/features/auth/domain/repositories/auth_tokens_repository.dart';
import 'package:simple_rpg_system/shared/providers/http_client_provider.dart';
import 'package:simple_rpg_system/shared/providers/shared_preferences_provider.dart';

final localAuthDataSourceProvider = Provider<LocalAuthDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).value;

  if (sharedPreferences == null) {
    throw Exception('SharedPreferences not yet available.');
  }

  return LocalAuthDataSource(
    sharedPreferences,
  );
});

final remoteAuthDataSourceProvider = Provider<RemoteAuthDataSource>((ref) {
  return RemoteAuthDataSource(
    ref.watch(httpClientProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteAuthDataSource: ref.watch(remoteAuthDataSourceProvider),
  );
});

final authTokensRepositoryProvider = Provider<AuthTokensRepository>((ref) {
  return AuthTokensRepositoryImpl(
    localAuthDataSource: ref.watch(localAuthDataSourceProvider),
  );
});
