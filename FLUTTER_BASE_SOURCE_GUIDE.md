# 📋 Tổng Hợp Base Source - Flutter App

## 🏗️ **Kiến Trúc Tổng Quan**

### **📁 Cấu Trúc Thư Mục**
```
lib/
├── app/                          # App configuration
│   ├── view/app.dart            # Main app widget
│   └── app_module.dart          # Root module với DI
├── bootstrap.dart               # App initialization
├── core/                        # Core utilities & shared code
│   ├── bloc/                    # Base BLoC classes
│   ├── constants/               # App constants
│   ├── error/                   # Exception handling
│   ├── network/                 # API & HTTP services
│   │   ├── models/             # API response models
│   │   ├── api_client.dart     # Dio HTTP client
│   │   └── http_service.dart   # Generic HTTP service
│   └── utils/                   # Utility functions
├── features/                    # Feature modules
│   └── authentication/         # Auth feature
│       ├── data/               # Data layer
│       ├── domain/             # Domain layer
│       ├── presentation/       # UI layer
│       └── auth_module.dart    # Feature module
├── l10n/                       # Localization
├── shared/                     # Shared widgets & models
└── main_*.dart                 # Entry points cho các môi trường
```

---

## 🎯 **Các Tính Năng Chính**

### **1. 🏛️ Modular Architecture với Flutter Modular**

**Ưu điểm:**
- ✅ **Dependency Injection** tự động
- ✅ **Route Management** có cấu trúc
- ✅ **Module Isolation** - tách biệt features
- ✅ **Lazy Loading** - load modules khi cần

**Cách sử dụng:**
```dart
// AppModule - Root module
class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthService>(AuthService.new);
    i.addSingleton<AuthCubit>(() => AuthCubit(i.get<AuthService>()));
  }

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.child('/home', child: (context) => const HomePage());
  }
}

// Sử dụng trong code
final authCubit = Modular.get<AuthCubit>();
Modular.to.navigate('/home');
```

### **2. 🔧 Error Response Model System**

**Tính năng:**
- ✅ **Structured Error Handling** - xử lý lỗi có cấu trúc
- ✅ **API Response Wrapper** - bọc tất cả API responses
- ✅ **Type-Safe Error Messages** - lỗi type-safe
- ✅ **Validation Error Support** - hỗ trợ validation errors

**Models chính:**
```dart
// ErrorResponse - Model cho error responses
class ErrorResponse {
  final String message;
  final String? code;
  final Map<String, dynamic>? details;
  final int? statusCode;
}

// ApiResponse - Wrapper cho tất cả API responses
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
}

// HttpService - Generic HTTP service
class HttpService {
  Future<ApiResponse<T>> get<T>(String path, {T Function(dynamic)? fromJson});
  Future<ApiResponse<T>> post<T>(String path, {dynamic data, T Function(dynamic)? fromJson});
}
```

### **3. 🔐 Authentication System**

**Tính năng:**
- ✅ **Login/Register Flow** - đăng nhập/đăng ký
- ✅ **BLoC State Management** - quản lý state với BLoC
- ✅ **Mock Authentication** - authentication giả lập
- ✅ **Error Handling** - xử lý lỗi đăng nhập
- ✅ **Route Protection** - bảo vệ routes

**Components:**
```dart
// AuthCubit - Quản lý authentication state
class AuthCubit extends Cubit<AuthState> {
  Future<void> login({required String email, required String password});
  Future<void> register({...});
  Future<void> logout();
}

// AuthService - Service xử lý API calls
class AuthService {
  Future<ApiResponse<AuthResponse>> login({required String email, required String password});
  Future<ApiResponse<AuthResponse>> register({...});
}

// User Entity - Domain model
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final UserRole role;
}
```

### **4. 🎨 UI Components**

**Tính năng:**
- ✅ **Simple Login Page** - trang đăng nhập đơn giản
- ✅ **Loading States** - trạng thái loading
- ✅ **Error Messages** - hiển thị lỗi
- ✅ **Material Design** - tuân thủ Material Design

**Test Credentials:**
```
Email: test@example.com
Password: password123
```

---

## 🛠️ **Setup & Configuration**

### **1. 📱 Multi-Platform Support**

**Platforms hỗ trợ:**
- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Web** (Chrome, Safari, Firefox)

