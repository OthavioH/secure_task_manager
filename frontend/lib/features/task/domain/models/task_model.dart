import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final TaskStatus status;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
  });

  factory TaskModel.fromJson(dynamic json) {
    return TaskModel(
      id: json['id'],
      userId: json['user']['id'],
      title: json['title'],
      description: json['description'],
      status: TaskStatus.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
    };
  }

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map<TaskModel>((json)=>TaskModel.fromJson(json)).toList();
  }
}
