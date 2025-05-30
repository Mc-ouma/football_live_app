import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetHeadToHeadFixtures
    implements UseCase<List<FixtureData>, HeadToHeadParams> {
  final FootballRepository repository;

  GetHeadToHeadFixtures(this.repository);

  @override
  Future<Either<Failure, List<FixtureData>>> call(
    HeadToHeadParams params,
  ) async {
    return await repository.getHeadToHeadFixtures(
      team1Id: params.team1Id,
      team2Id: params.team2Id,
      limit: params.limit,
    );
  }
}

class HeadToHeadParams extends Equatable {
  final int team1Id;
  final int team2Id;
  final int limit;

  const HeadToHeadParams({
    required this.team1Id,
    required this.team2Id,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [team1Id, team2Id, limit];
}