**Build Flavors:**
```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

### **2. 📦 Dependencies**

**Core Dependencies:**
```yaml
dependencies:
  flutter_modular: ^6.3.2      # Modular architecture
  flutter_bloc: ^8.1.6         # State management
  dio: ^5.8.0+1                # HTTP client
  equatable: ^2.0.7            # Value equality
  dartz: ^0.10.1               # Functional programming

dev_dependencies:
  bloc_test: ^9.1.7            # BLoC testing
  mocktail: ^1.0.4             # Mocking
  very_good_analysis: ^6.0.0   # Linting rules
```

### **3. 🔧 Android Configuration**

**Đã được cấu hình:**
- ✅ **Java 1.8 Compatibility**
- ✅ **Kotlin 1.9.20**
- ✅ **Gradle 8.3**
- ✅ **Internet Permission**
- ✅ **Multi-flavor Support**

---

## 💻 **Code Guidelines & Examples**

### **1. 🏗️ Module Structure Pattern**

**Cấu trúc chuẩn cho một feature module:**

```dart
// lib/features/profile/profile_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'data/services/profile_service.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'presentation/cubit/profile_cubit.dart';
import 'presentation/pages/profile_page.dart';

class ProfileModule extends Module {
  @override
  void binds(Injector i) {
    // Services
    i.addSingleton<ProfileService>(ProfileService.new);

    // Repositories
    i.addSingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(i.get<ProfileService>()),
    );

    // Use cases
    i.addSingleton<GetProfileUsecase>(
      () => GetProfileUsecase(i.get<ProfileRepository>()),
    );

    // Cubits
    i.addSingleton<ProfileCubit>(
      () => ProfileCubit(i.get<GetProfileUsecase>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/profile', child: (context) => const ProfilePage());
    r.child('/profile/edit', child: (context) => const EditProfilePage());
  }
}
```

### **2. 🔧 Error Response Implementation**

**Complete Error Response System:**

```dart
// lib/core/network/models/error_response.dart
import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  const ErrorResponse({
    required this.message,
    this.code,
    this.details,
    this.statusCode,
    this.timestamp,
  });

