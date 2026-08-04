import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/services/admin_auth_service.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final result = await getIt<AdminAuthService>().login(
        email: email,
        password: password,
      );

      await getIt<CacheHelper>().saveData(
        key: 'accessToken',
        value: result.accessToken,
      );

      await getIt<CacheHelper>().saveData(
        key: 'refreshToken',
        value: result.refreshToken,
      );

      emit(AuthSuccess());
    } on DioException catch (e) {
      emit(
        AuthFailure(
          e.response?.data.toString() ?? 'Something went wrong',
        ),
      );
    } catch (e) {
      emit(
        AuthFailure(
          e.toString(),
        ),
      );
    }
  }
}