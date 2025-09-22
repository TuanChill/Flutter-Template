class ServerException implements Exception {
  const ServerException([this.message]);
  final String? message;
}

class CacheException implements Exception {
  const CacheException([this.message]);
  final String? message;
}

class NetworkException implements Exception {
  const NetworkException([this.message]);
  final String? message;
}

class ValidationException implements Exception {
  const ValidationException([this.message]);
  final String? message;
}

class AuthenticationException implements Exception {
  const AuthenticationException([this.message]);
  final String? message;
}

class AuthorizationException implements Exception {
  const AuthorizationException([this.message]);
  final String? message;
}

class NotFoundException implements Exception {
  const NotFoundException([this.message]);
  final String? message;
}

class ConflictException implements Exception {
  const ConflictException([this.message]);
  final String? message;
}
