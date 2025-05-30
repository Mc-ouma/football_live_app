import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static bool _initialized = false;
  static late String apiFootballKey;
  static const String apiFootballHost = 'v3.football.api-sports.io';
  static const String apiFootballBaseUrl = 'https://v3.football.api-sports.io';

  /// Initialize environment configuration
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      await dotenv.load(fileName: ".env");
      apiFootballKey =
          dotenv.env['API_FOOTBALL_KEY'] ?? '0880f79a66438c6e30f16c8ff7f6fe2d';

      if (kDebugMode) {
        print(
            'API Football Key: ${apiFootballKey.substring(0, 4)}...${apiFootballKey.substring(apiFootballKey.length - 4)}');

        if (apiFootballKey == '0880f79a66438c6e30f16c8ff7f6fe2d') {
          print(
              'WARNING: Using default API key. Set the actual API key for production.');
        }
      }

      _initialized = true;
    } catch (e) {
      // Ensure the API key is set even if there's an error
      apiFootballKey = '0880f79a66438c6e30f16c8ff7f6fe2d'; // Default fallback
      if (kDebugMode) {
        print('ERROR initializing environment config: $e');
        print('Using fallback API key');
      }
      _initialized = true;
    }
  }

  // API endpoints
  static const String liveMatches = '/fixtures?live=all';
  static const String fixtures = '/fixtures';
  static const String leagues = '/leagues';
  static const String standings = '/standings';
  static const String teams = '/teams';
  static const String players = '/players';
  static const String predictions =
      '/predictions'; // New endpoint for predictions
  static const String headToHead = '/fixtures/headtohead'; // H2H endpoint

  // API Query Parameters
  static const String paramDate = 'date';
  static const String paramSeason = 'season';
  static const String paramLeague = 'league';
  static const String paramTeam = 'team';
  static const String paramPlayer = 'player';
  static const String paramNext = 'next';
  static const String paramLast = 'last';
  static const String paramId = 'id';

  // Local database config
  static const String databaseName = 'football_live.db';
  static const int databaseVersion = 1;

  // Cache duration in minutes
  static const int cacheDuration = 30;

  // Privacy policy URL for GDPR
  static const String privacyPolicyUrl = 'https://yourapp.com/privacy-policy';
}
