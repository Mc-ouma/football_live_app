import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/player.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetPlayerStatistics implements UseCase<PlayerStatistics, PlayerStatsParams> {
  final FootballRepository repository;

  GetPlayerStatistics(this.repository);

  @override
  Future<Either<Failure, PlayerStatistics>> call(PlayerStatsParams params) async {
    return await repository.getPlayerStatistics(
      playerId: params.playerId,
      season: params.season,
      leagueId: params.leagueId,
      teamId: params.teamId,
    );
  }
}

class PlayerStatsParams extends Equatable {
  final int playerId;
  final int season;
  final int? leagueId;
  final int? teamId;

  const PlayerStatsParams({
    required this.playerId,
    required this.season,
    this.leagueId,
    this.teamId,
  });

  @override
  List<Object?> get props => [playerId, season, leagueId, teamId];
}
