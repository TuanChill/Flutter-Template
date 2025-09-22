import 'package:equatable/equatable.dart';

enum ErrorType {
  network,
  server,
  notFound,
  unauthorized,
  validation,
  unknown,
}

class AppError extends Equatable {
  const AppError({
    required this.type,
    required this.title,
    required this.message,
    this.code,
  });

  final ErrorType type;
  final String title;
  final String message;
  final String? code;

  factory AppError.network([String? message]) {
    return AppError(
      type: ErrorType.network,
      title: 'Connection Error',
      message: message ?? 'Please check your internet connection and try again.',
    );
  }

  factory AppError.server([String? message]) {
    return AppError(
      type: ErrorType.server,
      title: 'Server Error',
      message: message ?? 'Something went wrong on our end. Please try again later.',
    );
  }

  factory AppError.notFound([String? message]) {
    return AppError(
      type: ErrorType.notFound,
      title: 'Not Found',
      message: message ?? 'The requested resource was not found.',
    );
  }

  factory AppError.unauthorized([String? message]) {
    return AppError(
      type: ErrorType.unauthorized,
      title: 'Access Denied',
      message: message ?? 'You are not authorized to access this resource.',
    );
  }

  factory AppError.validation([String? message]) {
    return AppError(
      type: ErrorType.validation,
      title: 'Validation Error',
      message: message ?? 'Please check your input and try again.',
    );
  }

  factory AppError.unknown([String? message]) {
    return AppError(
      type: ErrorType.unknown,
      title: 'Unknown Error',
      message: message ?? 'An unexpected error occurred.',
    );
  }

  @override
  List<Object?> get props => [type, title, message, code];
}
