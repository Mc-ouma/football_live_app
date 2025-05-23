import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/prediction_model.dart';

abstract class PredictionDataRepository {
  Future<Either<Failure, PredictionData?>> getMatchPredictionData(int matchId);
  Future<Either<Failure, List<PredictionData>>> getMatchPredictionsData(
      List<int> matchIds);
}
