import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/services/shared_preferences_service.dart';
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

      await SecureStorageService.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );

      await SharedPreferencesService.setLoggedIn(true);

      emit(AuthSuccess());
    } on DioException catch (e) {
      emit(AuthFailure(_extractErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong. Please try again.'));
    }
  }

  String _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        return (errors.values.firstOrNull ?? '').toString();
      }
    } else if (data is String && data.trim().isNotEmpty) {
      return data;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Could not connect to the server. Check your internet.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}