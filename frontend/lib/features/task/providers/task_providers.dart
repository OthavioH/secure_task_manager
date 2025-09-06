import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/data/repositories/task_repository_impl.dart';
import 'package:simple_rpg_system/features/task/domain/repositories/task_repository.dart';
import 'package:simple_rpg_system/features/task/domain/services/task_service.dart';
import 'package:simple_rpg_system/features/user/providers/user_repository_providers.dart';
import 'package:simple_rpg_system/shared/providers/http_client_provider.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(
    httpClient: ref.watch(httpClientProvider),
  );
});

final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService(
    ref.watch(taskRepositoryProvider),
    ref.watch(userRepositoryProvider),
  );
});
