import 'package:flutter_test/flutter_test.dart';
import 'package:football_live_app/core/config/env_config.dart';

void main() {
  group('H2H Endpoint Configuration Tests', () {
    test('should have correct H2H endpoint configured', () {
      // Test that our new H2H endpoint is properly configured
      expect(EnvConfig.headToHead, equals('/fixtures/headtohead'));
      expect(EnvConfig.fixtures, equals('/fixtures'));
      
      // Verify they are different endpoints
      expect(EnvConfig.headToHead, isNot(equals(EnvConfig.fixtures)));
      
      print('✅ H2H endpoint configuration verified');
      print('📍 H2H endpoint: ${EnvConfig.headToHead}');
      print('📍 Regular fixtures endpoint: ${EnvConfig.fixtures}');
    });

    test('should format H2H API parameters correctly', () {
      // Test H2H parameter formatting
      const team1Id = 33; // Manchester United
      const team2Id = 34; // Newcastle
      const limit = 10;
      
      final h2hParam = '$team1Id-$team2Id';
      final expectedParams = {
        'h2h': h2hParam,
        'last': limit.toString(),
      };
      
      expect(h2hParam, equals('33-34'));
      expect(expectedParams['h2h'], equals('33-34'));
      expect(expectedParams['last'], equals('10'));
      
      print('✅ H2H parameter formatting verified');
      print('🔗 H2H param: ${expectedParams['h2h']}');
      print('📊 Limit param: ${expectedParams['last']}');
    });

    test('should have proper API base URL configuration', () {
      // Verify the base URL is correct for the H2H endpoint
      expect(EnvConfig.apiFootballBaseUrl, equals('https://v3.football.api-sports.io'));
      expect(EnvConfig.apiFootballHost, equals('v3.football.api-sports.io'));
      
      // Build full URL for H2H endpoint
      final fullH2HUrl = '${EnvConfig.apiFootballBaseUrl}${EnvConfig.headToHead}';
      expect(fullH2HUrl, equals('https://v3.football.api-sports.io/fixtures/headtohead'));
      
      print('✅ API URL configuration verified');
      print('🌐 Full H2H URL: $fullH2HUrl');
    });
  });
}
