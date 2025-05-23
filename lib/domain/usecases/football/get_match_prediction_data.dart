import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/usecases/usecase.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/domain/repositories/football/prediction_data_repository.dart';

class GetMatchPredictionData
    implements UseCase<Either<Failure, PredictionData?>, int> {
  final PredictionDataRepository repository;

  GetMatchPredictionData(this.repository);

  @override
  Future<Either<Failure, PredictionData?>> call(int params) async {
    return await repository.getMatchPredictionData(params);
  }
}
