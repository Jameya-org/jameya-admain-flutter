import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:jameya_admin/features/profile/presentation/view_model/profile_repo.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final response = await profileRepo.getProfile();

      emit(
        ProfileSuccess(
          response.data,
        ),
      );
    } on DioException catch (e) {
      emit(
        ProfileFailure(
          e.response?.data.toString() ?? 'حدث خطأ',
        ),
      );
    }
  }
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ProfileLoading());

    try {
      await profileRepo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      emit(
        ProfilePasswordSuccess(),
      );
    } on DioException catch (e) {
      emit(
        ProfileFailure(
          e.response?.data.toString() ?? 'حدث خطأ',
        ),
      );
    }
  }
}