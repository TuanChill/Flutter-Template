import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message]);
  
  final String? message;

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message]);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message]);
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure([super.message]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);
}

class ConflictFailure extends Failure {
  const ConflictFailure([super.message]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
