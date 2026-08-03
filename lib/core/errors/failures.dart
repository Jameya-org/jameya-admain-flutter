import 'package:dio/dio.dart';

abstract class Failure {
  final String error;
  const Failure(this.error);
}

class ServerFailure extends Failure {
  ServerFailure(super.error);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('عفواً، انتهت مهلة الإتصال بالخادم');
      case DioExceptionType.sendTimeout:
        return ServerFailure('عفواً، انتهت مهلة ارسال البيانات إلى الخادم');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('عفواً، انتهت مهلة استقبال البيانات من الخادم');
      case DioExceptionType.badCertificate:
        return ServerFailure('شهادة الأمان غير صالحة');
      case DioExceptionType.badResponse:
        return ServerFailure.fromDioResponse(
          dioException.response?.statusCode ?? 500,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return ServerFailure('تعذر الاتصال بالشبكة، يرجى التحقق من اتصال الإنترنت');
      case DioExceptionType.unknown:
        return ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً');
      case DioExceptionType.transformTimeout:
        return ServerFailure('عفواً، انتهت مهلة معالجة البيانات');
    }
  }

  factory ServerFailure.fromDioResponse(int statusCode, dynamic response) {
    String extractMessage(dynamic data) {
      if (data == null) return 'حدث خطأ غير متوقع، يرجى المحاولة لاحقاً';
      if (data is Map) {
        if (data.containsKey('message')) {
          final msg = data['message'];
          if (msg is List) {
            return msg.join(', ');
          }
          return msg.toString();
        }
      }
      return data.toString();
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 402:
      case 403:
      case 404:
      case 409:
      case 413:
      case 422:
        return ServerFailure(extractMessage(response));
      case 500:
        return ServerFailure('حدث خطأ في الخادم الداخلي (500)');
      default:
        return ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً');
    }
  }
}
