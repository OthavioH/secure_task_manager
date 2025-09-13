
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/task_status_edit_state.dart';

final taskStatusEditStateProvider = NotifierProvider.autoDispose.family<TaskStatusEditStateController, TaskStatusEditState, String>(TaskStatusEditStateController.new);

class TaskStatusEditStateController extends AutoDisposeFamilyNotifier<TaskStatusEditState, String> {
  @override
   build(String statusId) {
    return TaskStatusEditStateInitial();
  }

  void startEditing() {
    state = TaskStatusEditStateEditing();
  }

  void stopEditing() {
    state = TaskStatusEditStateInitial();
  }
}