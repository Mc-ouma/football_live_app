import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetLiveMatches implements NoParamsUseCase<List<FixtureData>> {
  final FootballRepository repository;

  GetLiveMatches(this.repository);

  @override
  Future<Either<Failure, List<FixtureData>>> call() async {
    return await repository.getLiveMatches();
  }
}
