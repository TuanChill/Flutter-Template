import 'package:flutter_template/core/network/models/api_response.dart';
import '../models/auth_response.dart';

class AuthService {
  AuthService();

  /// Login with email and password
  Future<ApiResponse<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, password: password);

    try {
      // For demo purposes, simulate API call with mock data
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful login
      if (email == 'test@example.com' && password == 'password123') {
        final mockResponse = {
          'success': true,
          'data': {
            'user': {
              'id': '1',
              'email': email,
              'firstName': 'John',
              'lastName': 'Doe',
              'role': 'patient',
              'isEmailVerified': true,
              'isPhoneVerified': false,
            },
            'accessToken': 'mock_access_token_123',
            'refreshToken': 'mock_refresh_token_456',
            'expiresIn': 3600,
          },
          'message': 'Login successful',
        };

        return ApiResponse.fromJson(
          mockResponse,
          (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
        );
      } else {
        // Mock error response
        return ApiResponse.error(
          message: 'Invalid email or password',
          statusCode: 401,
        );
      }

      // Real API call would be:
      // return await _httpService.post<AuthResponse>(
      //   '/auth/login',
      //   data: request.toJson(),
      //   fromJson: (data) => AuthResponse.fromJson(data),
      // );
    } catch (e) {
      return ApiResponse.error(
        message: 'Login failed: ${e.toString()}',
      );
    }
  }

  /// Register new user
  Future<ApiResponse<AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    final request = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );

    try {
      // For demo purposes, simulate API call with mock data
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful registration
      final mockResponse = {
        'success': true,
        'data': {
          'user': {
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'role': 'patient',
            'phoneNumber': phoneNumber,
            'dateOfBirth': dateOfBirth?.toIso8601String(),
            'isEmailVerified': false,
            'isPhoneVerified': false,
          },
          'accessToken': 'mock_access_token_new_user',
          'refreshToken': 'mock_refresh_token_new_user',
          'expiresIn': 3600,
        },
        'message': 'Registration successful',
      };

      return ApiResponse.fromJson(
        mockResponse,
        (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );

      // Real API call would be:
      // return await _httpService.post<AuthResponse>(
      //   '/auth/register',
      //   data: request.toJson(),
      //   fromJson: (data) => AuthResponse.fromJson(data),
      // );
    } catch (e) {
      return ApiResponse.error(
        message: 'Registration failed: ${e.toString()}',
      );
    }
  }

  /// Logout user
  Future<ApiResponse<void>> logout() async {
    try {
      // For demo purposes, simulate API call
      await Future.delayed(const Duration(seconds: 1));

      return ApiResponse.success(
        data: null,
        message: 'Logout successful',
      );

      // Real API call would be:
      // return await _httpService.post<void>('/auth/logout');
    } catch (e) {
      return ApiResponse.error(
        message: 'Logout failed: ${e.toString()}',
      );
    }
  }

  /// Refresh access token
  Future<ApiResponse<AuthResponse>> refreshToken(String refreshToken) async {
    try {
      // For demo purposes, simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock refresh token response
      final mockResponse = {
        'success': true,
        'data': {
          'user': {
            'id': '1',
            'email': 'test@example.com',
            'firstName': 'John',
            'lastName': 'Doe',
            'role': 'patient',
            'isEmailVerified': true,
            'isPhoneVerified': false,
          },
          'accessToken': 'new_mock_access_token_123',
          'refreshToken': 'new_mock_refresh_token_456',
          'expiresIn': 3600,
        },
        'message': 'Token refreshed successfully',
      };

      return ApiResponse.fromJson(
        mockResponse,
        (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );

      // Real API call would be:
      // return await _httpService.post<AuthResponse>(
      //   '/auth/refresh',
      //   data: {'refreshToken': refreshToken},
      //   fromJson: (data) => AuthResponse.fromJson(data),
      // );
    } catch (e) {
      return ApiResponse.error(
        message: 'Token refresh failed: ${e.toString()}',
      );
    }
  }
}
