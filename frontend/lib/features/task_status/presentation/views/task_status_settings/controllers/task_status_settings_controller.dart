import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  }

  Future<void> updateStatus(TaskStatus status) async {
    final stateIndex = state.value!.indexWhere((s) => s.id == status.id);
    if (stateIndex == -1) return;

    final updatedList = state.value!;
    updatedList[stateIndex] = status;

    state = AsyncData(updatedList);
  }

  Future<void> deleteStatus(String id) async {
    final originalStatus = state.value!.firstWhere((status) => status.id == id);

    try {
      final updatedList = state.value!;
      updatedList.removeWhere((status) => status.id == id);
      state = AsyncData(updatedList);

      await service.deleteStatus(id);
    } catch (e) {
      state = AsyncData([...state.value ?? [], originalStatus]);
    }
  }
}
