import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/usecases/usecase.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/domain/repositories/football/prediction_data_repository.dart';

class GetMatchPredictionsData
    implements
        UseCase<Either<Failure, List<PredictionData>>,
            GetMatchPredictionsDataParams> {
  final PredictionDataRepository repository;

  GetMatchPredictionsData(this.repository);

  @override
  Future<Either<Failure, List<PredictionData>>> call(
      GetMatchPredictionsDataParams params) async {
    return await repository.getMatchPredictionsData(params.matchIds);
  }
}

class GetMatchPredictionsDataParams extends Equatable {
  final List<int> matchIds;

  const GetMatchPredictionsDataParams({required this.matchIds});

  @override
  List<Object?> get props => [matchIds];
}
