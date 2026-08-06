import 'package:dio/dio.dart';
import 'package:jameya_admin/core/api/api_services.dart';
import 'package:jameya_admin/core/api/end_points.dart';
import 'package:jameya_admin/core/errors/failures.dart';
import 'package:jameya_admin/features/society_management/data/models/society_model.dart';

class SocietyRepo {
  final ApiServices _apiServices;

  SocietyRepo(this._apiServices);

  Future<List<SocietyModel>> getCircles() async {
    try {
      final response = await _apiServices.get(endPoint: EndPoints.adminCircles);

      final List<dynamic> data = response.data is List
          ? response.data
          : (response.data['data'] ?? []);

      return data.map((e) => SocietyModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }
}
