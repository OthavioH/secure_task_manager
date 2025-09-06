import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/domain/repositories/task_repository.dart';
import 'package:simple_rpg_system/features/user/domain/repositories/user_repository.dart';

class TaskService {
  final TaskRepository _taskRepository;
  final UserRepository _userRepository;

  TaskService(
    this._taskRepository,
    this._userRepository,
  );

  Future<List<TaskModel>> getTasksForCurrentUser() async {
    try {
      final user = await _userRepository.getLoggedUser();
      if (user != null) {
        return await _taskRepository.getUserTasks(user.id);
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
