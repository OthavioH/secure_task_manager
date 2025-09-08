import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/domain/repositories/task_repository.dart';
import 'package:simple_rpg_system/features/task/exceptions/create_task_exception.dart';
import 'package:simple_rpg_system/features/task/exceptions/delete_task_exception.dart';
import 'package:simple_rpg_system/features/task/exceptions/get_task_exception.dart';
import 'package:simple_rpg_system/features/task/exceptions/update_task_exception.dart';

class TaskRepositoryImpl extends TaskRepository {
  final Dio _httpClient;

  TaskRepositoryImpl({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<TaskModel>> getUserTasks(String userId) async {
    try {
      final response = await _httpClient.get(
        '/tasks',
        queryParameters: {
          "userId": userId,
        },
      );

      return TaskModel.fromJsonList(response.data);
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to read tasks",
        error: error,
        stackTrace: stackTrace,
      );
      throw GetTaskException.fromStatusCode(error.response?.statusCode);
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to read tasks",
        error: error,
        stackTrace: stackTrace,
      );
      throw GetTaskException();
    }
  }

  @override
  Future<TaskModel> addTaskForUser({
    required String userId,
    required String title,
    required String description,
    required String taskStatusId,
  }) async {
    try {
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
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to create a task",
        error: error,
        stackTrace: stackTrace,
      );

      final statusCode = error.response?.statusCode;

      throw CreateTaskException.fromStatusCode(statusCode);
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to create a task",
        error: error,
        stackTrace: stackTrace,
      );
      throw CreateTaskException();
    }
  }

  @override
  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
    required String statusId,
  }) {
    try {
      return _httpClient.patch(
      '/tasks/$taskId',
      data: {
        "title": title,
        "description": description,
        "statusId": statusId,
      },
    );
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to update a task",
        error: error,
        stackTrace: stackTrace,
      );
      throw UpdateTaskException.fromStatusCode(error.response?.statusCode);
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to update a task",
        error: error,
        stackTrace: stackTrace,
      );
      throw UpdateTaskException();
    }
  }

  @override
  Future<void> deleteTask(String taskId) {
    try {
      return _httpClient.delete('/tasks/$taskId');
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to delete a task",
        error: error,
        stackTrace: stackTrace,
      );
      throw DeleteTaskException.fromStatusCode(error.response?.statusCode);
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to delete a task",
        error: error,
        stackTrace: stackTrace,
      );
      throw DeleteTaskException();
    }
  }
}
