import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/match_model.dart';
import 'package:football_live_app/data/models/player_model.dart';
import 'package:football_live_app/data/models/standing_model.dart';

abstract class FootballRemoteDataSource {
  /// Gets the current live matches
  Future<List<MatchModel>> getLiveMatches();

  /// Gets upcoming fixtures based on parameters
  Future<List<MatchModel>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  });

  /// Gets match details by ID
  Future<MatchModel> getMatchDetails(int matchId);

  /// Gets league standings
  Future<LeagueStandingModel> getLeagueStandings({
    required int leagueId,
    required int season,
  });

  /// Gets team information
  Future<TeamModel> getTeamInformation(int teamId);

  /// Gets team statistics for a specific league/season
  Future<dynamic> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  });

  /// Gets player information
  Future<PlayerModel> getPlayerInformation(int playerId);

  /// Gets player statistics
  Future<PlayerStatisticsModel> getPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
    int? teamId,
  });

  /// Search for teams by name
  Future<List<TeamModel>> searchTeams(String query);

  /// Search for players by name
  Future<List<PlayerModel>> searchPlayers(String query);

  /// Gets available leagues
  Future<List<LeagueModel>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  });
}

class FootballRemoteDataSourceImpl implements FootballRemoteDataSource {
  final ApiClient apiClient;
  final LoggerService logger;

  FootballRemoteDataSourceImpl({
    required this.apiClient,
    required this.logger,
  });

  @override
  Future<List<MatchModel>> getLiveMatches() async {
    try {
      // According to API-Football documentation, we can use '/fixtures?live=all'
      // to get all live matches across all leagues
      final response = await apiClient.get(EnvConfig.liveMatches);

      final responseBody = response.data;
      
      // Check for API errors
      if (responseBody['errors'] != null && responseBody['errors'] is Map && responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }
      
      // Check if we have results
      if (responseBody['results'] == 0) {
        logger.info('No live matches found');
        return [];
      }

      // Parse response data
      final List<dynamic> matchesData = responseBody['response'] ?? [];
      final matches = matchesData.map((match) => MatchModel.fromJson(match)).toList();
      
      logger.info('Fetched ${matches.length} live matches');
      return matches;
    } catch (e) {
      logger.error('Error getting live matches', error: e);
      rethrow;
    }
  }

