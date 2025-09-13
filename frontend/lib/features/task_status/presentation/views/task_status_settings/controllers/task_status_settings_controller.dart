import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/task_status_provider.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/providers/task_status_providers.dart';

final taskStatusSettingsControllerProvider =
    AsyncNotifierProvider.autoDispose<
      TaskStatusSettingsController,
      List<TaskStatus>
    >(TaskStatusSettingsController.new);

class TaskStatusSettingsController
    extends AutoDisposeAsyncNotifier<List<TaskStatus>> {
  late final service = ref.watch(taskStatusServiceProvider);

  @override
  Future<List<TaskStatus>> build() async {
    return await service.getAllStatuses();
  }

  Future<void> addStatus(TaskStatus status) async {
    state = AsyncData([...state.value ?? [], status]);
    ref.invalidate(taskStatusProvider);
  }

  Future<void> updateStatus(TaskStatus status) async {
    final stateIndex = state.value!.indexWhere((s) => s.id == status.id);
    if (stateIndex == -1) return;

    final updatedList = state.value!;
    updatedList[stateIndex] = status;

    state = AsyncData(updatedList);

    ref.invalidate(taskStatusProvider);
  }

  Future<void> deleteStatus(String id) async {
    final updatedList = state.value!;
    updatedList.removeWhere((status) => status.id == id);
    state = AsyncData(updatedList);
    ref.invalidate(taskStatusProvider);
  }
}
