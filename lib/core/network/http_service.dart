import 'package:dio/dio.dart';
import 'package:flutter_template/core/network/api_client.dart';
import 'package:flutter_template/core/network/models/api_response.dart';
import 'package:flutter_template/core/network/models/error_response.dart';

class HttpService {
  final ApiClient _apiClient;

  HttpService(this._apiClient);

  Dio get dio => _apiClient.dio;

  /// Generic GET request
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Generic POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Generic DELETE request
  Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Handle successful response
  ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    try {
      // Check if response data is already in ApiResponse format
      if (response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData.containsKey('success')) {
          return ApiResponse.fromJson(responseData, fromJson);
        }
      }

      // If not, wrap the data in a success response
      return ApiResponse.success(
        data: fromJson != null ? fromJson(response.data) : response.data as T,
        statusCode: response.statusCode,
        message: 'Request successful',
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to parse response: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  /// Handle error response
  ApiResponse<T> _handleError<T>(DioException error) {
    ErrorResponse? errorResponse;

    if (error.response?.data != null) {
      try {
        errorResponse = ErrorResponse.fromDynamic(error.response!.data);
      } catch (e) {
        errorResponse = ErrorResponse(
          message: 'Failed to parse error response',
          statusCode: error.response?.statusCode,
        );
      }
    }

    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout';
      case DioExceptionType.badResponse:
        message = errorResponse?.message ?? 'Server error occurred';
      case DioExceptionType.cancel:
        message = 'Request cancelled';
      case DioExceptionType.connectionError:
        message = 'No internet connection';
      case DioExceptionType.unknown:
        message = errorResponse?.message ?? 'Unknown network error';
      case DioExceptionType.badCertificate:
        message = 'Certificate error';
    }

    return ApiResponse.error(
      message: message,
      statusCode: error.response?.statusCode,
    );
  }
}
