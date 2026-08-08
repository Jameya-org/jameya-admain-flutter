import 'package:dio/dio.dart';

class ProfileService {
  final Dio dio;

  ProfileService(this.dio);

  Future<Response> getProfile() async {
    return await dio.get('/admin/profile');
  }
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await dio.patch(
      '/admin/profile/password',
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }
}