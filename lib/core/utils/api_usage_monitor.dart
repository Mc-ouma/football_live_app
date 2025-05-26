import 'dart:async';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/logger.dart';

/// API usage level enum for simple status reporting
enum ApiUsageLevel {
  /// Normal operation, plenty of requests remaining
  normal,

  /// Getting close to the limit, might want to reduce frequency
  warning,

  /// Very close to or at the limit, preserve remaining requests
  critical,

  /// Rate limit exceeded, requests will fail
  exceeded
}

/// Service to monitor API usage and implement conservation strategies
class ApiUsageMonitor {
  final ApiClient _apiClient;
  final LoggerService _logger;

  // Stream controller to broadcast API usage changes
  final _apiUsageController = StreamController<ApiUsageLevel>.broadcast();

  // Current API usage level
  ApiUsageLevel _currentLevel = ApiUsageLevel.normal;

  // Timer for periodic checks
  Timer? _monitorTimer;

  // Percentage thresholds for different usage levels
  static const double _warningThreshold = 70.0;
  static const double _criticalThreshold = 90.0;

  ApiUsageMonitor({
    required ApiClient apiClient,
    required LoggerService logger,
  })  : _apiClient = apiClient,
        _logger = logger {
    _startMonitoring();
  }

  /// Start periodic monitoring of API usage
  void _startMonitoring() {
    // Check immediately on startup
    _checkApiUsage();

    // Then check every minute
    _monitorTimer =
        Timer.periodic(const Duration(minutes: 1), (_) => _checkApiUsage());
  }

  /// Check current API usage and update status if needed
  void _checkApiUsage() {
    try {
      final rateLimitInfo = _apiClient.getRateLimitInfo();
      final usagePercent = rateLimitInfo['usagePercent'] as double;

      ApiUsageLevel newLevel;

      if (usagePercent >= 100) {
        newLevel = ApiUsageLevel.exceeded;
      } else if (usagePercent >= _criticalThreshold) {
        newLevel = ApiUsageLevel.critical;
      } else if (usagePercent >= _warningThreshold) {
        newLevel = ApiUsageLevel.warning;
      } else {
        newLevel = ApiUsageLevel.normal;
      }

      // Only notify listeners if the level has changed
      if (newLevel != _currentLevel) {
        _currentLevel = newLevel;
        _apiUsageController.add(newLevel);

        // Log the change
        _logger.info(
            'API usage level changed to ${newLevel.toString().split('.').last}: '
            '${rateLimitInfo['currentRequests']}/${rateLimitInfo['maxRequests']} '
            '(${usagePercent.toStringAsFixed(1)}%)');

        // Implement conservation strategies based on level
        _applyConservationStrategy(newLevel, rateLimitInfo);
      }
    } catch (e) {
      _logger.error('Error checking API usage', error: e);
    }
  }

  /// Apply strategies to conserve API usage based on current level
  void _applyConservationStrategy(
      ApiUsageLevel level, Map<String, dynamic> info) {
    switch (level) {
      case ApiUsageLevel.normal:
        // Normal operation, no constraints
        break;

      case ApiUsageLevel.warning:
        // Reduce frequency of non-critical API calls
        _logger.warning('API usage approaching limit. '
            'Reducing frequency of non-critical requests.');
        break;

      case ApiUsageLevel.critical:
        // Limit to only essential API calls
        _logger.warning('API usage critically high. '
            'Only essential requests will be processed.');
        break;

      case ApiUsageLevel.exceeded:
        // Emergency mode - rely on cache only
        _logger.error('API rate limit exceeded. '
            'Using cached data only until limit resets.');
        break;
    }
  }

  /// Get a stream of API usage level changes
  Stream<ApiUsageLevel> get apiUsageStream => _apiUsageController.stream;

  /// Get the current API usage level
  ApiUsageLevel get currentUsageLevel => _currentLevel;

  /// Check if a feature should proceed with making an API request
  /// based on its priority and current API usage
  bool shouldProceedWithRequest(String featureType,
      {bool isEssential = false}) {
    switch (_currentLevel) {
      case ApiUsageLevel.normal:
        // All requests allowed
        return true;

      case ApiUsageLevel.warning:
        // Allow all essential features and most non-essential
        if (isEssential) return true;

        // For predictions, standings, etc. - maybe reduce frequency
        return _isAllowedFeature(featureType);

      case ApiUsageLevel.critical:
        // Only essential features
        return isEssential;

      case ApiUsageLevel.exceeded:
        // Use cache only - no new requests
        return false;
    }
  }

  /// Determine if a feature is allowed based on its type
  /// during warning level usage
  bool _isAllowedFeature(String featureType) {
    // These features are prioritized even in warning mode
    const highPriorityFeatures = [
      'live_matches',
      'match_details',
      'upcoming_fixtures',
    ];

    return highPriorityFeatures.contains(featureType);
  }

  /// Dispose resources
  void dispose() {
    _monitorTimer?.cancel();
    _apiUsageController.close();
  }
}
