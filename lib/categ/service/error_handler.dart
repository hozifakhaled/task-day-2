import 'package:dio/dio.dart';
import 'failure.dart';

/// Simple handler that converts exceptions into a Failure
class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return ServerFailure(_handleDioError(error));
    } else {
      return ServerFailure('Something went wrong, please try again');
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout, please try again';

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return 'Request was cancelled';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      default:
        return 'Something went wrong, please try again';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized, please login again';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong, please try again';
    }
  }
}
