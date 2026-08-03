import 'package:dio/dio.dart';

abstract class ApiServices {
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  });

  Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  });

  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  });

  Future<Response> patch({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
  });

  void setBaseUrl({required String baseUrl});
  void setHeaders({required Map<String, dynamic> headers});
}
