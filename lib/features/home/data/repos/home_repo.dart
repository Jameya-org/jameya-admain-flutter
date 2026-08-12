import 'package:dio/dio.dart';
import 'package:jameya_admin/core/api/api_services.dart';
import 'package:jameya_admin/core/api/end_points.dart';
import 'package:jameya_admin/core/errors/failures.dart';
import 'package:jameya_admin/features/home/data/models/dashboard_model.dart';

class HomeRepo {
  final ApiServices _apiServices;

  HomeRepo(this._apiServices);

  Future<DashboardModel> getDashboardData() async {
    try {
      final response = await _apiServices.get(
        endPoint: EndPoints.adminDashboard,
      );
      return DashboardModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }
}
