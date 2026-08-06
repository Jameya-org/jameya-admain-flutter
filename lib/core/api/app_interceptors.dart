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
    final String? token = await SecureStorageService.getAccessToken();

    if (token != null && token.trim().isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = '*/*';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != StatusCode.unauthorized ||
        err.requestOptions.path.contains(EndPoints.adminRefresh)) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;

    if (_isRefreshing) {
      final completer = Completer<Response>();
      _queue.add(_PendingRequest(requestOptions, completer));

      try {
        final response = await completer.future;
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(e is DioException ? e : err);
      }
    }

    _isRefreshing = true;

    try {
      final String? refreshToken = await SecureStorageService.getRefreshToken();

      if (refreshToken == null || refreshToken.trim().isEmpty) {
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

      final data = refreshResponse.data is Map ? refreshResponse.data : {};
      final responseBody = data['data'] ?? data;
      final newAccess = responseBody['accessToken']?.toString();
      final newRefresh = responseBody['refreshToken']?.toString();

      if (newAccess != null && newAccess.isNotEmpty) {
        await SecureStorageService.saveTokens(
          accessToken: newAccess,
          refreshToken: (newRefresh != null && newRefresh.isNotEmpty)
              ? newRefresh
              : refreshToken,
        );

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
      } else {
        throw Exception("Invalid refresh response format");
      }
    } catch (e) {
      for (final pending in _queue) {
        pending.completer.completeError(e);
      }
      _queue.clear();

      if (!kReleaseMode) {
        debugPrint("Token Refresh Failed: $e");
      }

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
