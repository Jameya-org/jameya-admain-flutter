import 'package:dio/dio.dart';

import '../models/admin_login_model.dart';

class AdminAuthService {
  final Dio dio;

  AdminAuthService(this.dio);

  Future<AdminLoginModel> login({
    required String email,
    required String password,
  }) async {
    print(email);
    print(password);

    final response = await dio.post(
      '/admin/auth/login',
      data: {
        'email': email.trim(),
        'password': password.trim(),
      },
    );

    print(response.data);

    return AdminLoginModel.fromJson(response.data);
  }
}