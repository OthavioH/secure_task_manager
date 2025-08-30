
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/auth/data/providers/auth_repository_providers.dart';
import 'package:simple_rpg_system/features/auth/domain/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    authRepository: ref.watch(authRepositoryProvider),
  );
});