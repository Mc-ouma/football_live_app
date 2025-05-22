import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/standing.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetLeagueStandings implements UseCase<LeagueStanding, LeagueStandingsParams> {
  final FootballRepository repository;

  GetLeagueStandings(this.repository);

  @override
  Future<Either<Failure, LeagueStanding>> call(LeagueStandingsParams params) async {
    return await repository.getLeagueStandings(
      leagueId: params.leagueId,
      season: params.season,
    );
  }
}

class LeagueStandingsParams extends Equatable {
  final int leagueId;
  final int season;

  const LeagueStandingsParams({
    required this.leagueId,
    required this.season,
  });

  @override
  List<Object> get props => [leagueId, season];
}
