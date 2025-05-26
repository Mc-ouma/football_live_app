import 'package:football_live_app/core/config/api_rate_config.dart';
import 'package:football_live_app/core/utils/logger.dart';

/// A utility class to help manage caching strategies
/// to work well with API rate limits
class CacheStrategy {
  final LoggerService _logger;

  // Tracks per-endpoint request counts to prioritize requests
  final Map<String, int> _endpointRequestCounts = {};

  CacheStrategy({
    required LoggerService logger,
  }) : _logger = logger;

  /// Get cache expiry duration for a specific data type
  Duration getCacheExpiryDuration(CacheDataType dataType) {
    switch (dataType) {
      case CacheDataType.liveMatch:
        return Duration(minutes: ApiRateConfig.liveDataCacheExpiryMinutes);
      case CacheDataType.fixture:
        return Duration(hours: 1); // Fixtures can change but not as frequently
      case CacheDataType.prediction:
        return Duration(hours: 4); // Predictions change less frequently
      case CacheDataType.league:
        return Duration(days: 7); // League data is fairly static
      case CacheDataType.standings:
        return Duration(hours: 12); // Standings change daily
      case CacheDataType.team:
        return Duration(days: 7); // Team information is fairly static
      default:
        return Duration(hours: ApiRateConfig.defaultCacheExpiryHours);
    }
  }

  /// Determines if a request should proceed based on cache age and importance
  bool shouldMakeRequest(
      String endpoint, CacheDataType dataType, Duration cacheAge,
      {bool isHighPriority = false}) {
    // For high priority or empty cache, always make the request
    if (isHighPriority || cacheAge == Duration.zero) {
      _incrementEndpointCount(endpoint);
      return true;
    }

    // If cache is empty but not high priority, check current rate limit usage
    if (cacheAge == Duration.zero) {
      // Let's make some requests and build the cache initially
      _incrementEndpointCount(endpoint);
      return true;
    }

    final expiryDuration = getCacheExpiryDuration(dataType);

    // If cache is still fresh based on the data type, use cache
    if (cacheAge < expiryDuration) {
      _logger.info(
          'Using cache for $endpoint (age: ${_formatDuration(cacheAge)})');
      return false;
    }

    // Cache is stale, but we'll consider the endpoint priority
    final requestCountForEndpoint = _endpointRequestCounts[endpoint] ?? 0;
    final totalRequests = _getTotalRequestCount();

    // If we're approaching daily limits, be more conservative
    // Only refresh cache for less frequently requested endpoints
    if (totalRequests > ApiRateConfig.apiFootballDailyLimit * 0.7) {
      if (requestCountForEndpoint >
          totalRequests / _endpointRequestCounts.length) {
        _logger.warning(
            'Skipping cache refresh for $endpoint to conserve rate limit. ' +
                'This endpoint has been requested $requestCountForEndpoint times.');
        return false;
      }
    }

    _incrementEndpointCount(endpoint);
    return true;
  }

  /// Increment the request count for an endpoint
  void _incrementEndpointCount(String endpoint) {
    _endpointRequestCounts[endpoint] =
        (_endpointRequestCounts[endpoint] ?? 0) + 1;
  }

  /// Get the total request count across all endpoints
  int _getTotalRequestCount() {
    return _endpointRequestCounts.values.fold(0, (sum, count) => sum + count);
  }

  /// Format a duration into a human-readable string
  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} days';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hours';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minutes';
    } else {
      return '${duration.inSeconds} seconds';
    }
  }
}

/// Types of data for caching strategies
enum CacheDataType {
  liveMatch,
  fixture,
  prediction,
  league,
  standings,
  team,
  other,
}
