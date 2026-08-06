import 'package:dio/dio.dart';
import 'package:jameya_admin/core/services/api_config.dart';
import 'package:jameya_admin/core/services/secure_storage_service.dart';

/// Configures and provides a [Dio] instance used across all feature datasources.
///
/// Responsibilities:
///   • Sets base URL and default headers.
///   • Injects the Bearer token from SecureStorage before every request.
///   • Converts non-2xx responses into [DioException] for uniform error handling.
class DioFactory {
  DioFactory._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Intercept every request to attach the current access token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // Re-throw so the datasource / repository can handle it
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}
