import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getUserTasks(String userId);
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
  });

  Future<void> deleteTask(String taskId);
}
