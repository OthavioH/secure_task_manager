class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
  });

  factory TaskModel.fromJson(dynamic json) {
    return TaskModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
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
