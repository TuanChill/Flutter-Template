import 'package:flutter_template/core/bloc/base_state.dart';
import 'package:flutter_template/shared/models/app_error.dart';
import '../../data/services/auth_service.dart';
import '../../domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: StateStatus.success,
          user: response.data!.user,
          isAuthenticated: true,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.validation(response.message ?? 'Login failed'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown('Login failed: ${e.toString()}'),
      ));
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: StateStatus.success,
          user: response.data!.user,
          isAuthenticated: true,
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
        error: AppError.unknown('Registration failed: ${e.toString()}'),
      ));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(
      status: StateStatus.initial,
      user: null,
      isAuthenticated: false,
    ));
  }

  Future<void> checkAuthStatus() async {
    // Check if user is already logged in
    // This would typically check stored tokens from local storage
    emit(state.copyWith(status: StateStatus.loading));

    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: Implement actual token checking
    // final token = await _localStorage.getString(AppConstants.accessTokenKey);
    // if (token != null) {
    //   // Validate token and get user data
    //   final user = await _getUserFromToken(token);
    //   emit(state.copyWith(
    //     status: StateStatus.success,
    //     user: user,
    //     isAuthenticated: true,
    //   ));
    // } else {
    //   emit(state.copyWith(
    //     status: StateStatus.initial,
    //     isAuthenticated: false,
    //   ));
    // }

    // For now, assume user is not logged in
    emit(state.copyWith(
      status: StateStatus.initial,
      isAuthenticated: false,
    ));
  }
}
