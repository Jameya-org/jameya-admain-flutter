class AdminLoginModel {
  final String accessToken;
  final String refreshToken;

  AdminLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AdminLoginModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return AdminLoginModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}