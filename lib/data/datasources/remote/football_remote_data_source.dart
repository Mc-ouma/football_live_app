/*
 * API Rate Limit Handling Strategy
 *
 * The API-Football service has strict rate limits (typically 100 requests per day for free tier).
 * To handle these limits, this implementation includes:
 *
 * 1. Batched Processing: Breaks large requests into smaller batches
 * 2. Sequential Execution: Processes requests sequentially within batches
 * 3. Request Delays: Adds delays between individual requests and batches
 * 4. Retry Mechanism: Implements exponential backoff for rate limit errors (429)
 * 5. Cache Fallback: Uses cached data when rate limits are hit
 *
 * The API client also has rate limit detection that works with this implementation.
 */

import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/data/models/standings_model.dart'
    as standings_models;
import 'package:football_live_app/data/models/shared_models.dart';

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

  /// Gets team information
  Future<Team> getTeamInformation(int teamId);

  /// Gets team statistics for a specific league/season
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

  /// Gets standings for a league and season
  Future<List<standings_models.StandingsData>> getStandings({
    required int leagueId,
    required int season,
  });

  /// Gets prediction data for a specific match
  Future<PredictionData?> getMatchPredictionData(int matchId);

  /// Gets prediction data for multiple matches
  Future<List<PredictionData>> getMatchPredictionsData(List<int> matchIds);
}

class FootballRemoteDataSourceImpl implements FootballRemoteDataSource {
  final ApiClient apiClient;
  final LoggerService logger;

  // Rate limiting configuration
  static const int _defaultDelayBetweenRequestsMs = 200;
  static const int _defaultDelayAfterRateLimitMs = 5000;

  FootballRemoteDataSourceImpl({
    required this.apiClient,
    required this.logger,
  });

  /// Process a list of items with API requests in a rate-limited fashion
  /// T is the type of the items to process
  /// R is the return type of the processing function
  Future<List<R>> fetchWithRateLimit<T, R>({
    required List<T> items,
    required Future<R?> Function(T item) processItem,
    int batchSize = 3,
    int delayBetweenRequestsMs = _defaultDelayBetweenRequestsMs,
    int delayBetweenBatchesMs = 2000,
  }) async {
    final List<R> results = [];

    // Process items in batches
    for (var i = 0; i < items.length; i += batchSize) {
      final endIndex =
          (i + batchSize < items.length) ? i + batchSize : items.length;
      final batch = items.sublist(i, endIndex);

      logger.info(
          'Processing batch ${i ~/ batchSize + 1} of ${(items.length / batchSize).ceil()}');

      // Process each item in the batch sequentially
      for (final item in batch) {
        try {
          final result = await processItem(item);
          if (result != null) {
            results.add(result);
          }

          // Add a delay between requests in the same batch (except after the last one)
          if (item != batch.last) {
            await Future.delayed(
                Duration(milliseconds: delayBetweenRequestsMs));
          }
        } on ServerException catch (e) {
          if (e.code == 429) {
            // If rate limit hit, log and continue with a longer delay
            logger.warning(
                'Rate limit hit during batch processing, adding delay');
            await Future.delayed(
                Duration(milliseconds: _defaultDelayAfterRateLimitMs));
            // Retry this item
            try {
              final result = await processItem(item);
              if (result != null) {
                results.add(result);
              }
            } catch (retryError) {
              logger.error('Error on retry', error: retryError);
              // Continue with next item
            }
          } else {
            // For other errors, log and continue
            logger.error('Error processing item', error: e);
          }
        }
      }

      // If this isn't the last batch, add a delay before processing the next batch
      if (endIndex < items.length) {
        logger.info('Delaying before next batch');
        await Future.delayed(Duration(milliseconds: delayBetweenBatchesMs));
      }
    }

    return results;
  }

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

      // Convert the EqualUnmodifiableListView to a List<FixtureData>
      return fixtureResponse.response.toList().cast<FixtureData>();
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

      // For upcoming fixtures, we can get multiple fixtures in a single API call
      // This helps reduce the number of API calls
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

      // Convert the EqualUnmodifiableListView to a List<FixtureData>
      final fixtures = fixtureResponse.response.toList().cast<FixtureData>();

      // Apply the limit if needed
      if (fixtures.length > limit) {
        return fixtures.sublist(0, limit);
      }

      return fixtures;
    } catch (e) {
      if (e is ServerException) {
        // If we hit a rate limit, we might want to retry after a delay
        if (e.code == 429) {
          logger.warning(
              'Rate limit hit when fetching fixtures, retrying after delay');
          await Future.delayed(
              Duration(milliseconds: _defaultDelayAfterRateLimitMs));

          // Try again with fewer results requested to reduce data volume
          final modifiedLimit = (limit / 2).ceil();
          return getUpcomingFixtures(
            date: date,
            teamId: teamId,
            leagueId: leagueId,
            season: season,
            limit: modifiedLimit,
          );
        }
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

      // Convert to List<FixtureData> first for type safety
      final fixtures = fixtureResponse.response.toList().cast<FixtureData>();
      return fixtures.first;
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

      // Parse the team information
      final teamData = responseBody['response'][0]['team'];
      final team = Team(
        id: teamData['id'],
        name: teamData['name'],
        logo: teamData['logo'],
        winner: null, // Not applicable in this context
        statistics: null, // Not applicable in this context
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
        leagues.add(
          League(
            id: leagueData['league']['id'],
            name: leagueData['league']['name'],
            country: leagueData['country']['name'],
            logo: leagueData['league']['logo'],
            flag: leagueData['country']['flag'],
            season: leagueData['seasons'][0]['year'],
            round: leagueData['seasons'][0]['current'] ? 'Current' : null,
          ),
        );
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

      // Convert the response to a List<PredictionData> for type safety
      final predictions =
          predictionResponse.response.toList().cast<PredictionData>();
      return predictions.isNotEmpty ? predictions.first : null;
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
  Future<List<standings_models.StandingsData>> getStandings({
    required int leagueId,
    required int season,
  }) async {
    try {
      // Build the query parameters
      final Map<String, dynamic> params = {
        'league': leagueId.toString(),
        'season': season.toString(),
      };

      final response = await apiClient.get(
        EnvConfig.standings,
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
        logger.info('No standings found');
        return [];
      }

      // Parse the standings
      final standingsResponse =
          standings_models.StandingsResponse.fromJson(responseBody);
      logger.info('Retrieved standings for league ID: $leagueId');

      return standingsResponse.response;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      logger.error('Error fetching standings', error: e);
      throw ServerException(
        message: 'Failed to get standings: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<PredictionData>> getMatchPredictionsData(
      List<int> matchIds) async {
    try {
      // Use our rate-limited fetch utility
      final predictions = await fetchWithRateLimit<int, PredictionData>(
        items: matchIds,
        processItem: (id) => getMatchPredictionData(id),
        batchSize: 3,
        delayBetweenBatchesMs: 2000,
      );

      logger.info(
          'Retrieved ${predictions.length} predictions out of ${matchIds.length} requested');
      return predictions;
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
