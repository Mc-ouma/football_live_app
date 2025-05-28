import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/data/models/shared_models.dart'; // Use Team from shared_models
import 'package:football_live_app/data/models/standings_model.dart'
    hide Team; // Hide Team from standings

abstract class FootballRepository {
  /// Get live matches that are currently in progress
  Future<Either<Failure, List<FixtureData>>> getLiveMatches();

  /// Get upcoming fixtures based on various filters
  Future<Either<Failure, List<FixtureData>>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  });

  /// Get detailed information about a specific match
  Future<Either<Failure, List<FixtureData>>> getMatchDetails(int matchId);

  /// Get detailed information about a team
  Future<Either<Failure, Team>> getTeamInformation(int teamId);

  /// Get team statistics for a specific league and season
  Future<Either<Failure, dynamic>> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  });

  /// Search for teams by name
  Future<Either<Failure, List<Team>>> searchTeams(String query);

  /// Get available leagues with optional filters
  Future<Either<Failure, List<League>>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  });

  /// Get league standings for a specific season
  Future<Either<Failure, List<StandingsData>>> getStandings({
    required int leagueId,
    required int season,
  });

  /// Get match predictions for a list of matches
  Future<Either<Failure, List<PredictionData>>> getMatchPredictions(
      List<int> matchIds);
}
