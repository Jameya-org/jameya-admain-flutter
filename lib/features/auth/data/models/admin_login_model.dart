class AdminLoginModel {
  final String accessToken;
  final String refreshToken;

  AdminLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AdminLoginModel.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw const FormatException(
        'Unexpected login response format',
      );
    }

    // API may wrap tokens inside a "data" object
    final Map<String, dynamic> body =
    json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final String? accessToken =
    body['accessToken']?.toString();

    final String? refreshToken =
    body['refreshToken']?.toString();

    if (accessToken == null || accessToken.isEmpty) {
      throw const FormatException(
        'Missing access token in login response',
      );
    }

    return AdminLoginModel(
      accessToken: accessToken,
      refreshToken: refreshToken ?? '',
    );
  }
}