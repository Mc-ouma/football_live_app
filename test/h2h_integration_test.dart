import 'package:flutter_test/flutter_test.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/domain/usecases/football/get_head_to_head_fixtures.dart';

void main() {
  group('H2H Integration Tests', () {
    setUpAll(() async {
      await EnvConfig.initialize();
      await configureDependencies();
    });

    test('should fetch H2H fixtures successfully', () async {
      // Get the H2H use case from DI
      final getH2HFixtures = sl<GetHeadToHeadFixtures>();
      
      // Test with Manchester United (33) vs Newcastle (34)
      final params = HeadToHeadParams(
        team1Id: 33,
        team2Id: 34,
        limit: 5,
      );

      // Execute the use case
      final result = await getH2HFixtures(params);

      // Verify the result
      result.fold(
        (failure) {
          fail('H2H request failed: ${failure.message}');
        },
        (fixtures) {
          print('✅ H2H fixtures fetched successfully');
          print('📊 Number of fixtures: ${fixtures.length}');
          
          if (fixtures.isNotEmpty) {
            final firstFixture = fixtures.first;
            print('🏟️ First fixture: ${firstFixture.teams.home.name} vs ${firstFixture.teams.away.name}');
            print('📅 Date: ${firstFixture.fixture.date}');
            print('⚽ Score: ${firstFixture.goals.home} - ${firstFixture.goals.away}');
          }
          
          // Basic assertions
          expect(fixtures, isA<List>());
          expect(fixtures.length, lessThanOrEqualTo(5)); // Should respect limit
        },
      );
    });

    test('should handle invalid team IDs gracefully', () async {
      final getH2HFixtures = sl<GetHeadToHeadFixtures>();
      
      // Test with invalid team IDs
      final params = HeadToHeadParams(
        team1Id: 99999,
        team2Id: 88888,
        limit: 5,
      );

      final result = await getH2HFixtures(params);

      result.fold(
        (failure) {
          print('✅ Correctly handled invalid team IDs: ${failure.message}');
          expect(failure.message, isNotEmpty);
        },
        (fixtures) {
          print('📊 Number of fixtures for invalid teams: ${fixtures.length}');
          // Even with invalid teams, we should get an empty list, not an error
          expect(fixtures, isEmpty);
        },
      );
    });
  });
}
