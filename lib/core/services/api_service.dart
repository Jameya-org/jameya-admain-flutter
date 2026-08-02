import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://jameya-backend.onrender.com',
          receiveDataWhenStatusError: true,
        ),
      ) {
    // Adding interceptor to include the temporary token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Temporarily hardcoded token as requested by the user until login is fully implemented
          const token =
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjOGY5MzJhZS03NTg5LTQxYjItYjljZi1kOGU2ZmU3YzFiMTgiLCJlbWFpbCI6ImFkbWluQGphbWV5YS5sb2NhbCIsInJvbGUiOiJTVVBFUl9BRE1JTiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc4NTY3MTAzNiwiZXhwIjoxNzg1NjcxOTM2fQ.2NJBJICzbBJ2scj8fPi3SIYOPsQYSEzaWUpv7eRM7HQ';
          options.headers['Authorization'] = 'Bearer $token';
          options.headers['accept'] = '*/*';
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(endPoint, queryParameters: queryParameters);
  }

  Future<Response> post({required String endPoint, dynamic data}) async {
    return await _dio.post(endPoint, data: data);
  }
}
