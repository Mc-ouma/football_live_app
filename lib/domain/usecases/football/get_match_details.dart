import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetMatchDetails implements UseCase<FixtureData, Params> {
  final FootballRepository repository;

  GetMatchDetails(this.repository);

  @override
  Future<Either<Failure, FixtureData>> call(Params params) async {
    return await repository.getMatchDetails(params.matchId);
  }
}

class Params extends Equatable {
  final int matchId;

  const Params({required this.matchId});

  @override
  List<Object> get props => [matchId];
}
