import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/domain/repositories/football/prediction_repository.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  final FootballRemoteDataSource remoteDataSource;
  final Connectivity connectivity;
  final LoggerService logger;

  PredictionRepositoryImpl({
    required this.remoteDataSource,
    required this.connectivity,
    required this.logger,
  });

  @override
  Future<Either<Failure, Prediction?>> getMatchPrediction(int matchId) async {
    try {
      // Check network connectivity
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        logger.error('No internet connection available for prediction fetch');
        return Left(
          NoInternetFailure(message: 'No network connection available'),
        );
      }

      // Fetch prediction from remote data source
      final predictionData =
          await remoteDataSource.getMatchPredictionData(matchId);

      // If null, return Right(null) instead of a failure
      if (predictionData == null) {
        logger.info('No prediction available for match $matchId');
        return const Right(null);
      }

      // Convert model to entity and return
      final prediction = _predictionDataToEntity(predictionData);
      logger.info('Successfully fetched prediction for match $matchId');
      return Right(prediction);
    } catch (e) {
      logger.error('Error in getMatchPrediction', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Prediction>>> getMatchPredictions(
      List<int> matchIds) async {
    try {
      // Check network connectivity
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        logger.error('No internet connection available for predictions fetch');
        return Left(
          NoInternetFailure(message: 'No network connection available'),
        );
      }

      // Fetch predictions from remote data source
      final predictionDataList =
          await remoteDataSource.getMatchPredictionsData(matchIds);

      // Convert models to entities
      final predictions = predictionDataList
          .map((data) => _predictionDataToEntity(data))
          .toList();

      logger.info('Successfully fetched ${predictions.length} predictions');
      return Right(predictions);
    } catch (e) {
      logger.error('Error in getMatchPredictions', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Converts [PredictionData] model to [Prediction] entity
  Prediction _predictionDataToEntity(PredictionData data) {
    // Extract winner information
    PredictionWinner? winner;
    final winnerName = data.predictions.winner;
    if (winnerName.isNotEmpty) {
      if (winnerName == 'home') {
        winner = PredictionWinner(
          id: data.teams.home.id.toString(),
          name: data.teams.home.name,
          comment: 'Home team predicted to win',
        );
      } else if (winnerName == 'away') {
        winner = PredictionWinner(
          id: data.teams.away.id.toString(),
          name: data.teams.away.name,
          comment: 'Away team predicted to win',
        );
      } else if (winnerName == 'draw') {
        winner = const PredictionWinner(
          id: null,
          name: 'Draw',
          comment: 'Match predicted to end in a draw',
        );
      }
    }

    // Extract percentage information
    final percent = <String, String>{
      'home': data.predictions.winnerSide.home,
      'away': data.predictions.winnerSide.away,
      'draw': data.predictions.winnerSide.draw,
    };

    // Extract goals information (simplified since we don't have detailed goals data)
    final goals = <String, String>{
      'home':
          '1', // Default value, actual implementation would need detailed data
      'away':
          '1', // Default value, actual implementation would need detailed data
    };

    // Extract comparison data (convert percentage strings to doubles)
    final comparison = <String, double>{
      'home': double.tryParse(
              data.predictions.winnerSide.home.replaceAll('%', '')) ??
          0.0,
      'away': double.tryParse(
              data.predictions.winnerSide.away.replaceAll('%', '')) ??
          0.0,
      'draw': double.tryParse(
              data.predictions.winnerSide.draw.replaceAll('%', '')) ??
          0.0,
    };

    return Prediction(
      winner: winner,
      percent: percent,
      goals: goals,
      advice: data.predictions.advice ? 'Recommended bet' : null,
      comparison: comparison,
      winOrDraw: data.predictions.underOver,
      underOver: data.predictions.goals ? 'over' : 'under',
    );
  }
}
