
import 'package:dio/dio.dart';

import '../../data/services/profile_service.dart';


class ProfileRepo {
  final ProfileService profileService;

  ProfileRepo(this.profileService);

  Future<Response> getProfile() async {
    return await profileService.getProfile();
  }
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await profileService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}