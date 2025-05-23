import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/player_model.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/data/models/standing_model.dart';

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

  /// Gets match details by ID
  Future<FixtureData> getMatchDetails(int matchId);

  /// Gets league standings
  Future<LeagueStandingModel> getLeagueStandings({
    required int leagueId,
    required int season,
  });

  /// Gets team information
  Future<Team> getTeamInformation(int teamId);

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
  Future<List<Team>> searchTeams(String query);

  /// Search for players by name
  Future<List<PlayerModel>> searchPlayers(String query);

  /// Gets available leagues
  Future<List<League>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  });

  /// Gets prediction for a specific match
  Future<PredictionModel?> getMatchPrediction(int matchId);

  /// Gets predictions for multiple matches
  Future<List<PredictionModel>> getMatchPredictions(List<int> matchIds);

  /// Gets prediction data for a specific match
  Future<PredictionData?> getMatchPredictionData(int matchId);

  /// Gets prediction data for multiple matches
  Future<List<PredictionData>> getMatchPredictionsData(List<int> matchIds);
}

class FootballRemoteDataSourceImpl implements FootballRemoteDataSource {
  final ApiClient apiClient;
  final LoggerService logger;

  FootballRemoteDataSourceImpl({
    required this.apiClient,
    required this.logger,
  });

