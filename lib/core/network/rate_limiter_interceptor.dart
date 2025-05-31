import 'dart:async';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:football_live_app/core/utils/logger.dart';

/// An interceptor for Dio that implements client-side rate limiting
/// to prevent hitting API rate limits
class RateLimiterInterceptor extends Interceptor {
  /// Maximum number of requests allowed in the time window
  final int maxRequests;

  /// Time window in milliseconds (e.g. 1000 = 1 second)
  final int timeWindowMs;

  /// Logger for debugging
  final LoggerService? logger;

  /// Queue of timestamp when requests were made
  final Queue<DateTime> _requestTimestamps = Queue<DateTime>();

  /// Controls concurrent access to the queue
  Completer<void> _mutex = Completer<void>()..complete();

  /// Whether to use a sliding window (true) or fixed window (false)
  final bool slidingWindow;

  /// Get current request count in the time window
  int get currentRequestCount => _requestTimestamps.length;

  RateLimiterInterceptor({
    required this.maxRequests,
    required this.timeWindowMs,
    this.logger,
    this.slidingWindow = true,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final now = DateTime.now();

    // Wait for any pending operations to complete
    await _mutex.future;

    try {
      _cleanupOldRequests(now);

      if (_requestTimestamps.length >= maxRequests) {
        final oldestTs = _requestTimestamps.first;
        final windowEndTime =
            oldestTs.add(Duration(milliseconds: timeWindowMs));
        final waitTimeMs = windowEndTime.difference(now).inMilliseconds;

        if (waitTimeMs > 0) {
          logger?.info(
            'Rate limiting applied - delaying request by ${waitTimeMs}ms ' +
                'to stay within limit of $maxRequests requests per ${timeWindowMs}ms',
          );

          // Create a new mutex for the next operation
          _mutex = Completer<void>();

          // Delay and then proceed with the request
          await Future.delayed(Duration(milliseconds: waitTimeMs));
          _requestTimestamps.add(DateTime.now());
          _mutex.complete();
          handler.next(options);
          return;
        }
      }

      // Add current request timestamp and proceed
      _requestTimestamps.add(now);

      // Log the current usage
      final usage = '${_requestTimestamps.length}/$maxRequests';
      logger?.debug('API Request: $usage in current window');

      // Create a new mutex for the next operation
      _mutex = Completer<void>();
      _mutex.complete();

      handler.next(options);
    } catch (e) {
      logger?.error('Error in rate limiter: $e');
      // Ensure mutex is completed even on error
      if (!_mutex.isCompleted) {
        _mutex.complete();
      }
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Extract rate limit info from headers if available
    final headers = response.headers;
    final remainingRequests = headers.value('x-ratelimit-requests-remaining');
    final resetTime = headers.value('x-ratelimit-requests-reset');
    final dailyLimit = headers.value('x-ratelimit-requests-limit');

    if (remainingRequests != null && resetTime != null) {
      logger?.info(
        'API Rate Limit Status: $remainingRequests/$dailyLimit remaining, ' +
            'resets in $resetTime seconds',
      );

      // Adjust our rate limiting based on server feedback
      if (int.tryParse(remainingRequests) != null &&
          int.parse(remainingRequests) < maxRequests ~/ 5) {
        logger?.warning(
          'Low on remaining requests ($remainingRequests). ' +
              'Consider implementing stricter rate limiting.',
        );
      }
    }

    handler.next(response);
  }

  /// Remove timestamps that are outside the current time window
  void _cleanupOldRequests(DateTime now) {
    final threshold = now.subtract(Duration(milliseconds: timeWindowMs));

    while (_requestTimestamps.isNotEmpty &&
        _requestTimestamps.first.isBefore(threshold)) {
      _requestTimestamps.removeFirst();
    }
  }
}
