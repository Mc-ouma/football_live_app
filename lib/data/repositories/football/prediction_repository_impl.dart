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
    try {
      // Log key prediction data
      logger.info(
          'Converting prediction data: advice=${data.predictions.advice}, ' +
              'percent home=${data.predictions.percent?.home ?? "unknown"}, ' +
              'percent away=${data.predictions.percent?.away ?? "unknown"}, ' +
              'percent draw=${data.predictions.percent?.draw ?? "unknown"}');

      // Extract winner information
      PredictionWinner? winner;

      final winnerData = data.predictions.winner;
      if (winnerData != null) {
        if (winnerData.id != null && winnerData.id == data.teams.home.id) {
          winner = PredictionWinner(
            id: data.teams.home.id.toString(),
            name: data.teams.home.name,
            comment: winnerData.comment ?? 'Home team predicted to win',
          );
        } else if (winnerData.id != null &&
            winnerData.id == data.teams.away.id) {
          winner = PredictionWinner(
            id: data.teams.away.id.toString(),
            name: data.teams.away.name,
            comment: winnerData.comment ?? 'Away team predicted to win',
          );
        } else if (winnerData.name?.toLowerCase() == 'draw') {
          winner = PredictionWinner(
            id: null,
            name: 'Draw',
            comment: winnerData.comment ?? 'Match predicted to end in a draw',
          );
        } else if (winnerData.name != null) {
          winner = PredictionWinner(
            id: winnerData.id?.toString(),
            name: winnerData.name!,
            comment: winnerData.comment ?? 'Team predicted to win',
          );
        }
      }

      // Extract percentage information with null safety
      final percent = <String, String>{
        'home': data.predictions.percent?.home ?? '33%',
        'away': data.predictions.percent?.away ?? '33%',
        'draw': data.predictions.percent?.draw ?? '33%',
      };

      // Extract goals information from the prediction data
      final goals = <String, String>{
        'home': data.predictions.goals?.home?.toString() ?? 'unknown',
        'away': data.predictions.goals?.away?.toString() ?? 'unknown',
      };

      // Extract comparison data (convert percentage strings to doubles)
      final comparison = <String, double>{
        'home': double.tryParse(percent['home']!.replaceAll('%', '')) ?? 33.0,
        'away': double.tryParse(percent['away']!.replaceAll('%', '')) ?? 33.0,
        'draw': double.tryParse(percent['draw']!.replaceAll('%', '')) ?? 33.0,
      };

      return Prediction(
        winner: winner,
        percent: percent,
        goals: goals,
        advice: data.predictions.advice,
        comparison: comparison,
        winOrDraw: data.predictions.winOrDraw ?? false,
        underOver: data.predictions.underOver?.toString(),
      );
    } catch (e) {
      logger.error('Error converting prediction data to entity', error: e);

      // Return a default prediction to avoid crashing the app
      return Prediction(
        winner: null,
        percent: {'home': '33%', 'draw': '33%', 'away': '33%'},
        goals: {'home': 'unknown', 'away': 'unknown'},
        advice: 'No prediction available',
        comparison: {'home': 33.0, 'away': 33.0, 'draw': 33.0},
        winOrDraw: false,
        underOver: null,
      );
    }
  }
}
