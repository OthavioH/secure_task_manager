

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/user/domain/services/user_service.dart';
import 'package:simple_rpg_system/features/user/providers/user_repository_providers.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(
    userRepository: ref.watch(userRepositoryProvider),
  );
});