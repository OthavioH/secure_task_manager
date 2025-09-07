import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/data/repositories/task_status_repository_impl.dart';
import 'package:simple_rpg_system/features/task_status/domain/repositories/task_status_repository.dart';
import 'package:simple_rpg_system/features/task_status/domain/services/task_status_service.dart';
import 'package:simple_rpg_system/features/user/providers/user_repository_providers.dart';
import 'package:simple_rpg_system/shared/providers/http_client_provider.dart';

final taskStatusRepositoryProvider = Provider<TaskStatusRepository>((ref) {
  return TaskStatusRepositoryImpl(
    httpClient: ref.watch(httpClientProvider),
  );
});

final taskStatusServiceProvider = Provider<TaskStatusService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final taskStatusRepository = ref.watch(taskStatusRepositoryProvider);
  return TaskStatusService(userRepository, taskStatusRepository);
});
