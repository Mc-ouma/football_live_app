import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/domain/repositories/football/prediction_data_repository.dart';

class PredictionDataRepositoryImpl implements PredictionDataRepository {
  final FootballRemoteDataSource remoteDataSource;
  final Connectivity connectivity;
  final LoggerService logger;

  PredictionDataRepositoryImpl({
    required this.remoteDataSource,
    required this.connectivity,
    required this.logger,
  });

  @override
  Future<Either<Failure, PredictionData?>> getMatchPredictionData(
      int matchId) async {
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

      logger.info('Successfully fetched prediction data for match $matchId');
      return Right(predictionData);
    } catch (e) {
      logger.error('Error in getMatchPredictionData', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PredictionData>>> getMatchPredictionsData(
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
      final predictionsData =
          await remoteDataSource.getMatchPredictionsData(matchIds);

      logger.info(
          'Successfully fetched ${predictionsData.length} predictions data');
      return Right(predictionsData);
    } catch (e) {
      logger.error('Error in getMatchPredictionsData', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
