import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

abstract class TaskStatusRepository {
  Future<void> delete(String id);
  Future<List<TaskStatus>> getAll();
  Future<TaskStatus> create({
    required String name,
  });
  Future<TaskStatus> update(TaskStatus taskStatus);
}