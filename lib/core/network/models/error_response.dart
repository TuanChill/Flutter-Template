import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  const ErrorResponse({
    required this.message,
    this.code,
    this.details,
    this.statusCode,
  });

  final String message;
  final String? code;
  final Map<String, dynamic>? details;
  final int? statusCode;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String? ?? 'Unknown error occurred',
      code: json['code'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      statusCode: json['statusCode'] as int?,
    );
  }

  factory ErrorResponse.fromDynamic(dynamic data) {
    if (data is Map<String, dynamic>) {
      return ErrorResponse.fromJson(data);
    } else if (data is String) {
      return ErrorResponse(message: data);
    } else {
      return const ErrorResponse(message: 'Unknown error occurred');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'details': details,
      'statusCode': statusCode,
    };
  }

  @override
  List<Object?> get props => [message, code, details, statusCode];

  @override
  String toString() => message;
}

// Common error response formats for different APIs
class ValidationErrorResponse extends ErrorResponse {
  const ValidationErrorResponse({
    required super.message,
    super.code,
    this.errors,
    super.statusCode = 400,
  });

  final Map<String, List<String>>? errors;

  factory ValidationErrorResponse.fromJson(Map<String, dynamic> json) {
    return ValidationErrorResponse(
      message: json['message'] as String? ?? 'Validation failed',
      code: json['code'] as String?,
      errors: _parseValidationErrors(json['errors']),
      statusCode: json['statusCode'] as int? ?? 400,
    );
  }

  static Map<String, List<String>>? _parseValidationErrors(dynamic errors) {
    if (errors is Map<String, dynamic>) {
      final result = <String, List<String>>{};
      errors.forEach((key, value) {
        if (value is List) {
          result[key] = value.map((e) => e.toString()).toList();
        } else {
          result[key] = [value.toString()];
        }
      });
      return result;
    }
    return null;
  }

  @override
  List<Object?> get props => [...super.props, errors];
}
