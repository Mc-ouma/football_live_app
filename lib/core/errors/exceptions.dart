/// Base exception for all app-specific exceptions
abstract class AppException implements Exception {
  final String message;
  final int? code;

  AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

/// Exception for server-related errors
class ServerException extends AppException {
  ServerException({required String message, int? code})
      : super(message: message, code: code);
}

/// Exception for rate limit exceeded
class RateLimitException extends AppException {
  RateLimitException({required String message})
      : super(message: message, code: 429);
}

/// Exception for unauthorized access (invalid API key)
class UnauthorizedException extends AppException {
  UnauthorizedException({required String message})
      : super(message: message, code: 401);
}

/// Exception for not found resources
class NotFoundException extends AppException {
  NotFoundException({required String message})
      : super(message: message, code: 404);
}

/// Exception for network connectivity issues
class NoInternetException extends AppException {
  NoInternetException(String message) : super(message: message, code: null);
}

/// Exception for request timeouts
class TimeoutException extends AppException {
  TimeoutException({required String message})
      : super(message: message, code: null);
}

/// Exception for cancelled requests
class RequestCancelledException extends AppException {
  RequestCancelledException({required String message})
      : super(message: message, code: null);
}

/// Exception for cache-related issues
class CacheException extends AppException {
  CacheException({required String message})
      : super(message: message, code: null);
}

/// Exception for authentication-related issues
class AuthException extends AppException {
  AuthException({required String message, int? code})
      : super(message: message, code: code);
}

/// Exception for validation errors
class ValidationException extends AppException {
  ValidationException({required String message})
      : super(message: message, code: null);
}
