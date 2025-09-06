class UserModel {
  final String id;
  final String username;

  UserModel({
    required this.id,
    required this.username,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
    };
  }
}
