import 'package:dio/dio.dart';
import 'package:jameya_admin/core/api/api_services.dart';
import 'package:jameya_admin/core/api/end_points.dart';
import 'package:jameya_admin/core/errors/failures.dart';
import 'package:jameya_admin/features/society_management/data/models/society_model.dart';
import 'package:jameya_admin/features/society_management/data/models/society_payment_model.dart';

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

  Future<Map<String, dynamic>> getCircleDetails(String circleId) async {
    try {
      final response = await _apiServices.get(endPoint: '${EndPoints.adminCircles}/$circleId');
      if (response.data is Map<String, dynamic>) {
        return response.data['data'] is Map<String, dynamic>
            ? response.data['data']
            : response.data;
      }
      return {};
    } catch (_) {
      return {};
    }
  }

  Future<List<SocietyPaymentModel>> getInstallments() async {
    try {
      final response = await _apiServices.get(endPoint: EndPoints.adminInstallments);
      final rawData = response.data;
      List rawList = [];
      if (rawData is List) {
        rawList = rawData;
      } else if (rawData is Map<String, dynamic> && rawData['data'] is List) {
        rawList = rawData['data'];
      }
      return rawList.map((e) => SocietyPaymentModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> cancelCircle(String circleId, {required String reason}) async {
    await _apiServices.patch(
      endPoint: '${EndPoints.adminCircles}/$circleId/cancel',
      data: {'reason': reason},
    );
  }

  Future<void> updateCircleStatus(String circleId, {required String status, String? reason}) async {
    final Map<String, dynamic> body = {'status': status};
    if (reason != null && reason.isNotEmpty) {
      body['reason'] = reason;
    }
    await _apiServices.patch(
      endPoint: '${EndPoints.adminCircles}/$circleId',
      data: body,
    );
  }

  Future<void> activateCircle(String circleId) async {
    await _apiServices.patch(
      endPoint: '${EndPoints.adminCircles}/$circleId/activate',
    );
  }
}

