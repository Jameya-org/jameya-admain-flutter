import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jameya/core/api/api_services.dart';
import 'package:jameya/core/api/app_interceptors.dart';
import 'package:jameya/core/api/end_points.dart';

class ApiServicesImplementation extends ApiServices {
  late final Dio _dio;
  final AppInterceptors appInterceptors;

  ApiServicesImplementation(this.appInterceptors) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(appInterceptors);
    if (!kReleaseMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  @override
  void setBaseUrl({required String baseUrl}) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void setHeaders({required Map<String, dynamic> headers}) {
    _dio.options.headers = headers;
  }

  @override
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(
      endPoint,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(
      endPoint,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await _dio.put(
      endPoint,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> patch({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await _dio.patch(
      endPoint,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await _dio.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    );
  }
}
