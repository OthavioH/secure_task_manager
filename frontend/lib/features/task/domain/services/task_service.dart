import 'dart:developer';

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
    } catch (error, stackTrace) {
      log('Error fetching tasks:', error: error, stackTrace: stackTrace);
      return [];
    }
  }

  Future<TaskModel> createTask(String title, String description, String taskStatusId) async {
    try {
      final user = await _userRepository.getLoggedUser();
      if (user != null) {
        return _taskRepository.addTaskForUser(
          userId: user.id,
          title: title,
          description: description,
          taskStatusId: taskStatusId,
        );
      } else {
        throw Exception('No logged-in user found');
      }
    } catch (error, stackTrace) {
      log('Error creating task:', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
  }) async {
    try {
      final user = await _userRepository.getLoggedUser();
      if (user != null) {
        await _taskRepository.updateTask(
          taskId: taskId,
          title: title,
          description: description,
        );
      } else {
        throw Exception('No logged-in user found');
      }
    } catch (error, stackTrace) {
      log('Error creating task:', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final user = await _userRepository.getLoggedUser();
      if (user != null) {
        await _taskRepository.deleteTask(taskId);
      } else {
        throw Exception('No logged-in user found');
      }
    } catch (error, stackTrace) {
      log('Error deleting task:', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
