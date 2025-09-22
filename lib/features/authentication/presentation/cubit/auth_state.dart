part of 'auth_cubit.dart';

class AuthState extends BaseState {
  const AuthState({
    super.status,
    super.error,
    this.user,
    this.isAuthenticated = false,
  });

  final User? user;
  final bool isAuthenticated;

  AuthState copyWith({
    StateStatus? status,
    AppError? error,
    User? user,
    bool? isAuthenticated,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        user,
        isAuthenticated,
      ];
}
