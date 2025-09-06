
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/providers/task_providers.dart';

final userTasksControllerProvider = AutoDisposeAsyncNotifierProvider<UserTasksController, List<TaskModel>>(UserTasksController.new);

class UserTasksController extends AutoDisposeAsyncNotifier<List<TaskModel>> {
  @override
  FutureOr<List<TaskModel>> build() async {
    final taskService = ref.watch(taskServiceProvider);
    return await taskService.getTasksForCurrentUser();
  }

  void addTask(TaskModel task) {
    state = AsyncData([...state.value ?? [], task]);
  }

  void updateTask(TaskModel updatedTask) {
    final currentTasks = state.value ?? [];
    final taskIndex = currentTasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      currentTasks[taskIndex] = updatedTask;
      state = AsyncData([...currentTasks]);
    }
  }

  void deleteTask(String taskId) async {
    final originalTask = state.value?.firstWhere((task) => task.id == taskId);
    if (originalTask == null) return;

    final currentTasks = state.value ?? [];
    currentTasks.remove(originalTask);

    state = AsyncData(currentTasks);

    final taskService = ref.watch(taskServiceProvider);

    try {
      await taskService.deleteTask(taskId);
    } catch (e) {
      state = AsyncData([...currentTasks, originalTask]);
    }
  }
}