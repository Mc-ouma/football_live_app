import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/usecases/usecase.dart';
import 'package:football_live_app/data/models/standings_model.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';

class GetStandings implements UseCase<List<StandingsData>, StandingsParams> {
  final FootballRepository repository;

  GetStandings(this.repository);

  @override
  Future<List<StandingsData>> call(StandingsParams params) async {
    final result = await repository.getStandings(
      leagueId: params.leagueId,
      season: params.season,
    );

    // Handle the Either by returning the result or throwing an exception
    return result.fold(
      (failure) => throw Exception(failure.toString()),
      (data) => data,
    );
  }
}

class StandingsParams extends Equatable {
  final int leagueId;
  final int season;

  const StandingsParams({
    required this.leagueId,
    required this.season,
  });

  @override
  List<Object> get props => [leagueId, season];
}
