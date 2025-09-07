import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/domain/repositories/task_status_repository.dart';
import 'package:simple_rpg_system/features/user/domain/repositories/user_repository.dart';

class TaskStatusService {
  final UserRepository userRepository;
  final TaskStatusRepository repository;

  TaskStatusService(this.userRepository, this.repository);

  Future<List<TaskStatus>> getAllStatuses() async {
    final user = await userRepository.getLoggedUser();

    if(user == null) {
      throw Exception('No logged user found');
    }

    return await repository.getAll(userId: user.id);
  }

  Future<TaskStatus> createStatus({
    required String name,
  }) async {
    final user = await userRepository.getLoggedUser();

    if(user == null) {
      throw Exception('No logged user found');
    }

    return await repository.create(name: name, userId: user.id);
  }

  Future<TaskStatus> updateStatus(TaskStatus status) async {
    return await repository.update(status);
  }

  Future<void> deleteStatus(String id) async {
    await repository.delete(id);
  }
}
