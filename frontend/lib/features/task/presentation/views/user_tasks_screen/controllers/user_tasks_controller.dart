
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/providers/task_providers.dart';

final userTasksControllerProvider = AutoDisposeAsyncNotifierProvider<UserTasksController, List<TaskModel>>(UserTasksController.new);

class UserTasksController extends AutoDisposeAsyncNotifier<List<TaskModel>> {
  @override
  FutureOr<List<TaskModel>> build() {
    final taskService = ref.watch(taskServiceProvider);
    return taskService.getTasksForCurrentUser();
  }
}