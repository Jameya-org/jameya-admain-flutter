import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jameya/core/api/end_points.dart';
import 'package:jameya/core/api/status_code.dart';
import 'package:jameya/core/functions/logout.dart';
import 'package:jameya/core/services/secure_storage_service.dart';

class AppInterceptors extends Interceptor {
  late final Dio dio;

  bool _isRefreshing = false;
  final List<_PendingRequest> _queue = [];

  // Temporary fallback admin token provided for testing prior to login screen implementation
  static const String tempAdminToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjOGY5MzJhZS03NTg5LTQxYjItYjljZi1kOGU2ZmU3YzFiMTgiLCJlbWFpbCI6ImFkbWluQGphbWV5YS5sb2NhbCIsInJvbGUiOiJTVVBFUl9BRE1JTiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc4NTY3MTAzNiwiZXhwIjoxNzg1NjcxOTM2fQ.2NJBJICzbBJ2scj8fPi3SIYOPsQYSEzaWUpv7eRM7HQ';

  AppInterceptors() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await SecureStorageService.getAccessToken();

    // Use stored token if available, otherwise fallback to temporary admin token
    token ??= tempAdminToken;

    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Accept'] = '*/*';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != StatusCode.unauthorized) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;

    if (_isRefreshing) {
      final completer = Completer<Response>();
      _queue.add(_PendingRequest(requestOptions, completer));

      try {
        final response = await completer.future;
        return handler.resolve(response);
      } catch (_) {
        return handler.reject(err);
      }
    }

    _isRefreshing = true;

    try {
      final refreshToken = await SecureStorageService.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        await logout();
        return handler.reject(err);
      }

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final refreshResponse = await refreshDio.post(
        EndPoints.adminRefresh,
        data: {"refreshToken": refreshToken},
      );

      final newAccess = refreshResponse.data['accessToken'];
      final newRefresh = refreshResponse.data['refreshToken'];

      if (newAccess != null && newRefresh != null) {
        await SecureStorageService.saveTokens(
          accessToken: newAccess,
          refreshToken: newRefresh,
        );
      }

      if (!kReleaseMode) {
        debugPrint("Token Refreshed Successfully");
      }

      // Retry original request
      requestOptions.headers['Authorization'] = 'Bearer $newAccess';
      final response = await dio.fetch(requestOptions);

      // Retry queued requests
      for (final pending in _queue) {
        try {
          pending.request.headers['Authorization'] = 'Bearer $newAccess';
          final res = await dio.fetch(pending.request);
          pending.completer.complete(res);
        } catch (e) {
          pending.completer.completeError(e);
        }
      }

      _queue.clear();
      return handler.resolve(response);
    } catch (e) {
      for (final pending in _queue) {
        pending.completer.completeError(e);
      }
      _queue.clear();

      await logout();
      return handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }
}

class _PendingRequest {
  final RequestOptions request;
  final Completer<Response> completer;

  _PendingRequest(this.request, this.completer);
}
