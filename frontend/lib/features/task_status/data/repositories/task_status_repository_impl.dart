import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/task/exceptions/get_task_exception.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/domain/repositories/task_status_repository.dart';
import 'package:simple_rpg_system/features/task_status/exceptions/create_task_status_exception.dart';
import 'package:simple_rpg_system/features/task_status/exceptions/delete_task_status_exception.dart';
import 'package:simple_rpg_system/features/task_status/exceptions/update_task_status_exception.dart';

class TaskStatusRepositoryImpl extends TaskStatusRepository {
  final Dio _httpClient;

  TaskStatusRepositoryImpl({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<TaskStatus>> getAll({
    required String userId,
  }) async {
    try {
      final response = await _httpClient.get(
        '/task-status',
        queryParameters: {
          'userId': userId,
        },
      );
      final data = response.data as List;
      return data.map((json) => TaskStatus.fromJson(json)).toList();
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to read task statuses",
        error: error,
        stackTrace: stackTrace,
      );
      throw GetTaskException.fromStatusCode(error.response?.statusCode);
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to read task statuses",
        error: error,
        stackTrace: stackTrace,
      );
      throw const GetTaskException();
    }
  }

  @override
  Future<TaskStatus> create({
    required String name,
    required String userId,
  }) async {
    try {
      final response = await _httpClient.post(
        '/task-status',
        data: {
          'name': name,
          'userId': userId,
        },
      );
      return TaskStatus.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to create a task status",
        error: error,
        stackTrace: stackTrace,
      );
      throw CreateTaskStatusException.fromStatusCode(
        error.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to create a task status",
        error: error,
        stackTrace: stackTrace,
      );
      throw const CreateTaskStatusException();
    }
  }

  @override
  Future<TaskStatus> update(TaskStatus taskStatus) async {
    try {
      final response = await _httpClient.patch(
        '/task-status/${taskStatus.id}',
        data: taskStatus.toJson(),
      );
      return TaskStatus.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to update a task status",
        error: error,
        stackTrace: stackTrace,
      );
      throw UpdateTaskStatusException.fromStatusCode(
        error.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to update a task status",
        error: error,
        stackTrace: stackTrace,
      );
      throw const UpdateTaskStatusException();
    }
  }

  @override
  Future<void> delete(String statusId) async {
    try {
      await _httpClient.delete('/task-status/$statusId');
    } on DioException catch (error, stackTrace) {
      log(
        "DioException while trying to delete a task status",
        error: error,
        stackTrace: stackTrace,
      );
      throw DeleteTaskStatusException.fromStatusCode(
        error.response?.statusCode,
      );
    } catch (error, stackTrace) {
      log(
        "Unknown exception while trying to delete a task status",
        error: error,
        stackTrace: stackTrace,
      );
      throw const DeleteTaskStatusException();
    }
  }
}
