import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final Dio _httpClient;

  TaskRepositoryImpl({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<TaskModel>> getUserTasks(String userId) async {
    final response = await _httpClient.get(
      '/tasks',
      queryParameters: {
        "userId": userId,
      },
    );

    return TaskModel.fromJsonList(response.data);
  }

  @override
  Future<TaskModel> addTaskForUser({
    required String userId,
    required String title,
    required String description,
    required String taskStatusId,
  }) async {
    final response = await _httpClient.post(
      '/tasks',
      data: {
        "userId": userId,
        "title": title,
        "description": description,
        "statusId": taskStatusId,
      },
    );

    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
  }) {
    return _httpClient.patch(
      '/tasks/$taskId',
      data: {
        "title": title,
        "description": description,
      },
    );
  }

  @override
  Future<void> deleteTask(String taskId) {
    return _httpClient.delete('/tasks/$taskId');
  }
}
