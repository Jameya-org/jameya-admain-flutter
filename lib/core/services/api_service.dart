import 'package:dio/dio.dart';
import 'package:jameya/core/api/api_services.dart';
import 'package:jameya/core/services/services_locator.dart';

class ApiService {
  final ApiServices _apiServices;

  ApiService([ApiServices? apiServices])
      : _apiServices = apiServices ?? getIt<ApiServices>();

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiServices.get(
      endPoint: endPoint,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post({
    required String endPoint,
    dynamic data,
  }) async {
    return await _apiServices.post(
      endPoint: endPoint,
      data: data,
    );
  }
}
