class UserTokensModel {
  final String accessToken;
  final String refreshToken;

  const UserTokensModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserTokensModel.fromJson(Map<String, dynamic> json) {
    return UserTokensModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
