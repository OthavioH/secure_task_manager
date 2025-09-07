

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/delete_task_state.dart';
import 'package:simple_rpg_system/features/task_status/providers/task_status_providers.dart';

final deleteTaskControllerProvider = AutoDisposeNotifierProvider<DeleteTaskController, DeleteTaskState>(DeleteTaskController.new);

class DeleteTaskController extends AutoDisposeNotifier<DeleteTaskState> {
  @override
  build() {
    return DeleteTaskInitialState();
  }

  Future<void> deleteTask(String statusId) async {
    state = DeleteTaskLoadingState();
    try {
      final taskStatusService = ref.watch(taskStatusServiceProvider);

      await taskStatusService.deleteStatus(statusId);
      state = DeleteTaskSuccessState();
    } catch (e, stackTrace) {
      log('Error deleting task:', error: e, stackTrace: stackTrace);
      state = DeleteTaskErrorState(e.toString());
    }
  }
}