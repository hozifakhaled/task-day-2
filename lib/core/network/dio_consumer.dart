import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/core/network/dio_failure_mapper.dart';

import 'api_consumer.dart';
import 'endpoints.dart';
import 'status_codes.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    if (kDebugMode && dio.httpClientAdapter is IOHttpClientAdapter) {
      // ignore: deprecated_member_use
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    dio.options
      ..baseUrl = Endpoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..validateStatus = (status) =>
          status != null &&
          status >= StatusCodes.ok &&
          status < 300;
  }

  Object? _prepareData(Object? data, bool isFormData) {
    if (!isFormData) return data;
    if (data is FormData) return data;
    if (data is Map<String, dynamic>) return FormData.fromMap(data);
    return data;
  }

  Future<Either<Failure, Response>> _run(
    Future<Response> Function() request,
  ) async {
    try {
      return Right(await request());
    } on DioException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    return _run(() => dio.get(path, queryParameters: queryParameters));
  }

  @override
  Future<Either<Failure, Response>> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) {
    return _run(
      () => dio.post(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  @override
  Future<Either<Failure, Response>> put({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) {
    return _run(
      () => dio.put(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Either<Failure, Response>> delete({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) {
    return _run(
      () => dio.delete(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
      ),
    );
  }
  @override
  Future<Either<Failure, Response>> patch({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) {
    return _run(
      () => dio.patch(
        path,
        data: _prepareData(data, isFormData),
        queryParameters: queryParameters,
      ),
    );
  }
}
