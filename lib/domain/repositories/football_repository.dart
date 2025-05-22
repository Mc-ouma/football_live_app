import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/match.dart';
import 'package:football_live_app/domain/entities/player.dart';
import 'package:football_live_app/domain/entities/standing.dart';

abstract class FootballRepository {
  /// Get live matches from API-Football
  Future<Either<Failure, List<Match>>> getLiveMatches();
  
  /// Get upcoming fixtures based on date, team, or league
  Future<Either<Failure, List<Match>>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  });
  
  /// Get match details by match ID
  Future<Either<Failure, Match>> getMatchDetails(int matchId);
  
  /// Get league standings
  Future<Either<Failure, LeagueStanding>> getLeagueStandings({
    required int leagueId,
    required int season,
  });
  
  /// Get team information
  Future<Either<Failure, Team>> getTeamInformation(int teamId);
  
  /// Get team statistics for a specific league/season
  Future<Either<Failure, dynamic>> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  });
  
  /// Get player information
  Future<Either<Failure, Player>> getPlayerInformation(int playerId);
  
  /// Get player statistics
  Future<Either<Failure, PlayerStatistics>> getPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
    int? teamId,
  });
  
  /// Search for teams by name
  Future<Either<Failure, List<Team>>> searchTeams(String query);
  
  /// Search for players by name
  Future<Either<Failure, List<Player>>> searchPlayers(String query);
  
  /// Get available leagues
  Future<Either<Failure, List<League>>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  });
}
