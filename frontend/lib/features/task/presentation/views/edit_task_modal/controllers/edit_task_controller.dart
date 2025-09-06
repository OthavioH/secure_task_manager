import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/presentation/views/edit_task_modal/controllers/edit_task_state.dart';
import 'package:simple_rpg_system/features/task/providers/task_providers.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

final editTaskControllerProvider =
    AutoDisposeNotifierProvider<EditTaskController, EditTaskState>(
      EditTaskController.new,
    );

class EditTaskController extends AutoDisposeNotifier<EditTaskState> {
  @override
  build() {
    return EditTaskInitial();
  }

  Future<void> editTask({
    required String title,
    required String userId,
    required String description,
    required String taskId,
    required TaskStatus status,
  }) async {
    state = EditTaskLoading();
    try {
      final taskService = ref.watch(taskServiceProvider);

      await taskService.updateTask(
        taskId: taskId,
        title: title,
        description: description,
      );
      state = EditTaskSuccess(
        TaskModel(
          id: taskId,
          userId: userId,
          title: title,
          description: description,
          status: status,
        ),
      );
    } catch (e, stackTrace) {
      log('Error creating task:', error: e, stackTrace: stackTrace);
      state = EditTaskError('Failed to create task');
    }
  }
}
