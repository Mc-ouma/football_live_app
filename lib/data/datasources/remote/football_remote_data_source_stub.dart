import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/data/models/shared_models.dart';
// Use standings_model with prefix to avoid Team class conflict
import 'package:football_live_app/data/models/standings_model.dart' hide Team;

/// This is a stub implementation of FootballRemoteDataSource
/// It defines the interface but only returns stub responses
abstract class FootballRemoteDataSource {
  /// Gets the current live matches
  Future<List<FixtureData>> getLiveMatches();

  /// Gets upcoming fixtures based on parameters
  Future<List<FixtureData>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  });

  /// Gets detailed information about a specific match
  Future<FixtureData> getMatchDetails(int matchId);

  /// Gets match statistics
  Future<dynamic> getMatchStatistics(int matchId);

  /// Gets head to head matches between two teams
  Future<List<FixtureData>> getHeadToHead({
    required int team1Id,
    required int team2Id,
    int limit = 5,
  });

  /// Gets lineup information for a match
  Future<dynamic> getMatchLineups(int matchId);

  /// Gets team information
  Future<Team> getTeamInformation(int teamId);

  /// Gets team statistics for a specific season and league
  Future<dynamic> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  });

  /// Search for teams by name
  Future<List<Team>> searchTeams(String query);

  /// Gets available leagues
  Future<List<League>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  });

  /// Gets fixture timeline (events)
  Future<dynamic> getMatchTimeline(int matchId);

  /// Gets standings for a league
  Future<List<StandingsData>> getStandings({
    required int leagueId,
    required int season,
  });

  /// Gets predictions for a match
  Future<PredictionData?> getMatchPredictionData(int matchId);

  /// Gets predictions for multiple matches
  Future<List<PredictionData>> getMatchPredictionsData(List<int> matchIds);
}

class NotImplementedRemoteDataSource implements FootballRemoteDataSource {
  @override
  Future<List<FixtureData>> getLiveMatches() {
    throw UnimplementedError();
  }

  @override
  Future<List<FixtureData>> getUpcomingFixtures(
      {DateTime? date,
      int? teamId,
      int? leagueId,
      int? season,
      int limit = 10}) {
    throw UnimplementedError();
  }

  @override
  Future<FixtureData> getMatchDetails(int matchId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getMatchStatistics(int matchId) {
    throw UnimplementedError();
  }

  @override
  Future<List<FixtureData>> getHeadToHead(
      {required int team1Id, required int team2Id, int limit = 5}) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getMatchLineups(int matchId) {
    throw UnimplementedError();
  }

  @override
  Future<Team> getTeamInformation(int teamId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getTeamStatistics(
      {required int teamId, required int leagueId, required int season}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Team>> searchTeams(String query) {
    throw UnimplementedError();
  }

  @override
  Future<List<League>> getLeagues(
      {String? country, int? season, bool current = true}) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getMatchTimeline(int matchId) {
    throw UnimplementedError();
  }

  @override
  Future<List<StandingsData>> getStandings(
      {required int leagueId, required int season}) {
    throw UnimplementedError();
  }

  @override
  Future<PredictionData?> getMatchPredictionData(int matchId) {
    throw UnimplementedError();
  }

  @override
  Future<List<PredictionData>> getMatchPredictionsData(List<int> matchIds) {
    throw UnimplementedError();
  }
}
