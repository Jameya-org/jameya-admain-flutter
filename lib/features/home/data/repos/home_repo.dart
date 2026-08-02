import 'package:dio/dio.dart';
import 'package:jameya/core/services/api_service.dart';
import 'package:jameya/features/home/data/models/dashboard_model.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo(this._apiService);

  Future<DashboardModel> getDashboardData() async {
    try {
      final response = await _apiService.get(endPoint: '/admin/dashboard');
      return DashboardModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Failed to fetch dashboard data');
      }
      throw Exception('An unexpected error occurred');
    }
  }
}
