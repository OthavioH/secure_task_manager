import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/task_status_provider.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/controllers/task_status_state.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

final tasksStatusControllerProvider = NotifierProvider.autoDispose<TasksStatusController, TaskStatusState>(TasksStatusController.new);

class TasksStatusController extends AutoDisposeNotifier<TaskStatusState> {
  @override
  TaskStatusState build() {
    fetchStatuses();
    return TaskStatusState.initial();
  }

  void fetchStatuses() async {
    final statuses = await ref.watch(taskStatusProvider.future);
    state = state.copyWith(statuses: statuses);
  }

  void toggleStatus(TaskStatus status) {
    if (state.selectedStatus?.id == status.id) {
      state = state.resetSelectedStatus();
    } else {
      state = state.copyWith(selectedStatus: status);
    }
  }

  void selectAllStatuses() {
    state = state.resetSelectedStatus();
  }
}
