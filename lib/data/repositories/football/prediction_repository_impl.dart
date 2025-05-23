import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source.dart';
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
      final predictionModel =
          await remoteDataSource.getMatchPrediction(matchId);

      // If null, return Right(null) instead of a failure
      if (predictionModel == null) {
        logger.info('No prediction available for match $matchId');
        return const Right(null);
      }

      // Convert model to entity and return
      final prediction = predictionModel.toEntity();
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
      final predictionModels =
          await remoteDataSource.getMatchPredictions(matchIds);

      // Convert models to entities
      final predictions =
          predictionModels.map((model) => model.toEntity()).toList();

      logger.info('Successfully fetched ${predictions.length} predictions');
      return Right(predictions);
    } catch (e) {
      logger.error('Error in getMatchPredictions', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
