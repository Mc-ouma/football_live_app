import 'package:equatable/equatable.dart';

/// Base failure class that all specific failures will extend from
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Failure related to server issues
class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    int? code,
  }) : super(message: message, code: code);
}

/// Failure related to API rate limiting
class RateLimitFailure extends Failure {
  const RateLimitFailure({
    required String message,
  }) : super(message: message, code: 429);
}

/// Failure for unauthorized access (invalid API key)
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required String message,
  }) : super(message: message, code: 401);
}

/// Failure for resources not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required String message,
  }) : super(message: message, code: 404);
}

/// Failure for network connectivity issues
class NoInternetFailure extends Failure {
  const NoInternetFailure({
    required String message,
  }) : super(message: message);
}

/// Failure for request timeouts
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required String message,
  }) : super(message: message);
}

/// Failure for cancelled requests
class RequestCancelledFailure extends Failure {
  const RequestCancelledFailure({
    required String message,
  }) : super(message: message);
}

/// Failure for cache-related issues
class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
  }) : super(message: message);
}

/// Failure for authentication-related issues
class AuthFailure extends Failure {
  const AuthFailure({
    required String message,
    int? code,
  }) : super(message: message, code: code);
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    required String message,
  }) : super(message: message);
}
