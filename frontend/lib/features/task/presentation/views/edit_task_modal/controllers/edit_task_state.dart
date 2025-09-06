
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';

sealed class EditTaskState {

  bool get isLoading => this is EditTaskLoading;
}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskSuccess extends EditTaskState {
  final TaskModel task;

  EditTaskSuccess(this.task);
}

class EditTaskError extends EditTaskState {
  final String message;

  EditTaskError(this.message);
}