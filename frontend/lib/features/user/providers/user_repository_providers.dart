import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/user/data/repositories/user_repository_impl.dart';
import 'package:simple_rpg_system/features/user/domain/repositories/user_repository.dart';
import 'package:simple_rpg_system/shared/providers/http_client_provider.dart';
import 'package:simple_rpg_system/shared/providers/shared_preferences_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    ref.watch(httpClientProvider),
    ref.watch(sharedPreferencesProvider).requireValue,
  );
});
