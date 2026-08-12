import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:jameya_admin/core/api/end_points.dart';
import 'package:jameya_admin/core/api/status_code.dart';
import 'package:jameya_admin/core/functions/logout.dart';
import 'package:jameya_admin/core/services/secure_storage_service.dart';

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

  // ============================================================
  // REQUEST
  // ============================================================

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final String? accessToken =
    await SecureStorageService.getAccessToken();

    if (accessToken != null &&
        accessToken.trim().isNotEmpty) {
      options.headers['Authorization'] =
      'Bearer $accessToken';
    }

    options.headers['Accept'] = '*/*';

    handler.next(options);
  }

  // ============================================================
  // ERROR
  // ============================================================

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final statusCode = err.response?.statusCode;

    // مش 401 → سيب الـ error يعدي عادي
    if (statusCode != StatusCode.unauthorized) {
      return handler.next(err);
    }

    // ممنوع نعمل Refresh لو الـ request نفسه هو Refresh
    if (err.requestOptions.path.contains(
      EndPoints.adminRefresh,
    )) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;

    // ============================================================
    // لو فيه Refresh شغال بالفعل
    // ============================================================

    if (_isRefreshing) {
      final completer = Completer<Response>();

      _queue.add(
        _PendingRequest(
          requestOptions,
          completer,
        ),
      );

      try {
        final response = await completer.future;

        return handler.resolve(response);
      } catch (e) {
        return handler.reject(
          e is DioException ? e : err,
        );
      }
    }

    // ============================================================
    // بدأ Refresh
    // ============================================================

    _isRefreshing = true;

    try {
      final String? refreshToken =
      await SecureStorageService.getRefreshToken();

      // مفيش Refresh Token
      if (refreshToken == null ||
          refreshToken.trim().isEmpty) {
        await _handleRefreshFailure();

        return handler.reject(err);
      }

      // ==========================================================
      // Refresh Request
      // ==========================================================

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final refreshResponse = await refreshDio.post(
        EndPoints.adminRefresh,
        data: {
          'refreshToken': refreshToken,
        },
      );

      // ==========================================================
      // Read Response
      // ==========================================================

      final responseData = refreshResponse.data;

      final Map<String, dynamic> data =
      responseData is Map<String, dynamic>
          ? responseData
          : {};

      final Map<String, dynamic> body =
      data['data'] is Map<String, dynamic>
          ? data['data'] as Map<String, dynamic>
          : data;

      final String? newAccessToken =
      body['accessToken']?.toString();

      final String? newRefreshToken =
      body['refreshToken']?.toString();

      // ==========================================================
      // Validate New Token
      // ==========================================================

      if (newAccessToken == null ||
          newAccessToken.trim().isEmpty) {
        throw Exception(
          'Refresh response does not contain accessToken',
        );
      }

      // ==========================================================
      // Save New Tokens
      // ==========================================================

      await SecureStorageService.saveTokens(
        accessToken: newAccessToken,
        refreshToken:
        newRefreshToken != null &&
            newRefreshToken.trim().isNotEmpty
            ? newRefreshToken
            : refreshToken,
      );

      if (!kReleaseMode) {
        debugPrint(
          '================ TOKEN REFRESHED ================',
        );
        debugPrint('Access token refreshed successfully');
        debugPrint(
          '==================================================',
        );
      }

      // ==========================================================
      // Retry Original Request
      // ==========================================================

      requestOptions.headers['Authorization'] =
      'Bearer $newAccessToken';

      final response = await dio.fetch(
        requestOptions,
      );

      // ==========================================================
      // Retry Queued Requests
      // ==========================================================

      for (final pending in _queue) {
        try {
          pending.request.headers['Authorization'] =
          'Bearer $newAccessToken';

          final queuedResponse =
          await dio.fetch(pending.request);

          pending.completer.complete(
            queuedResponse,
          );
        } catch (e) {
          pending.completer.completeError(e);
        }
      }

      _queue.clear();

      return handler.resolve(response);
    } catch (e) {
      if (!kReleaseMode) {
        debugPrint(
          '================ REFRESH FAILED ================',
        );
        debugPrint('Refresh error: $e');
        debugPrint(
          '=================================================',
        );
      }

      // أي requests مستنية الـ Refresh
      for (final pending in _queue) {
        pending.completer.completeError(e);
      }

      _queue.clear();

      await _handleRefreshFailure();

      return handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }

  // ============================================================
  // REFRESH FAILURE
  // ============================================================

  Future<void> _handleRefreshFailure() async {
    await SecureStorageService.deleteTokens();

    await logout();
  }
}

// ================================================================
// PENDING REQUEST
// ================================================================

class _PendingRequest {
  final RequestOptions request;
  final Completer<Response> completer;

  _PendingRequest(
      this.request,
      this.completer,
      );
}