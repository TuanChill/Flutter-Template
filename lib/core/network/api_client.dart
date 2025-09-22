import 'package:dio/dio.dart';
import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/error/exceptions.dart';
import 'package:flutter_template/core/network/models/error_response.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${AppConstants.baseUrl}/${AppConstants.apiVersion}',
        connectTimeout: AppConstants.connectionTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if available
          // final token = getIt<AuthService>().getAccessToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          handler.next(options);
        },
        onError: (error, handler) {
          final exception = _handleError(error);
          handler.reject(DioException(
            requestOptions: error.requestOptions,
            error: exception,
          ));
        },
      ),
    );
  }

  Dio get dio => _dio;

  Exception _handleError(DioException error) {
    // Parse error response using ErrorResponse model
    ErrorResponse? errorResponse;

    if (error.response?.data != null) {
      try {
        errorResponse = ErrorResponse.fromDynamic(error.response!.data);
      } catch (e) {
        // If parsing fails, create a generic error response
        errorResponse = ErrorResponse(
          message: 'Failed to parse error response',
          statusCode: error.response?.statusCode,
        );
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException('Connection timeout');

      case DioExceptionType.badResponse:
        final message = errorResponse?.message ?? 'Server error occurred';
        switch (error.response?.statusCode) {
          case 400:
            return ValidationException(message);
          case 401:
            return AuthenticationException(message);
          case 403:
            return AuthorizationException(message);
          case 404:
            return NotFoundException(message);
          case 409:
            return ConflictException(message);
          case 500:
            return ServerException(message);
          default:
            return ServerException(message);
        }

      case DioExceptionType.cancel:
        return const NetworkException('Request cancelled');

      case DioExceptionType.connectionError:
        return const NetworkException('No internet connection');

      case DioExceptionType.unknown:
        return NetworkException(
          errorResponse?.message ?? 'Unknown network error',
        );

      default:
        return NetworkException(
          errorResponse?.message ?? 'Unknown network error',
        );
    }
  }
}
