part of 'player_stats_bloc.dart';

abstract class PlayerStatsEvent extends Equatable {
  const PlayerStatsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPlayerStatsEvent extends PlayerStatsEvent {
  final int playerId;
  final int season;
  final int? leagueId;
  final int? teamId;

  const FetchPlayerStatsEvent({
    required this.playerId,
    required this.season,
    this.leagueId,
    this.teamId,
  });

  @override
  List<Object?> get props => [playerId, season, leagueId, teamId];
}
