
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';

sealed class CreateTaskState {

  bool get isLoading => this is CreateTaskLoading;
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {
  final TaskModel task;

  CreateTaskSuccess(this.task);
}

class CreateTaskError extends CreateTaskState {
  final String message;

  CreateTaskError(this.message);
}