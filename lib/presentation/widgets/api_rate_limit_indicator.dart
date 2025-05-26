import 'dart:async';
import 'package:flutter/material.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/api_usage_monitor.dart';

/// A widget to show the current API rate limit status to the user
class ApiRateLimitIndicator extends StatefulWidget {
  const ApiRateLimitIndicator({Key? key}) : super(key: key);

  @override
  State<ApiRateLimitIndicator> createState() => _ApiRateLimitIndicatorState();
}

class _ApiRateLimitIndicatorState extends State<ApiRateLimitIndicator> {
  late final ApiUsageMonitor _apiUsageMonitor;
  late final ApiClient _apiClient;
  Map<String, dynamic> _rateLimitInfo = {
    'isRateLimited': false,
    'currentRequests': 0,
    'maxRequests': 100,
    'usagePercent': 0.0,
  };
  late ApiUsageLevel _usageLevel = ApiUsageLevel.normal;

  // Stream subscription for API usage updates
  StreamSubscription? _usageSubscription;

  @override
  void initState() {
    super.initState();
    _apiUsageMonitor = sl<ApiUsageMonitor>();
    _apiClient = sl<ApiClient>();
    _updateRateLimitInfo();

    // Subscribe to usage level changes
    _usageSubscription = _apiUsageMonitor.apiUsageStream.listen((level) {
      setState(() {
        _usageLevel = level;
        _updateRateLimitInfo();
      });
    });
  }

  @override
  void dispose() {
    _usageSubscription?.cancel();
    super.dispose();
  }

  void _updateRateLimitInfo() {
    setState(() {
      _rateLimitInfo = _apiClient.getRateLimitInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usagePercent = _rateLimitInfo['usagePercent'] as double;

    // Determine UI state based on the monitor's usage level
    final Color statusColor;
    final String statusMessage;

    switch (_usageLevel) {
      case ApiUsageLevel.normal:
        statusColor = Colors.green;
        statusMessage = '';
        break;
      case ApiUsageLevel.warning:
        statusColor = Colors.orange;
        statusMessage =
            'Approaching API usage limit. Some features may be limited.';
        break;
      case ApiUsageLevel.critical:
        statusColor = Colors.deepOrange;
        statusMessage =
            'API usage is critical. Only essential features are available.';
        break;
      case ApiUsageLevel.exceeded:
        statusColor = Colors.red;
        statusMessage =
            'API limit exceeded. Using cached data only. Please try again later.';
        break;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'API Usage:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_rateLimitInfo['currentRequests']}/${_rateLimitInfo['maxRequests']} requests',
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: usagePercent / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
            if (statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  statusMessage,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
