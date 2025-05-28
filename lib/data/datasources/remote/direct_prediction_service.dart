import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart'; // Make sure this exists
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/data/models/shared_models.dart' as shared;

/**
 * DirectPredictionService is a simple service that handles the new prediction API format
 * by extracting data directly from the JSON without relying on complex model parsing.
 * It adapts the new API format to the existing model structure to avoid conflicts.
 */
class DirectPredictionService {
  final ApiClient apiClient;
  final LoggerService logger;

  DirectPredictionService({
    required this.apiClient,
    required this.logger,
  });

  /// Gets prediction data for a specific match using direct JSON manipulation
  /// to handle the new API format
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

      // Validate response data
      if (response.data == null) {
        logger.warning('Null response data for match ID: $matchId');
        return null;
      }

      final responseBody = response.data;

      // Ensure responseBody is a Map<String, dynamic>
      if (responseBody is! Map<String, dynamic>) {
        logger.error(
            'Invalid response format for match ID: $matchId. Expected Map<String, dynamic> but got ${responseBody.runtimeType}');
        return null;
      }

      // Check for API errors
      if (responseBody['errors'] != null &&
          responseBody['errors'] is Map &&
          (responseBody['errors'] as Map).isNotEmpty) {
        logger.warning(
            'API errors for match ID $matchId: ${responseBody['errors']}');
        return null;
      }

      // Check if we have results
      if (responseBody['results'] == 0 || responseBody['results'] == null) {
        logger.info('No prediction found for match ID: $matchId');
        return null;
      }

      // Handle the new API response format directly
      try {
        // Extract the first item from the response list
        if (responseBody['response'] is List &&
            (responseBody['response'] as List).isNotEmpty) {
          final predictionItem = (responseBody['response'] as List).first;

          if (predictionItem is Map<String, dynamic>) {
            // Extract predictions data
            final predictionsData =
                predictionItem['predictions'] as Map<String, dynamic>? ?? {};
            final percentData =
                predictionsData['percent'] as Map<String, dynamic>? ??
                    {'home': '33%', 'draw': '33%', 'away': '33%'};

            // Now we need to adapt the data to our expected model structure
            // Extract the predicted winner information
            final predictedWinner = predictionsData['winner']?.toString() ?? '';

            // Create our model objects
            final winner = Winner(
                id: null,
                name: predictedWinner.isNotEmpty ? predictedWinner : null,
                comment: predictedWinner.isNotEmpty
                    ? 'Predicted winner: $predictedWinner'
                    : null);

            // Create percent object for predictions
            final percent = Percent(
                home: percentData['home']?.toString() ?? '33%',
                draw: percentData['draw']?.toString() ?? '33%',
                away: percentData['away']?.toString() ?? '33%');

            // Extract goals data if available
            PredictionGoals? goals;
            if (predictionsData['goals'] is Map<String, dynamic>) {
              final goalsMap = predictionsData['goals'] as Map<String, dynamic>;
              goals = PredictionGoals(
                  home:
                      goalsMap['home'] is int ? goalsMap['home'] as int : null,
                  away:
                      goalsMap['away'] is int ? goalsMap['away'] as int : null);
            }

            // Extract advice if available
            final String advice =
                predictionsData['advice']?.toString() ?? 'No advice available';

            // Create a PredictionData object with our transformed data
            return PredictionData(
              predictions: Predictions(
                winner: winner,
                winOrDraw: false, // Default value as it's required
                underOver: predictionsData['under_over'],
                goals: goals,
                advice: advice,
                percent: percent,
              ),
              league: _extractLeague(predictionItem['league']),
              fixture: _extractFixture(predictionItem['fixture']),
              teams: _extractTeams(predictionItem['teams']),
            );
          }
        }

        logger.warning('Could not extract prediction data from response');
        return null;
      } catch (e) {
        logger.error('Error parsing prediction response for match ID: $matchId',
            error: e);
        return null; // Return null instead of throwing to make the app more resilient
      }
    } catch (e) {
      if (e is ServerException) {
        logger.warning('Server exception for match ID $matchId: ${e.message}');
        return null;
      }
      logger.error('Error fetching match prediction data for ID $matchId',
          error: e);
      return null; // Return null to make app more resilient, instead of propagating the exception
    }
  }

  // Helper methods to extract components from the JSON response
  shared.League _extractLeague(Map<String, dynamic>? json) {
    if (json == null) {
      return shared.League(
        id: 0,
        name: 'Unknown League',
        country: 'Unknown',
        logo: '',
        season: 0,
      );
    }

    return shared.League(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown League',
      country: json['country'] ?? 'Unknown',
      logo: json['logo'] ?? '',
      flag: json['flag'],
      season: json['season'] ?? 0,
    );
  }

  shared.Fixture _extractFixture(Map<String, dynamic>? json) {
    if (json == null) {
      return shared.Fixture(
        id: 0,
        timezone: 'UTC',
        date: '',
        timestamp: 0,
        venue: shared.FixtureVenue(name: 'Unknown'),
        status: shared.FixtureStatus(long: 'Not Started', short: 'NS'),
      );
    }

    return shared.Fixture(
      id: json['id'] ?? 0,
      timezone: json['timezone'] ?? 'UTC',
      date: json['date'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      venue: shared.FixtureVenue(
        name: json['venue']?['name'] ?? 'Unknown',
        city: json['venue']?['city'],
      ),
      status: shared.FixtureStatus(
        long: json['status']?['long'] ?? 'Not Started',
        short: json['status']?['short'] ?? 'NS',
      ),
    );
  }

  shared.Teams _extractTeams(Map<String, dynamic>? json) {
    if (json == null) {
      return shared.Teams(
        home: shared.Team(id: 0, name: 'Home Team', logo: ''),
        away: shared.Team(id: 0, name: 'Away Team', logo: ''),
      );
    }

    return shared.Teams(
      home: shared.Team(
        id: json['home']?['id'] ?? 0,
        name: json['home']?['name'] ?? 'Home Team',
        logo: json['home']?['logo'] ?? '',
      ),
      away: shared.Team(
        id: json['away']?['id'] ?? 0,
        name: json['away']?['name'] ?? 'Away Team',
        logo: json['away']?['logo'] ?? '',
      ),
    );
  }
}
