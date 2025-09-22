import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class AuthResponse extends Equatable {
  const AuthResponse({
    required this.user,
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  final User user;
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      expiresIn: json['expiresIn'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken, expiresIn];
}

class LoginRequest extends Equatable {
  const LoginRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [email, password];
}

class RegisterRequest extends Equatable {
  const RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.dateOfBirth,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phoneNumber;
  final DateTime? dateOfBirth;

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        dateOfBirth,
      ];
}
