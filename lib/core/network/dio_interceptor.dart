import 'package:dio/dio.dart';

import '../cache/cache_helper.dart';
import '../services/services_locator.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final token = getIt<CacheHelper>().getData(
      key: 'accessToken',
    );

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    print('ERROR: ${err.response?.statusCode}');
    handler.next(err);
  }
}