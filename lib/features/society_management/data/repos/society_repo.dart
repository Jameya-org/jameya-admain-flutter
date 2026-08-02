import 'package:dio/dio.dart';
import 'package:jameya/core/services/api_service.dart';
import 'package:jameya/features/society_management/data/models/society_model.dart';

class SocietyRepo {
  final ApiService _apiService;

  SocietyRepo(this._apiService);

  Future<List<SocietyModel>> getCircles() async {
    try {
      final response = await _apiService.get(endPoint: '/admin/circles');
      
      // We expect the response data to contain a list of circles
      final List<dynamic> data = response.data is List ? response.data : (response.data['data'] ?? []);
      
      return data.map((e) => SocietyModel.fromJson(e)).toList();
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Failed to fetch circles');
      }
      throw Exception('An unexpected error occurred while fetching circles');
    }
  }
}
