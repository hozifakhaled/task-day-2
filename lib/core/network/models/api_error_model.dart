/// Standard API error body, e.g.
/// `{ "success": false, "message": "Invalid parameter \`To\`: +203658804" }`
class ApiErrorModel {
  const ApiErrorModel({
    this.success = false,
    required this.message,
    this.statusCode,
    this.raw,
  });

  final bool success;
  final String message;

  /// HTTP status when this error came from a [DioException] response.
  final int? statusCode;

  /// Original parsed map when available (extra fields from backend).
  final Map<String, dynamic>? raw;

  factory ApiErrorModel.fromJson(
    Map<String, dynamic> json, {
    int? statusCode,
  }) {
    final msg = json['message']?.toString() ??
        json['error']?.toString() ??
        json['msg']?.toString() ??
        '';

    return ApiErrorModel(
      success: json['success'] as bool? ?? false,
      message: msg,
      statusCode: statusCode,
      raw: json,
    );
  }

  /// Parses response body from Dio (`response.data`). Returns null if not a JSON object.
  static ApiErrorModel? tryParse(dynamic data, {int? statusCode}) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      return ApiErrorModel.fromJson(data, statusCode: statusCode);
    }

    if (data is Map) {
      return ApiErrorModel.fromJson(
        data.map((k, v) => MapEntry(k.toString(), v)),
        statusCode: statusCode,
      );
    }

    return null;
  }

  /// Human-readable line for UI / logging (falls back if [message] empty).
  String displayMessage([String fallback = 'Something went wrong']) =>
      message.trim().isEmpty ? fallback : message;
}
