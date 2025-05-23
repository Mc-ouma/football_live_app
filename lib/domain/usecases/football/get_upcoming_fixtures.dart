import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetUpcomingFixtures
    implements UseCase<List<Match>, UpcomingFixturesParams> {
  final FootballRepository repository;

  GetUpcomingFixtures(this.repository);

  @override
  Future<Either<Failure, List<Match>>> call(
    UpcomingFixturesParams params,
  ) async {
    return await repository.getUpcomingFixtures(
      date: params.date,
      teamId: params.teamId,
      leagueId: params.leagueId,
      season: params.season,
      limit: params.limit,
    );
  }
}

class UpcomingFixturesParams extends Equatable {
  final DateTime? date;
  final int? teamId;
  final int? leagueId;
  final int? season;
  final int limit;

  const UpcomingFixturesParams({
    this.date,
    this.teamId,
    this.leagueId,
    this.season,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [date, teamId, leagueId, season, limit];
}
