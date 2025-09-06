import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/domain/repositories/task_status_repository.dart';

class TaskStatusService {
  final TaskStatusRepository repository;

  TaskStatusService(this.repository);

  Future<List<TaskStatus>> getAllStatuses() async {
    return await repository.getAll();
  }

  Future<TaskStatus> createStatus({
    required String name,
  }) async {
    return await repository.create(name: name);
  }

  Future<TaskStatus> updateStatus(TaskStatus status) async {
    return await repository.update(status);
  }

  Future<void> deleteStatus(String id) async {
    await repository.delete(id);
  }
}
