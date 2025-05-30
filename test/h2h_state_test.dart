import 'package:flutter_test/flutter_test.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/data/models/fixture_model.dart';

void main() {
  group('Enhanced FixtureDetailsState Tests', () {
    test('should have separate H2H fixtures field', () {
      // Create mock fixture data
      final mockFixture = FixtureData(
        fixture: Fixture(
          id: 1,
          referee: null,
          timezone: 'UTC',
          date: '2023-01-01T00:00:00Z',
          timestamp: 1672531200,
          periods: Periods(first: null, second: null),
          venue: Venue(id: 1, name: 'Test Stadium', city: 'Test City'),
          status: Status(long: 'Match Finished', short: 'FT', elapsed: 90),
        ),
        league: League(
          id: 1,
          name: 'Test League',
          country: 'Test Country',
          logo: 'test_logo.png',
          flag: 'test_flag.png',
          season: 2023,
          round: 'Regular Season - 1',
        ),
        teams: Teams(
          home: Team(
              id: 1, name: 'Home Team', logo: 'home_logo.png', winner: true),
          away: Team(
              id: 2, name: 'Away Team', logo: 'away_logo.png', winner: false),
        ),
        goals: Goals(home: 2, away: 1),
        score: Score(
          halftime: Goals(home: 1, away: 0),
          fulltime: Goals(home: 2, away: 1),
          extratime: Goals(home: null, away: null),
          penalty: Goals(home: null, away: null),
        ),
      );

      final mockH2HFixture = FixtureData(
        fixture: Fixture(
          id: 2,
          referee: null,
          timezone: 'UTC',
          date: '2022-12-01T00:00:00Z',
          timestamp: 1669852800,
          periods: Periods(first: null, second: null),
          venue: Venue(id: 1, name: 'Test Stadium', city: 'Test City'),
          status: Status(long: 'Match Finished', short: 'FT', elapsed: 90),
        ),
        league: League(
          id: 1,
          name: 'Test League',
          country: 'Test Country',
          logo: 'test_logo.png',
          flag: 'test_flag.png',
          season: 2022,
          round: 'Regular Season - 10',
        ),
        teams: Teams(
          home: Team(
              id: 2, name: 'Away Team', logo: 'away_logo.png', winner: false),
          away: Team(
              id: 1, name: 'Home Team', logo: 'home_logo.png', winner: true),
        ),
        goals: Goals(home: 0, away: 3),
        score: Score(
          halftime: Goals(home: 0, away: 1),
          fulltime: Goals(home: 0, away: 3),
          extratime: Goals(home: null, away: null),
          penalty: Goals(home: null, away: null),
        ),
      );

      // Test state without H2H data
      final stateWithoutH2H = FixtureDetailsLoaded([mockFixture]);

      expect(stateWithoutH2H.fixtures.length, 1);
      expect(stateWithoutH2H.headToHeadFixtures.length, 0);
      expect(stateWithoutH2H.hasFixtures, true);
      expect(stateWithoutH2H.hasHeadToHeadFixtures, false);
      expect(stateWithoutH2H.fixture?.fixture.id, 1);

      // Test state with H2H data
      final stateWithH2H = FixtureDetailsLoaded(
        [mockFixture],
        headToHeadFixtures: [mockH2HFixture],
      );

      expect(stateWithH2H.fixtures.length, 1);
      expect(stateWithH2H.headToHeadFixtures.length, 1);
      expect(stateWithH2H.hasFixtures, true);
      expect(stateWithH2H.hasHeadToHeadFixtures, true);
      expect(stateWithH2H.fixture?.fixture.id, 1);
      expect(stateWithH2H.headToHeadFixtures.first.fixture.id, 2);

      // Test copyWith functionality
      final updatedState = stateWithoutH2H.copyWith(
        headToHeadFixtures: [mockH2HFixture],
      );

      expect(updatedState.fixtures.length, 1);
      expect(updatedState.headToHeadFixtures.length, 1);
      expect(updatedState.hasHeadToHeadFixtures, true);
      expect(updatedState.fixture?.fixture.id, 1);
      expect(updatedState.headToHeadFixtures.first.fixture.id, 2);
    });

    test('should preserve original fixtures when adding H2H data', () {
      final mockFixture1 = FixtureData(
        fixture: Fixture(
          id: 1,
          referee: null,
          timezone: 'UTC',
          date: '2023-01-01T00:00:00Z',
          timestamp: 1672531200,
          periods: Periods(first: null, second: null),
          venue: Venue(id: 1, name: 'Test Stadium', city: 'Test City'),
          status: Status(long: 'Match Finished', short: 'FT', elapsed: 90),
        ),
        league: League(
          id: 1,
          name: 'Test League',
          country: 'Test Country',
          logo: 'test_logo.png',
          flag: 'test_flag.png',
          season: 2023,
          round: 'Regular Season - 1',
        ),
        teams: Teams(
          home: Team(
              id: 1, name: 'Home Team', logo: 'home_logo.png', winner: true),
          away: Team(
              id: 2, name: 'Away Team', logo: 'away_logo.png', winner: false),
        ),
        goals: Goals(home: 2, away: 1),
        score: Score(
          halftime: Goals(home: 1, away: 0),
          fulltime: Goals(home: 2, away: 1),
          extratime: Goals(home: null, away: null),
          penalty: Goals(home: null, away: null),
        ),
      );

      final mockH2HFixture = FixtureData(
        fixture: Fixture(
          id: 100,
          referee: null,
          timezone: 'UTC',
          date: '2022-06-01T00:00:00Z',
          timestamp: 1654041600,
          periods: Periods(first: null, second: null),
          venue: Venue(id: 2, name: 'Another Stadium', city: 'Another City'),
          status: Status(long: 'Match Finished', short: 'FT', elapsed: 90),
        ),
        league: League(
          id: 1,
          name: 'Test League',
          country: 'Test Country',
          logo: 'test_logo.png',
          flag: 'test_flag.png',
          season: 2022,
          round: 'Regular Season - 5',
        ),
        teams: Teams(
          home: Team(
              id: 1, name: 'Home Team', logo: 'home_logo.png', winner: false),
          away: Team(
              id: 2, name: 'Away Team', logo: 'away_logo.png', winner: true),
        ),
        goals: Goals(home: 1, away: 2),
        score: Score(
          halftime: Goals(home: 0, away: 1),
          fulltime: Goals(home: 1, away: 2),
          extratime: Goals(home: null, away: null),
          penalty: Goals(home: null, away: null),
        ),
      );

      // Start with a state containing original fixture data
      final originalState = FixtureDetailsLoaded([mockFixture1]);

      // Add H2H data using copyWith
      final stateWithH2H = originalState.copyWith(
        headToHeadFixtures: [mockH2HFixture],
      );

      // Verify original fixture data is preserved
      expect(stateWithH2H.fixtures.length, 1);
      expect(stateWithH2H.fixtures.first.fixture.id, 1);
      expect(stateWithH2H.fixtures.first.teams.home.name, 'Home Team');

      // Verify H2H data is added
      expect(stateWithH2H.headToHeadFixtures.length, 1);
      expect(stateWithH2H.headToHeadFixtures.first.fixture.id, 100);
      expect(
          stateWithH2H.headToHeadFixtures.first.teams.home.name, 'Home Team');

      // Verify convenience methods work correctly
      expect(stateWithH2H.hasFixtures, true);
      expect(stateWithH2H.hasHeadToHeadFixtures, true);
      expect(stateWithH2H.fixtureCount, 1);
      expect(stateWithH2H.headToHeadCount, 1);
    });
  });
}
