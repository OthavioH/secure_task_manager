
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/create_task_state.dart';
import 'package:simple_rpg_system/features/task/providers/task_providers.dart';

final createTaskControllerProvider = AutoDisposeNotifierProvider<CreateTaskController, CreateTaskState>(CreateTaskController.new);

class CreateTaskController extends AutoDisposeNotifier<CreateTaskState> {
  @override
   build() {
    return CreateTaskInitial();
  }

  Future<void> createTask(String title, String description, String taskStatusId) async {
    state = CreateTaskLoading();
    try {
      final taskService = ref.watch(taskServiceProvider);

      final createdTask = await taskService.createTask(title, description, taskStatusId);
      state = CreateTaskSuccess(createdTask);
    } catch (e, stackTrace) {
      log('Error creating task:', error: e, stackTrace: stackTrace);
      state = CreateTaskError('Failed to create task');
    }
  }
}