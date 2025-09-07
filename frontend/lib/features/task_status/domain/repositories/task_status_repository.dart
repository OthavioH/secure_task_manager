import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

abstract class TaskStatusRepository {
  Future<void> delete(String id);
  Future<List<TaskStatus>> getAll({
    required String userId,
  });
  Future<TaskStatus> create({
    required String name,
    required String userId,
  });
  Future<TaskStatus> update(TaskStatus taskStatus);
}