  final String message;
  final String? code;
  final Map<String, dynamic>? details;
  final int? statusCode;
  final DateTime? timestamp;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String? ?? 'Unknown error occurred',
      code: json['code'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      statusCode: json['statusCode'] as int?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  factory ErrorResponse.fromDynamic(dynamic data) {
    if (data is Map<String, dynamic>) {
      return ErrorResponse.fromJson(data);
    } else if (data is String) {
      return ErrorResponse(
        message: data,
        timestamp: DateTime.now(),
      );
    } else {
      return ErrorResponse(
        message: 'Unknown error occurred',
        timestamp: DateTime.now(),
      );
    }
  }

  // Network specific errors
  factory ErrorResponse.networkTimeout() {
    return ErrorResponse(
      message: 'Connection timeout. Please check your internet connection.',
      code: 'NETWORK_TIMEOUT',
      statusCode: 408,
      timestamp: DateTime.now(),
    );
  }

  factory ErrorResponse.noInternet() {
    return ErrorResponse(
      message: 'No internet connection. Please check your network settings.',
      code: 'NO_INTERNET',
      statusCode: 0,
      timestamp: DateTime.now(),
    );
  }

  factory ErrorResponse.serverError([String? customMessage]) {
    return ErrorResponse(
      message: customMessage ?? 'Server error occurred. Please try again later.',
      code: 'SERVER_ERROR',
      statusCode: 500,
      timestamp: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [message, code, details, statusCode, timestamp];

  @override
  String toString() => message;
}
```

### **3. 🌐 HTTP Service with Complete Error Handling**

```dart
// lib/core/network/http_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_template/core/network/api_client.dart';
import 'package:flutter_template/core/network/models/api_response.dart';
import 'package:flutter_template/core/network/models/error_response.dart';

class HttpService {
  final ApiClient _apiClient;

  HttpService(this._apiClient);

  Dio get dio => _apiClient.dio;

  /// Generic GET request with comprehensive error handling
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
    Duration? timeout,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          sendTimeout: timeout ?? const Duration(seconds: 30),
          receiveTimeout: timeout ?? const Duration(seconds: 30),
        ),
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Generic POST request with file upload support
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
    Duration? timeout,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        options: Options(
          headers: headers,
          sendTimeout: timeout ?? const Duration(seconds: 60),
          receiveTimeout: timeout ?? const Duration(seconds: 60),
        ),
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Handle successful response with multiple formats
  ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    try {
      // Check if response data is already in ApiResponse format
      if (response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;

        // Standard API response format
        if (responseData.containsKey('success')) {
          return ApiResponse.fromJson(responseData, fromJson);
        }

        // Laravel/PHP format
        if (responseData.containsKey('data') && responseData.containsKey('message')) {
          return ApiResponse.success(
            data: fromJson != null ? fromJson(responseData['data']) : responseData['data'] as T,
            message: responseData['message'] as String?,
            statusCode: response.statusCode,
          );
        }
      }

      // Raw data response
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

  /// Comprehensive Dio error handling
  ApiResponse<T> _handleDioError<T>(DioException error) {
    ErrorResponse? errorResponse;

    // Try to parse error response
    if (error.response?.data != null) {
      try {
        errorResponse = ErrorResponse.fromDynamic(error.response!.data);
      } catch (e) {
        errorResponse = ErrorResponse(
          message: 'Failed to parse error response',
          statusCode: error.response?.statusCode,
          timestamp: DateTime.now(),
        );
      }
    }

    // Handle different error types
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiResponse.error(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        final message = errorResponse?.message ?? _getStatusCodeMessage(error.response?.statusCode);
        return ApiResponse.error(
          message: message,
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return ApiResponse.error(
          message: 'Request was cancelled',
          statusCode: 0,
        );

      case DioExceptionType.connectionError:
        return ApiResponse.error(
          message: 'No internet connection. Please check your network settings.',
          statusCode: 0,
        );

      case DioExceptionType.badCertificate:
        return ApiResponse.error(
          message: 'Certificate verification failed',
          statusCode: 0,
        );

      case DioExceptionType.unknown:
        return ApiResponse.error(
          message: errorResponse?.message ?? 'Unknown network error occurred',
          statusCode: error.response?.statusCode ?? 0,
        );
    }
  }

  /// Get user-friendly message for HTTP status codes
  String _getStatusCodeMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Authentication failed. Please login again.';
      case 403:
        return 'Access denied. You don\'t have permission.';
      case 404:
        return 'Resource not found.';
      case 409:
        return 'Conflict occurred. Data may already exist.';
      case 422:
        return 'Validation failed. Please check your input.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Server is temporarily unavailable.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
```

---

## 📚 **Hướng Dẫn Sử Dụng**

### **1. 🚀 Getting Started**

```bash
# Clone project
git clone <repository-url>
cd flutter_template

# Install dependencies
flutter pub get

# Run on development
flutter run --flavor development --target lib/main_development.dart
```

### **2. 🏗️ Thêm Feature Mới**

**Bước 1: Tạo cấu trúc thư mục**
```
lib/features/new_feature/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── cubit/
│   ├── pages/
│   └── widgets/
└── new_feature_module.dart
```

**Bước 2: Tạo Module**
```dart
class NewFeatureModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<NewFeatureService>(NewFeatureService.new);
    i.addSingleton<NewFeatureCubit>(() => NewFeatureCubit(i.get<NewFeatureService>()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/new-feature', child: (context) => const NewFeaturePage());
  }
}
```

**Bước 3: Đăng ký trong AppModule**
```dart
@override
void routes(RouteManager r) {
  r.module('/new-feature', module: NewFeatureModule());
}
```

### **4. 🔐 Complete Authentication Implementation**

**AuthService with Real API Integration:**

```dart
// lib/features/authentication/data/services/auth_service.dart
import 'package:flutter_template/core/network/http_service.dart';
import 'package:flutter_template/core/network/models/api_response.dart';
import '../models/auth_response.dart';

class AuthService {
  final HttpService _httpService;

  AuthService(this._httpService);

  /// Login with comprehensive error handling
  Future<ApiResponse<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, password: password);

    return await _httpService.post<AuthResponse>(
      '/auth/login',
      data: request.toJson(),
      fromJson: (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      timeout: const Duration(seconds: 30),
    );
  }

  /// Register with validation
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

    return await _httpService.post<AuthResponse>(
      '/auth/register',
      data: request.toJson(),
      fromJson: (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      timeout: const Duration(seconds: 45),
    );
  }

  /// Logout with token invalidation
  Future<ApiResponse<void>> logout() async {
    return await _httpService.post<void>(
      '/auth/logout',
      timeout: const Duration(seconds: 15),
    );
  }

  /// Refresh token
  Future<ApiResponse<AuthResponse>> refreshToken(String refreshToken) async {
    return await _httpService.post<AuthResponse>(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
      fromJson: (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      timeout: const Duration(seconds: 20),
    );
  }

  /// Forgot password
  Future<ApiResponse<void>> forgotPassword(String email) async {
    return await _httpService.post<void>(
      '/auth/forgot-password',
      data: {'email': email},
      timeout: const Duration(seconds: 30),
    );
  }

  /// Verify email
  Future<ApiResponse<void>> verifyEmail(String token) async {
    return await _httpService.post<void>(
      '/auth/verify-email',
      data: {'token': token},
      timeout: const Duration(seconds: 30),
    );
  }
}
```

### **5. 🎯 BLoC/Cubit Implementation Pattern**

**Complete AuthCubit with all states:**

```dart
// lib/features/authentication/presentation/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/bloc/base_state.dart';
import 'package:flutter_template/shared/models/app_error.dart';
import '../../data/services/auth_service.dart';
import '../../domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthState());

  /// Check authentication status on app start
  Future<void> checkAuthStatus() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      // Check if user has valid token in storage
      // This would typically check SharedPreferences or secure storage
      await Future.delayed(const Duration(seconds: 1)); // Simulate check

      // If no valid token found
      emit(state.copyWith(
        status: StateStatus.success,
        isAuthenticated: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown('Failed to check auth status'),
      ));
    }
  }

  /// Login with comprehensive validation
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Validate input
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.validation('Email and password are required'),
      ));
      return;
    }

    if (!_isValidEmail(email)) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.validation('Please enter a valid email address'),
      ));
      return;
    }

    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        // Save tokens to secure storage here
        await _saveAuthData(response.data!);

        emit(state.copyWith(
          status: StateStatus.success,
          user: response.data!.user,
          isAuthenticated: true,
          accessToken: response.data!.accessToken,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.authentication(response.message ?? 'Login failed'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.network('Login failed: ${e.toString()}'),
      ));
    }
  }

  /// Register with validation
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    // Comprehensive validation
    final validationError = _validateRegistration(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
    );

    if (validationError != null) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: validationError,
      ));
      return;
    }

    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      );

      if (response.success && response.data != null) {
        await _saveAuthData(response.data!);

        emit(state.copyWith(
          status: StateStatus.success,
          user: response.data!.user,
          isAuthenticated: true,
          accessToken: response.data!.accessToken,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.validation(response.message ?? 'Registration failed'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.network('Registration failed: ${e.toString()}'),
      ));
    }
  }

  /// Logout with cleanup
  Future<void> logout() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      // Call logout API
      await _authService.logout();

      // Clear local storage
      await _clearAuthData();

      emit(state.copyWith(
        status: StateStatus.success,
        user: null,
        isAuthenticated: false,
        accessToken: null,
      ));
    } catch (e) {
      // Even if API call fails, clear local data
      await _clearAuthData();

      emit(state.copyWith(
        status: StateStatus.success,
        user: null,
        isAuthenticated: false,
        accessToken: null,
      ));
    }
  }

  /// Forgot password
  Future<void> forgotPassword(String email) async {
    if (!_isValidEmail(email)) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.validation('Please enter a valid email address'),
      ));
      return;
    }

    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _authService.forgotPassword(email);

      if (response.success) {
        emit(state.copyWith(
          status: StateStatus.success,
          message: 'Password reset instructions sent to your email',
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.unknown(response.message ?? 'Failed to send reset email'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.network('Failed to send reset email: ${e.toString()}'),
      ));
    }
  }

  /// Private helper methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  AppError? _validateRegistration({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    String? phoneNumber,
  }) {
    if (firstName.isEmpty) {
      return AppError.validation('First name is required');
    }
    if (lastName.isEmpty) {
      return AppError.validation('Last name is required');
    }
    if (email.isEmpty) {
      return AppError.validation('Email is required');
    }
    if (!_isValidEmail(email)) {
      return AppError.validation('Please enter a valid email address');
    }
    if (password.isEmpty) {
      return AppError.validation('Password is required');
    }
    if (password.length < 8) {
      return AppError.validation('Password must be at least 8 characters');
    }
    if (password != confirmPassword) {
      return AppError.validation('Passwords do not match');
    }
    if (phoneNumber != null && phoneNumber.isNotEmpty && !_isValidPhone(phoneNumber)) {
      return AppError.validation('Please enter a valid phone number');
    }

    return null;
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
  }

  Future<void> _saveAuthData(AuthResponse authResponse) async {
    // TODO: Implement secure storage
    // await _secureStorage.write(key: 'access_token', value: authResponse.accessToken);
    // await _secureStorage.write(key: 'refresh_token', value: authResponse.refreshToken);
    // await _secureStorage.write(key: 'user_data', value: jsonEncode(authResponse.user.toJson()));
  }

  Future<void> _clearAuthData() async {
    // TODO: Implement secure storage cleanup
    // await _secureStorage.deleteAll();
  }
}
```

### **3. 🔌 API Integration**

**Tạo Service:**
```dart
class NewFeatureService {
  Future<ApiResponse<DataModel>> fetchData() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock delay

