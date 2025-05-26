import 'dart:async';
import 'dart:math' as math;

import 'package:football_live_app/core/utils/logger.dart';

/// Configuration for request retry behavior
class RetryConfig {
  /// Maximum number of retry attempts before giving up
  final int maxRetries;

  /// Initial delay in milliseconds before the first retry
  final int initialDelayMs;

  /// Maximum delay in milliseconds between retries
  final int maxDelayMs;

  /// Multiplier for backoff (how quickly delay increases)
  final double backoffFactor;

  /// Status codes that should trigger a retry
  final Set<int> retryStatusCodes;

  /// Logger service for debugging
  final LoggerService? logger;

  /// Creates a new retry configuration
  const RetryConfig({
    this.maxRetries = 3,
    this.initialDelayMs = 1000,
    this.maxDelayMs = 30000,
    this.backoffFactor = 1.5,
    this.retryStatusCodes = const {429, 500, 502, 503, 504},
    this.logger,
  });

  /// Calculate delay for the next retry using exponential backoff with jitter
  int calculateDelayForAttempt(int attempt) {
    if (attempt <= 0) return 0;

    // Calculate exponential backoff
    final exponentialDelay =
        initialDelayMs * math.pow(backoffFactor, attempt - 1).toInt();

    // Apply maximum delay limit
    final cappedDelay = math.min(exponentialDelay, maxDelayMs);

    // Add random jitter (±10% of delay) to prevent retry storms
    final jitter =
        (math.Random().nextInt(cappedDelay ~/ 5) - (cappedDelay ~/ 10)).abs();

    // Final delay with jitter
    return cappedDelay + jitter;
  }

  /// Execute the given function with retry logic
  Future<T> executeWithRetry<T>({
    required Future<T> Function() operation,
    required bool Function(Exception exception) shouldRetry,
    required String operationName,
  }) async {
    Exception? lastException;

    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        // First attempt or retry
        if (attempt > 0) {
          final delay = calculateDelayForAttempt(attempt);
          logger?.info(
            '[$operationName] Retry attempt $attempt/${maxRetries} after ${delay}ms',
          );
          await Future.delayed(Duration(milliseconds: delay));
        }

        // Execute the operation
        return await operation();
      } on Exception catch (e) {
        lastException = e;

        // Determine if we should retry
        final canRetry = shouldRetry(e);

        if (!canRetry || attempt >= maxRetries) {
          logger?.warning(
            '[$operationName] ${canRetry ? "Max retries exceeded" : "Non-retryable error"} after ${attempt + 1} attempts',
            error: e,
          );
          break;
        }

        logger?.warning(
          '[$operationName] Attempt ${attempt + 1} failed, will retry',
          error: e,
        );
      }
    }

    // If we got here, all attempts failed
    throw lastException!;
  }
}

/// Extension on RetryConfig to make it easier to use
extension RetryConfigExtension on RetryConfig {
  /// Check if a status code should trigger a retry
  bool shouldRetryForStatusCode(int? statusCode) {
    return statusCode != null && retryStatusCodes.contains(statusCode);
  }
}