  @override
  Future<List<MatchModel>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};

      if (date != null) {
        final dateString =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        queryParameters['date'] = dateString;
      }

      if (teamId != null) queryParameters['team'] = teamId;
      if (leagueId != null) queryParameters['league'] = leagueId;
      if (season != null) queryParameters['season'] = season;

      // Add next parameter to get upcoming fixtures
      if (date == null) queryParameters['next'] = limit;

      final response = await apiClient.get(
        EnvConfig.fixtures,
        queryParameters: queryParameters,
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> fixturesData = responseBody['response'] ?? [];
      return fixturesData
          .map((fixture) => MatchModel.fromJson(fixture))
          .toList();
    } catch (e) {
      logger.error('Error getting upcoming fixtures', error: e);
      rethrow;
    }
  }

  @override
  Future<MatchModel> getMatchDetails(int matchId) async {
    try {
      final response = await apiClient.get(
        EnvConfig.fixtures,
        queryParameters: {'id': matchId},
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> fixturesData = responseBody['response'] ?? [];
      if (fixturesData.isEmpty) {
        throw NotFoundException(message: 'Match with ID $matchId not found');
      }

      return MatchModel.fromJson(fixturesData[0]);
    } catch (e) {
      logger.error('Error getting match details', error: e);
      rethrow;
    }
  }

  @override
  Future<LeagueStandingModel> getLeagueStandings({
    required int leagueId,
    required int season,
  }) async {
    try {
      final response = await apiClient.get(
        EnvConfig.standings,
        queryParameters: {
          'league': leagueId,
          'season': season,
        },
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> standingsData = responseBody['response'] ?? [];
      if (standingsData.isEmpty) {
        throw NotFoundException(
          message:
              'Standings for league $leagueId and season $season not found',
        );
      }

      return LeagueStandingModel.fromJson(standingsData[0]);
    } catch (e) {
      logger.error('Error getting league standings', error: e);
      rethrow;
    }
  }

  @override
  Future<TeamModel> getTeamInformation(int teamId) async {
    try {
      final response = await apiClient.get(
        EnvConfig.teams,
        queryParameters: {'id': teamId},
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> teamsData = responseBody['response'] ?? [];
      if (teamsData.isEmpty) {
        throw NotFoundException(message: 'Team with ID $teamId not found');
      }

      final teamData = teamsData[0]['team'] ?? {};
      return TeamModel.fromJson(teamData);
    } catch (e) {
      logger.error('Error getting team information', error: e);
      rethrow;
    }
  }

  @override
  Future<dynamic> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  }) async {
    try {
      final response = await apiClient.get(
        '${EnvConfig.teams}/statistics',
        queryParameters: {
          'team': teamId,
          'league': leagueId,
          'season': season,
        },
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final statisticsData = responseBody['response'] ?? {};
      return statisticsData;
    } catch (e) {
      logger.error('Error getting team statistics', error: e);
      rethrow;
    }
  }

  @override
  Future<PlayerModel> getPlayerInformation(int playerId) async {
    try {
      final response = await apiClient.get(
        EnvConfig.players,
        queryParameters: {'id': playerId},
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> playersData = responseBody['response'] ?? [];
      if (playersData.isEmpty) {
        throw NotFoundException(message: 'Player with ID $playerId not found');
      }

      final playerData = playersData[0]['player'] ?? {};
      return PlayerModel.fromJson(playerData);
    } catch (e) {
      logger.error('Error getting player information', error: e);
      rethrow;
    }
  }

  @override
  Future<PlayerStatisticsModel> getPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
    int? teamId,
  }) async {
    try {
      final queryParams = {
        'id': playerId,
        'season': season,
      };

      if (leagueId != null) queryParams['league'] = leagueId;
      if (teamId != null) queryParams['team'] = teamId;

      final response = await apiClient.get(
        EnvConfig.players,
        queryParameters: queryParams,
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> playersData = responseBody['response'] ?? [];
      if (playersData.isEmpty) {
        throw NotFoundException(
          message: 'Statistics for player $playerId not found',
        );
      }

      return PlayerStatisticsModel.fromJson(playersData[0]);
    } catch (e) {
      logger.error('Error getting player statistics', error: e);
      rethrow;
    }
  }

  @override
  Future<List<TeamModel>> searchTeams(String query) async {
    try {
      final response = await apiClient.get(
        EnvConfig.teams,
        queryParameters: {'search': query},
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> teamsData = responseBody['response'] ?? [];
      return teamsData
          .map((team) => TeamModel.fromJson(team['team'] ?? {}))
          .toList();
    } catch (e) {
      logger.error('Error searching teams', error: e);
      rethrow;
    }
  }

  @override
  Future<List<PlayerModel>> searchPlayers(String query) async {
    try {
      final response = await apiClient.get(
        EnvConfig.players,
        queryParameters: {'search': query},
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> playersData = responseBody['response'] ?? [];
      return playersData
          .map((player) => PlayerModel.fromJson(player['player'] ?? {}))
          .toList();
    } catch (e) {
      logger.error('Error searching players', error: e);
      rethrow;
    }
  }

  @override
  Future<List<LeagueModel>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (country != null) queryParams['country'] = country;
      if (season != null) queryParams['season'] = season;
      if (current) queryParams['current'] = 'true';

      final response = await apiClient.get(
        EnvConfig.leagues,
        queryParameters: queryParams,
      );

      final responseBody = response.data;
      if (responseBody['errors']?.isNotEmpty ?? false) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      final List<dynamic> leaguesData = responseBody['response'] ?? [];
      return leaguesData
          .map((league) => LeagueModel.fromJson(league['league'] ?? {}))
          .toList();
    } catch (e) {
      logger.error('Error getting leagues', error: e);
      rethrow;
    }
  }
}
