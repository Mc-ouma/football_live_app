import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/data/models/standings_model.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetLeagueStandings
    implements UseCase<List<Standing>, LeagueStandingsParams> {
  final FootballRepository repository;

  GetLeagueStandings(this.repository);

  @override
  Future<Either<Failure, List<Standing>>> call(
      LeagueStandingsParams params) async {
    // Use the existing getStandings method to get standings data
    final result = await repository.getStandings(
      leagueId: params.leagueId,
      season: params.season,
    );

    // Transform the result to get the standings list from the first item if exists
    return result.fold(
      (failure) => Left(failure),
      (standingsDataList) {
        if (standingsDataList.isEmpty) {
          return const Right([]);
        }

        final standingsLeague = standingsDataList.first.league;
        if (standingsLeague.standings.isEmpty) {
          return const Right([]);
        }

        return Right(standingsLeague.standings.first);
      },
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
