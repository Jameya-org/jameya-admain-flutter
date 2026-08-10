import 'package:dio/dio.dart';
import 'package:jameya_admin/core/services/api_config.dart';
import 'package:jameya_admin/core/services/secure_storage_service.dart';

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

    final loginModel = AdminLoginModel.fromJson(
      response.data,
    );

    // حفظ الـ Access Token والـ Refresh Token
    await SecureStorageService.saveTokens(
      accessToken: loginModel.accessToken,
      refreshToken: loginModel.refreshToken,
    );

    return loginModel;
  }
}