import 'package:dio/dio.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/config/api_rate_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/core/network/retry_config.dart';
import 'package:football_live_app/core/network/rate_limiter_interceptor.dart';

class ApiClient {
  final Dio _dio;
  final Connectivity _connectivity;
  final LoggerService _logger;
  final RetryConfig _retryConfig;
  final RateLimiterInterceptor _rateLimiter;

  ApiClient({
    required Dio dio,
    required Connectivity connectivity,
    required LoggerService logger,
    RetryConfig? retryConfig,
    RateLimiterInterceptor? rateLimiter,
  })  : _dio = dio,
        _connectivity = connectivity,
        _logger = logger,
        _retryConfig = retryConfig ??
            RetryConfig(
              maxRetries: ApiRateConfig.maxRetries,
              initialDelayMs: ApiRateConfig.initialRetryDelayMs,
              maxDelayMs: ApiRateConfig.maxRetryDelayMs,
              backoffFactor: ApiRateConfig.retryBackoffFactor,
              retryStatusCodes: ApiRateConfig.retryStatusCodes,
              logger: logger,
            ),
        _rateLimiter = rateLimiter ??
            RateLimiterInterceptor(
              maxRequests: ApiRateConfig.apiFootballRequestsPerMinute,
              timeWindowMs: ApiRateConfig.apiFootballTimeWindowMs,
              logger: logger,
            ) {
    _setupDioClient();
  }

  void _setupDioClient() {
    _dio.options.baseUrl = EnvConfig.apiFootballBaseUrl;
    _dio.options.headers = {
      'x-rapidapi-key': EnvConfig.apiFootballKey,
      'x-rapidapi-host': EnvConfig.apiFootballHost,
      'Content-Type': 'application/json',
    };
    _dio.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 15000);

    // Add rate limiter interceptor to prevent hitting API limits
    _dio.interceptors.add(_rateLimiter);

    // Add interceptors for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.debug('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.debug(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.error(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
            error: e,
          );
          return handler.next(e);
        },
      ),
    );
  }

  /// Check for internet connectivity before making a request
  Future<bool> _checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// Make a GET request to the API with automatic retry for rate limiting
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!await _checkConnectivity()) {
      throw NoInternetException('No internet connection available');
    }

    return _retryConfig
        .executeWithRetry<Response<T>>(
      operationName: 'GET:$path',
      operation: () async {
        final response = await _dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      },
      shouldRetry: (exception) {
        if (exception is DioException) {
          // Check if this is a rate limit exception (429)
          return exception.response?.statusCode == 429 ||
              _retryConfig
                  .shouldRetryForStatusCode(exception.response?.statusCode);
        }
        return false;
      },
    )
        .catchError((e) {
      if (e is DioException) {
        throw _handleError(e);
      } else if (e is Exception) {
        throw ServerException(message: e.toString());
      }
      throw e;
    });
  }

  /// Make a POST request to the API with automatic retry for rate limiting
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!await _checkConnectivity()) {
      throw NoInternetException('No internet connection available');
    }

    return _retryConfig
        .executeWithRetry<Response<T>>(
      operationName: 'POST:$path',
      operation: () async {
        final response = await _dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      },
      shouldRetry: (exception) {
        if (exception is DioException) {
          // Check if this is a rate limit exception (429)
          return exception.response?.statusCode == 429 ||
              _retryConfig
                  .shouldRetryForStatusCode(exception.response?.statusCode);
        }
        return false;
      },
    )
        .catchError((e) {
      if (e is DioException) {
        throw _handleError(e);
      } else if (e is Exception) {
        throw ServerException(message: e.toString());
      }
      throw e;
    });
  }

  /// Get information about the current rate limit status
  Map<String, dynamic> getRateLimitInfo() {
    return {
      'isRateLimited':
          _rateLimiter.currentRequestCount >= (_rateLimiter.maxRequests * 0.8),
      'currentRequests': _rateLimiter.currentRequestCount,
      'maxRequests': _rateLimiter.maxRequests,
      'resetInMs': _rateLimiter.timeWindowMs,
      'usagePercent':
          (_rateLimiter.currentRequestCount / _rateLimiter.maxRequests) * 100,
    };
  }

  /// Handle DioExceptions and convert them into domain-specific exceptions
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
            message: 'Connection timed out. Please try again.');

      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          return UnauthorizedException(
              message: 'Unauthorized. Please check your API key.');
        } else if (error.response?.statusCode == 429) {
          // Extract rate limit information from headers if available
          final headers = error.response?.headers;
          final remainingRequests =
              headers?.value('x-ratelimit-requests-remaining') ?? 'unknown';
          final resetTime =
              headers?.value('x-ratelimit-requests-reset') ?? 'unknown';
          final dailyLimit =
              headers?.value('x-ratelimit-requests-limit') ?? 'unknown';

          // Log detailed rate limit information
          _logger.warning(
            'API Rate Limit Hit: Daily Limit: $dailyLimit, Remaining: $remainingRequests, Reset in: $resetTime seconds',
            error: error,
          );

          return RateLimitException(
              message:
                  'API rate limit exceeded. Daily limit: $dailyLimit, Remaining: $remainingRequests, Resets in: $resetTime seconds.');
        } else if (error.response?.statusCode == 404) {
          return NotFoundException(
              message: 'The requested resource was not found.');
        } else {
          return ServerException(
            message: 'Server error: ${error.response?.statusCode}',
            code: error.response?.statusCode,
          );
        }

      case DioExceptionType.cancel:
        return RequestCancelledException(message: 'Request was cancelled');

      case DioExceptionType.connectionError:
        return NoInternetException(
            'Connection error. Please check your internet connection.');

      default:
        return ServerException(
            message: error.message ?? 'An unknown error occurred');
    }
  }
}
