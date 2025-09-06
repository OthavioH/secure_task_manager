import 'package:dio/dio.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/domain/repositories/task_status_repository.dart';

class TaskStatusRepositoryImpl extends TaskStatusRepository {
	final Dio _httpClient;

	TaskStatusRepositoryImpl({
		required Dio httpClient,
	}) : _httpClient = httpClient;

		@override
		Future<List<TaskStatus>> getAll() async {
			final response = await _httpClient.get('/task-status');
			final data = response.data as List;
			return data.map((json) => TaskStatus.fromJson(json)).toList();
		}

		// Removido: getById

		@override
		Future<TaskStatus> create({
    required String name,
    }) async {
			final response = await _httpClient.post('/task-status', data: {
        'name': name,
      });
			return TaskStatus.fromJson(response.data);
		}

		@override
		Future<TaskStatus> update(TaskStatus taskStatus) async {
			final response = await _httpClient.patch('/task-status/${taskStatus.id}', data: taskStatus.toJson());
			return TaskStatus.fromJson(response.data);
		}

	@override
	Future<void> delete(String statusId) async {
		await _httpClient.delete('/task-status/$statusId');
	}
}