  @override
  Future<List<FixtureData>> getLiveMatches() async {
    try {
      // According to API-Football documentation, we can use '/fixtures?live=all'
      // to get all live matches across all leagues
      final response = await apiClient.get(EnvConfig.liveMatches);

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        logger.info('No live matches found');
        return [];
      }

      // Parse response using the fixture model
      final fixtureResponse = FixtureResponse.fromJson(responseBody);
      logger.info('Retrieved ${fixtureResponse.results} live matches');

      return fixtureResponse.response;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching live matches', error: e);
      throw ServerException(
        message: 'Failed to get live matches: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<FixtureData>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  }) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {};

      if (date != null) {
        // Format date as YYYY-MM-DD (API requirement)
        params['date'] =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      }

      if (teamId != null) {
        params['team'] = teamId.toString();
      }

      if (leagueId != null) {
        params['league'] = leagueId.toString();
      }

      if (season != null) {
        params['season'] = season.toString();
      }

      // Set the status to upcoming fixtures
      params['status'] = 'NS'; // Not Started

      // Set the timezone (optional)
      params['timezone'] =
          'Europe/London'; // Use UTC or your preferred timezone

      final response = await apiClient.get(
        EnvConfig.fixtures,
        queryParameters: params,
      );

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        logger.info('No upcoming fixtures found');
        return [];
      }

      // Parse response using the fixture model
      final fixtureResponse = FixtureResponse.fromJson(responseBody);
      logger.info('Retrieved ${fixtureResponse.results} upcoming fixtures');

      // Apply the limit if needed
      if (fixtureResponse.response.length > limit) {
        return fixtureResponse.response.sublist(0, limit);
      }

      return fixtureResponse.response;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching upcoming fixtures', error: e);
      throw ServerException(
        message: 'Failed to get upcoming fixtures: ${e.toString()}',
      );
    }
  }

  @override
  Future<FixtureData> getMatchDetails(int matchId) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {
        'id': matchId.toString(),
      };

      final response = await apiClient.get(
        EnvConfig.fixtures,
        queryParameters: params,
      );

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        throw ServerException(
          message: 'No match found with ID: $matchId',
        );
      }

      // Parse response using the fixture model
      final fixtureResponse = FixtureResponse.fromJson(responseBody);
      logger.info('Retrieved match details for match ID: $matchId');

      return fixtureResponse.response.first;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching match details', error: e);
      throw ServerException(
        message: 'Failed to get match details: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeagueStandingModel> getLeagueStandings({
    required int leagueId,
    required int season,
  }) async {
    // This depends on the structure of your LeagueStandingModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Team> getTeamInformation(int teamId) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {
        'id': teamId.toString(),
      };

      final response = await apiClient.get(
        EnvConfig.teams,
        queryParameters: params,
      );

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        throw ServerException(
          message: 'No team found with ID: $teamId',
        );
      }

      // Parse the team information - structure depends on your API
      final team = Team(
        id: responseBody['response'][0]['team']['id'],
        name: responseBody['response'][0]['team']['name'],
        logo: responseBody['response'][0]['team']['logo'],
      );

      logger.info('Retrieved team information for team ID: $teamId');
      return team;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching team information', error: e);
      throw ServerException(
        message: 'Failed to get team information: ${e.toString()}',
      );
    }
  }

  @override
  Future<dynamic> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  }) async {
    // Implementation for team statistics
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<PlayerModel> getPlayerInformation(int playerId) async {
    // Implementation for player information
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<PlayerStatisticsModel> getPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
    int? teamId,
  }) async {
    // Implementation for player statistics
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<List<Team>> searchTeams(String query) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {
        'search': query,
      };

      final response = await apiClient.get(
        EnvConfig.teams,
        queryParameters: params,
      );

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        logger.info('No teams found for query: $query');
        return [];
      }

      // Parse the teams information
      final List<Team> teams = [];
      for (final teamData in responseBody['response']) {
        teams.add(Team(
          id: teamData['team']['id'],
          name: teamData['team']['name'],
          logo: teamData['team']['logo'],
        ));
      }

      logger.info('Found ${teams.length} teams for query: $query');
      return teams;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error searching teams', error: e);
      throw ServerException(
        message: 'Failed to search teams: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<PlayerModel>> searchPlayers(String query) async {
    // Implementation for player search
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<List<League>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  }) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {};

      if (country != null) {
        params['country'] = country;
      }

      if (season != null) {
        params['season'] = season.toString();
      }

      if (current) {
        params['current'] = 'true';
      }

      final response = await apiClient.get(
        EnvConfig.leagues,
        queryParameters: params,
      );

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        logger.info('No leagues found');
        return [];
      }

      // Parse the leagues information
      final List<League> leagues = [];
      for (final leagueData in responseBody['response']) {
        leagues.add(League(
          id: leagueData['league']['id'],
          name: leagueData['league']['name'],
          country: leagueData['country']['name'],
          logo: leagueData['league']['logo'],
          flag: leagueData['country']['flag'],
          season: leagueData['seasons'][0]['year'],
          round: leagueData['seasons'][0]['current'] ? 'Current' : null,
        ));
      }

      logger.info('Found ${leagues.length} leagues');
      return leagues;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching leagues', error: e);
      throw ServerException(
        message: 'Failed to get leagues: ${e.toString()}',
      );
    }
  }

  @override
  Future<PredictionModel?> getMatchPrediction(int matchId) async {
    // Implementation for match prediction
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<List<PredictionModel>> getMatchPredictions(List<int> matchIds) async {
    // Implementation for match predictions
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<PredictionData?> getMatchPredictionData(int matchId) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {
        'fixture': matchId.toString(),
      };

      final response = await apiClient.get(
        EnvConfig.predictions,
        queryParameters: params,
      );

      final responseBody = response.data;

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          responseBody['errors'].isNotEmpty) {
        throw ServerException(
          message: 'API Error: ${responseBody['errors']}',
        );
      }

      // Check if we have results
      if (responseBody['results'] == 0) {
        logger.info('No prediction found for match ID: $matchId');
        return null;
      }

      // Parse response using the prediction model
      final predictionResponse = PredictionResponse.fromJson(responseBody);
      logger.info('Retrieved prediction for match ID: $matchId');

      return predictionResponse.response.first;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching match prediction data', error: e);
      throw ServerException(
        message: 'Failed to get match prediction data: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<PredictionData>> getMatchPredictionsData(
      List<int> matchIds) async {
    try {
      final List<PredictionData> allPredictions = [];

      // API-Football requires separate calls for each match ID
      // We'll make parallel requests to speed things up
      final futures = matchIds.map((id) => getMatchPredictionData(id));
      final results = await Future.wait(futures);

      // Filter out null results and collect predictions
      for (final prediction in results) {
        if (prediction != null) {
          allPredictions.add(prediction);
        }
      }

      logger.info('Retrieved ${allPredictions.length} predictions');
      return allPredictions;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching multiple match predictions data', error: e);
      throw ServerException(
        message: 'Failed to get match predictions data: ${e.toString()}',
      );
    }
  }
}
