
import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository{
  final Dio _httpClient;

  TaskRepositoryImpl({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<TaskModel>> getUserTasks(String userId) async {
    final response = await _httpClient.get('/tasks', queryParameters: {
      "userId": userId,
    });

    return TaskModel.fromJsonList(response.data);
  }
  
}