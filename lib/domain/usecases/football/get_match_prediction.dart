import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/usecases/usecase.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/domain/repositories/football/prediction_repository.dart';

class GetMatchPrediction implements UseCase<Either<Failure, Prediction?>, int> {
  final PredictionRepository repository;

  GetMatchPrediction(this.repository);

  @override
  Future<Either<Failure, Prediction?>> call(int matchId) async {
    return await repository.getMatchPrediction(matchId);
  }
}
