import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/usecases/usecase.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/domain/repositories/football/prediction_repository.dart';

class GetMatchPredictions
    implements
        UseCase<Either<Failure, List<Prediction>>, GetMatchPredictionsParams> {
  final PredictionRepository repository;

  GetMatchPredictions(this.repository);

  @override
  Future<Either<Failure, List<Prediction>>> call(
      GetMatchPredictionsParams params) async {
    return await repository.getMatchPredictions(params.matchIds);
  }
}

class GetMatchPredictionsParams extends Equatable {
  final List<int> matchIds;

  const GetMatchPredictionsParams({required this.matchIds});

  @override
  List<Object?> get props => [matchIds];
}