      final mockResponse = {
        'success': true,
        'data': {'id': '1', 'name': 'Sample Data'},
        'message': 'Data fetched successfully',
      };

      return ApiResponse.fromJson(
        mockResponse,
        (data) => DataModel.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse.error(message: 'Failed to fetch data: ${e.toString()}');
    }
  }
}
```

**Sử dụng trong Cubit:**
```dart
class NewFeatureCubit extends Cubit<NewFeatureState> {
  final NewFeatureService _service;

  NewFeatureCubit(this._service) : super(const NewFeatureState());

  Future<void> loadData() async {
    emit(state.copyWith(status: StateStatus.loading));

    final response = await _service.fetchData();

    if (response.success && response.data != null) {
      emit(state.copyWith(
        status: StateStatus.success,
        data: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown(response.message ?? 'Unknown error'),
      ));
    }
  }
}
```

---

## 📚 **Hướng Dẫn Sử Dụng**

### **1. 🚀 Getting Started**

```bash
# Clone project
git clone <repository-url>
cd flutter_template

# Install dependencies
flutter pub get

# Run on development
flutter run --flavor development --target lib/main_development.dart
```

---

## 📋 **Best Practices**

### **1. 🏗️ Architecture**
- ✅ **Tuân thủ Clean Architecture** - data/domain/presentation layers
- ✅ **Single Responsibility** - mỗi class có một trách nhiệm
- ✅ **Dependency Injection** - sử dụng Modular DI
- ✅ **Error Handling** - xử lý lỗi ở mọi layer

### **2. 📝 Code Style**
- ✅ **Very Good Analysis** - tuân thủ linting rules
- ✅ **Meaningful Names** - đặt tên có ý nghĩa
- ✅ **Documentation** - comment cho complex logic
- ✅ **Type Safety** - sử dụng strong typing

### **3. 🔄 State Management**
- ✅ **BLoC Pattern** - sử dụng Cubit cho simple states
- ✅ **Immutable States** - states không thay đổi
- ✅ **Event-Driven** - UI phản ứng với state changes
- ✅ **Error States** - handle loading/error/success states

### **4. 🌐 API Integration**
- ✅ **Mock First** - tạo mock data trước
- ✅ **Error Response Models** - sử dụng structured error handling
- ✅ **Type-Safe Responses** - sử dụng generic types
- ✅ **Timeout Handling** - xử lý timeout và network errors

---

## 🚀 **Roadmap & Next Steps**

### **Phase 1: Core Features** ✅
- [x] Authentication system
- [x] Error handling
- [x] Modular architecture
- [x] Cross-platform support

### **Phase 2: Advanced Features** 🔄
- [ ] Real API integration
- [ ] Persistent storage (SharedPreferences/Hive)
- [ ] Push notifications
- [ ] Offline support

### **Phase 3: Production Ready** 📋
- [ ] Comprehensive testing
- [ ] Performance optimization
- [ ] Security hardening
- [ ] CI/CD pipeline

---

## 📞 **Support & Resources**

### **Documentation:**
- 📚 [Flutter Modular Docs](https://modular.flutterando.com.br/)
- 📚 [BLoC Library Docs](https://bloclibrary.dev/)
- 📚 [Dio HTTP Client](https://pub.dev/packages/dio)

### **Code Examples:**
- 🔐 **Authentication**: `lib/features/authentication/`
- 🌐 **API Calls**: `lib/core/network/`
- 🎨 **UI Components**: `lib/features/*/presentation/`
- 🧪 **Tests**: `test/`

---

