import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/shared_models.dart';

abstract class FootballRepository {
  /// Get live matches from API-Football
  Future<Either<Failure, List<FixtureData>>> getLiveMatches();

  /// Get upcoming fixtures based on date, team, or league
  Future<Either<Failure, List<FixtureData>>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  });

  /// Get match details by match ID
  Future<Either<Failure, FixtureData>> getMatchDetails(int matchId);

  /// Get team information
  Future<Either<Failure, Team>> getTeamInformation(int teamId);

  /// Get team statistics for a specific league/season
  Future<Either<Failure, dynamic>> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  });

  /// Search for teams by name
  Future<Either<Failure, List<Team>>> searchTeams(String query);

  /// Get available leagues
  Future<Either<Failure, List<League>>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  });
}
