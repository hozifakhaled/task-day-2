import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('${options.method} ${options.baseUrl}${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'Status: ${response.statusCode}\n'
      'Data: ${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      'Error: ${err.response?.statusCode}\n'
      '${err.message}',
    );
    handler.next(err);
  }
}