import 'package:equatable/equatable.dart';

import '../network/models/api_error_model.dart';

/// Base type for domain / presentation errors (use with [Either] from dartz).
abstract class Failure extends Equatable implements Exception {
  const Failure();

  /// Text suitable for SnackBar / dialog (short, user-facing).
  String get message;

  @override
  String toString() => message;
}

/// Backend returned an error body or non-success HTTP status.
class ServerFailure extends Failure {
  const ServerFailure(
    this._message, {
    this.statusCode,
    this.apiError,
  });

  final String _message;
  final int? statusCode;
  final ApiErrorModel? apiError;

  factory ServerFailure.fromApiError(ApiErrorModel model) {
    return ServerFailure(
      model.displayMessage(),
      statusCode: model.statusCode,
      apiError: model,
    );
  }

  @override
  String get message => _message;

  @override
  List<Object?> get props => [_message, statusCode, apiError];
}

/// No connection, timeout, or similar.
class NetworkFailure extends Failure {
  const NetworkFailure([this._message = 'Check your internet connection']);

  final String _message;

  @override
  String get message => _message;

  @override
  List<Object?> get props => [_message];
}

/// Anything that does not fit [ServerFailure] / [NetworkFailure].
class UnknownFailure extends Failure {
  const UnknownFailure(this._message);

  final String _message;

  @override
  String get message => _message;

  @override
  List<Object?> get props => [_message];
}
