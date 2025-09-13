import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

sealed class EditTaskStatusState {
  bool get isLoading => this is EditTaskStatusLoading;
}

class EditTaskStatusInitial extends EditTaskStatusState {}

class EditTaskStatusLoading extends EditTaskStatusState {}

class EditTaskStatusSuccess extends EditTaskStatusState {
  final TaskStatus status;
  EditTaskStatusSuccess(this.status);
}

class EditTaskStatusError extends EditTaskStatusState {
  final String message;
  EditTaskStatusError(this.message);
}
