import 'package:dio/dio.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:football_live_app/core/utils/logger.dart';

class ApiClient {
  final Dio _dio;
  final Connectivity _connectivity;
  final LoggerService _logger;

  ApiClient({
    required Dio dio,
    required Connectivity connectivity,
    required LoggerService logger,
  })  : _dio = dio,
        _connectivity = connectivity,
        _logger = logger {
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

  /// Make a GET request to the API
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (!await _checkConnectivity()) {
        throw NoInternetException('No internet connection available');
      }

      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// Make a POST request to the API
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (!await _checkConnectivity()) {
        throw NoInternetException('No internet connection available');
      }

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
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
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

          return RateLimitException(
              message:
                  'API rate limit exceeded. Remaining requests: $remainingRequests. Resets in: $resetTime seconds.');
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
