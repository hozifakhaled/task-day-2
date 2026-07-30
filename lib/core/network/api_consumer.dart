import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task2/core/error/failure.dart';



abstract class ApiConsumer {
  Future<Either<Failure, Response>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Response>> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  });

  Future<Either<Failure, Response>> put({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  Future<Either<Failure, Response>> delete({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
   Future<Either<Failure, Response>> patch({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
