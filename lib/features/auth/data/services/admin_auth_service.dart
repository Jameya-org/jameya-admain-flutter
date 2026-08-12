import 'package:dio/dio.dart';
import 'package:jameya_admin/core/services/api_config.dart';

import '../models/admin_login_model.dart';

class AdminAuthService {
  final Dio dio;

  AdminAuthService(this.dio);

  Future<AdminLoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      ApiConfig.adminLogin,
      data: {
        'email': email.trim(),
        'password': password.trim(),
      },
    );

    return AdminLoginModel.fromJson(response.data);
  }
}