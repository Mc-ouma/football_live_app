/// Configuration for API rate limits and retry behavior
class ApiRateConfig {
  /// API Football - Free tier limits

  /// Maximum requests per day (100 for free tier)
  static const int apiFootballDailyLimit = 100;

  /// Conservative client-side limit per minute to ensure we don't hit the daily limit
  /// Set to a reasonable value based on your app's usage pattern
  static const int apiFootballRequestsPerMinute = 10;

  /// Time window for client-side rate limiting in milliseconds
  static const int apiFootballTimeWindowMs = 60 * 1000;

  /// Retry configuration

  /// Maximum number of retry attempts for failed requests
  static const int maxRetries = 3;

  /// Initial delay before first retry in milliseconds
  static const int initialRetryDelayMs = 1000;

  /// Maximum delay between retries in milliseconds
  static const int maxRetryDelayMs = 30000;

  /// Backoff factor for exponential backoff
  static const double retryBackoffFactor = 1.5;

  /// Status codes that should trigger a retry
  static const Set<int> retryStatusCodes = {429, 500, 502, 503, 504};

  /// Cache configuration

  /// Default cache expiry time in hours for API responses
  static const int defaultCacheExpiryHours = 24;

  /// Cache expiry time in minutes for frequently changing data (like live scores)
  static const int liveDataCacheExpiryMinutes = 5;
}
