import 'package:dio/dio.dart';

import '../error/failure.dart';
import 'models/api_error_model.dart';

/// Turns any [DioException] from the app Dio client into a [Failure].
extension DioExceptionFailure on DioException {
  Failure get failure {
    final api = ApiErrorModel.tryParse(
      response?.data,
      statusCode: response?.statusCode,
    );
    if (api != null && api.message.trim().isNotEmpty) {
      return ServerFailure.fromApiError(api);
    }

    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkFailure(message ?? 'Connection problem');
      case DioExceptionType.cancel:
        return UnknownFailure(message ?? 'Request cancelled');
      case DioExceptionType.badCertificate:
        return const UnknownFailure('Invalid certificate');
      case DioExceptionType.badResponse:
        final code = response?.statusCode;
        final fallback =
            response?.data?.toString() ?? message ?? 'Bad response';
        return ServerFailure(fallback, statusCode: code);
      case DioExceptionType.unknown:
        return UnknownFailure(
          message ?? error?.toString() ?? 'Unknown error',
        );
    case DioExceptionType.transformTimeout:
  return NetworkFailure(
    message ?? 'Response transformation timed out',
  );
    }
  }
}

/// Same as [DioException.failure]; useful for callbacks or tests.
Failure mapDioException(DioException e) => e.failure;
