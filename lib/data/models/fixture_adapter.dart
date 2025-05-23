import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/domain/entities/fixture.dart';

/// Adapter class to help transition from MatchModel to FixtureModel
/// This class provides helper methods to convert between the old Match structure
/// and the new Fixture structure.
class FixtureAdapter {
  /// Converts a FixtureData to what was previously expected as Match
  static FixtureData toMatchFormat(FixtureData fixtureData) {
    return fixtureData;
  }

  /// Converts a list of FixtureData to what was previously expected as List<Match>
  static List<FixtureData> toMatchListFormat(List<FixtureData> fixtures) {
    return fixtures;
  }

  /// Creates a fixture response from raw JSON data
  static FixtureResponse createFixtureResponseFromJson(
      Map<String, dynamic> json) {
    return FixtureResponse.fromJson(json);
  }

  /// Creates a fixture data entry from raw JSON data
  static FixtureData createFixtureDataFromJson(Map<String, dynamic> json) {
    return FixtureData.fromJson(json);
  }

  /// Converts database map to FixtureData format
  static FixtureData fromDatabase(Map<String, dynamic> map) {
    // Extract the base fixture information
    final fixtureData = Fixture(
      id: map['id'] as int,
      referee: map['referee'] as String?,
      timezone: map['timezone'] as String? ?? 'UTC',
      date: map['date'] as String? ?? DateTime.now().toIso8601String(),
      timestamp: map['timestamp'] as int? ?? 0,
      periods: FixturePeriods(
        first: map['status_first_period'] as int?,
        second: map['status_second_period'] as int?,
      ),
      venue: FixtureVenue(
        id: map['venue_id'] as int?,
        name: map['venue_name'] as String?,
        city: map['venue_city'] as String?,
      ),
      status: FixtureStatus(
        long: map['status_long'] as String? ?? '',
        short: map['status_short'] as String? ?? '',
        elapsed: map['status_elapsed'] as int?,
      ),
    );

    // Create team information
    final homeTeam = Team(
      id: map['home_team_id'] as int,
      name: map['home_team_name'] as String? ?? '',
      logo: map['home_team_logo'] as String? ?? '',
      winner: map['home_team_winner'] as bool?,
    );

    final awayTeam = Team(
      id: map['away_team_id'] as int,
      name: map['away_team_name'] as String? ?? '',
      logo: map['away_team_logo'] as String? ?? '',
      winner: map['away_team_winner'] as bool?,
    );

    // Create league information
    final league = League(
      id: map['league_id'] as int,
      name: map['league_name'] as String? ?? '',
      country: map['league_country'] as String? ?? '',
      logo: map['league_logo'] as String? ?? '',
      season: map['league_season'] as int? ?? 0,
      round: map['league_round'] as String?,
    );

    // Create goals information
    final goals = Goals(
      home: map['goals_home'] as int?,
      away: map['goals_away'] as int?,
    );

    // Create score information
    final score = Score(
      halftime: Goals(
        home: map['score_halftime_home'] as int?,
        away: map['score_halftime_away'] as int?,
      ),
      fulltime: Goals(
        home: map['score_fulltime_home'] as int?,
        away: map['score_fulltime_away'] as int?,
      ),
      extratime: map['score_extratime_home'] != null
          ? Goals(
              home: map['score_extratime_home'] as int?,
              away: map['score_extratime_away'] as int?,
            )
          : null,
      penalty: map['score_penalty_home'] != null
          ? Goals(
              home: map['score_penalty_home'] as int?,
              away: map['score_penalty_away'] as int?,
            )
          : null,
    );

    // Create the final FixtureData model
    return FixtureData(
      fixture: fixtureData,
      league: league,
      teams: Teams(home: homeTeam, away: awayTeam),
      goals: goals,
      score: score,
      // Events, lineups, statistics, and players would need to be loaded separately
    );
  }

  /// Converts a FixtureData to a database map
  static Map<String, dynamic> toDatabase(FixtureData fixtureData) {
    return {
      'id': fixtureData.fixture.id,
      'referee': fixtureData.fixture.referee,
      'timezone': fixtureData.fixture.timezone,
      'date': fixtureData.fixture.date,
      'timestamp': fixtureData.fixture.timestamp,
      'venue_id': fixtureData.fixture.venue.id,
      'venue_name': fixtureData.fixture.venue.name,
      'venue_city': fixtureData.fixture.venue.city,
      'status_long': fixtureData.fixture.status.long,
      'status_short': fixtureData.fixture.status.short,
      'status_elapsed': fixtureData.fixture.status.elapsed,
      'status_first_period': fixtureData.fixture.periods?.first,
      'status_second_period': fixtureData.fixture.periods?.second,
      'league_id': fixtureData.league.id,
      'league_name': fixtureData.league.name,
      'league_country': fixtureData.league.country,
      'league_logo': fixtureData.league.logo,
      'league_season': fixtureData.league.season,
      'league_round': fixtureData.league.round,
      'home_team_id': fixtureData.teams.home.id,
      'home_team_name': fixtureData.teams.home.name,
      'home_team_logo': fixtureData.teams.home.logo,
      'home_team_winner': fixtureData.teams.home.winner,
      'away_team_id': fixtureData.teams.away.id,
      'away_team_name': fixtureData.teams.away.name,
      'away_team_logo': fixtureData.teams.away.logo,
      'away_team_winner': fixtureData.teams.away.winner,
      'goals_home': fixtureData.goals.home,
      'goals_away': fixtureData.goals.away,
      'score_halftime_home': fixtureData.score.halftime.home,
      'score_halftime_away': fixtureData.score.halftime.away,
      'score_fulltime_home': fixtureData.score.fulltime.home,
      'score_fulltime_away': fixtureData.score.fulltime.away,
      'score_extratime_home': fixtureData.score.extratime?.home,
      'score_extratime_away': fixtureData.score.extratime?.away,
      'score_penalty_home': fixtureData.score.penalty?.home,
      'score_penalty_away': fixtureData.score.penalty?.away,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
      // Events, lineups, statistics, and players would need to be stored separately
    };
  }
}
