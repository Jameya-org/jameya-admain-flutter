import 'package:dio/dio.dart';
import 'package:jameya_admin/core/services/api_config.dart';
import 'package:jameya_admin/features/create_jameya/data/datasource/create_jameya_exception.dart';
import 'package:jameya_admin/features/create_jameya/data/datasource/create_jameya_remote_data_source.dart';
import 'package:jameya_admin/features/create_jameya/data/models/create_jameya_request_model.dart';
import 'package:jameya_admin/features/create_jameya/data/models/create_jameya_response_model.dart';

/// Real HTTP implementation of [CreateJameyaRemoteDataSource].
/// Calls `POST /admin/circles` with a Bearer token from SecureStorage
/// (injected automatically by [DioFactory]'s auth interceptor).
class CreateJameyaRemoteDataSourceImpl implements CreateJameyaRemoteDataSource {
  final Dio _dio;

  const CreateJameyaRemoteDataSourceImpl(this._dio);

  @override
  Future<CreateJameyaResponseModel> createJameya(
    CreateJameyaRequestModel request,
  ) async {
    try {
      final response = await _dio.post(
        ApiConfig.createCircle,
        data: request.toJson(),
      );

      // 201 Created — parse the circle draft
      return CreateJameyaResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      // Convert Dio errors into readable messages for the Cubit to handle
      throw _mapDioError(e);
    }
  }

  /// Maps a [DioException] to a descriptive Arabic error message.
  CreateJameyaException _mapDioError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return CreateJameyaException(
          'بيانات غير صحيحة: تأكد من تطابق القسط وعدد الأعضاء مع المبلغ الإجمالي.',
        );
      case 401:
        return CreateJameyaException('غير مصرح. يرجى تسجيل الدخول مرة أخرى.');
      case 422:
        return CreateJameyaException(
          'لا توجد سياسة رسوم نشطة لهذه المدة. يرجى التواصل مع الإدارة.',
        );
      default:
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          return CreateJameyaException(
            'انتهت مهلة الاتصال. تحقق من اتصالك بالإنترنت.',
          );
        }
        return CreateJameyaException(
          e.response?.data?['message'] as String? ??
              'حدث خطأ غير متوقع. حاول مرة أخرى.',
        );
    }
  }
}
