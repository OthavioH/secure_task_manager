import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getUserTasks({
    required String userId,
    String? statusId,
  });
  Future<TaskModel> addTaskForUser({
    required String userId,
    required String title,
    required String description,
    required String taskStatusId,
  });

  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
    required String statusId,
  });

  Future<void> deleteTask(String taskId);
}
