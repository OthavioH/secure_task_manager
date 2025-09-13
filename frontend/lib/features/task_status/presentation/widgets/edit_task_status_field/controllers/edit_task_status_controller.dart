import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/edit_task_status_field/controllers/edit_task_status_state.dart';
import 'package:simple_rpg_system/features/task_status/providers/task_status_providers.dart';

final editTaskStatusControllerProvider = NotifierProvider<EditTaskStatusController, EditTaskStatusState>(EditTaskStatusController.new);

class EditTaskStatusController extends Notifier<EditTaskStatusState> {
  @override
  EditTaskStatusState build() {
    return EditTaskStatusInitial();
  }

  Future<void> editTaskStatus({required String id, required String name}) async {
    state = EditTaskStatusLoading();
    try {
      final service = ref.watch(taskStatusServiceProvider);
      final status = await service.updateStatus(TaskStatus(id: id, name: name));
      state = EditTaskStatusSuccess(status);
    } catch (e) {
      state = EditTaskStatusError(e.toString());
    }
  }
}
