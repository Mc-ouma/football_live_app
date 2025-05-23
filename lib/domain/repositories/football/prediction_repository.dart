import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/prediction.dart';

abstract class PredictionRepository {
  Future<Either<Failure, Prediction?>> getMatchPrediction(int matchId);
  Future<Either<Failure, List<Prediction>>> getMatchPredictions(
      List<int> matchIds);
}
