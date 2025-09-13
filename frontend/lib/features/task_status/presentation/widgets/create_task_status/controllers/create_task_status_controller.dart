import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/providers/task_status_providers.dart';

sealed class CreateTaskStatusState {
  bool get isLoading => this is CreateTaskStatusLoading;
}

class CreateTaskStatusInitial extends CreateTaskStatusState {}
class CreateTaskStatusLoading extends CreateTaskStatusState {}
class CreateTaskStatusSuccess extends CreateTaskStatusState {
  final TaskStatus status;
  CreateTaskStatusSuccess(this.status);
}
class CreateTaskStatusError extends CreateTaskStatusState {
  final String message;
  CreateTaskStatusError(this.message);
}

final createTaskStatusControllerProvider = NotifierProvider<CreateTaskStatusController, CreateTaskStatusState>(CreateTaskStatusController.new);

class CreateTaskStatusController extends Notifier<CreateTaskStatusState> {
  @override
  CreateTaskStatusState build() {
    return CreateTaskStatusInitial();
  }

  Future<void> createTaskStatus(String name) async {
    state = CreateTaskStatusLoading();
    try {
      final service = ref.watch(taskStatusServiceProvider);
      final status = await service.createStatus(name: name);
      state = CreateTaskStatusSuccess(status);
    } catch (e) {
      state = CreateTaskStatusError(e.toString());
    }
  }
}
