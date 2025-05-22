part of 'player_stats_bloc.dart';

abstract class PlayerStatsState extends Equatable {
  const PlayerStatsState();

  @override
  List<Object> get props => [];
}

class PlayerStatsInitial extends PlayerStatsState {}

class PlayerStatsLoading extends PlayerStatsState {}

class PlayerStatsLoaded extends PlayerStatsState {
  final PlayerStatistics playerStats;

  const PlayerStatsLoaded({required this.playerStats});

  @override
  List<Object> get props => [playerStats];
}

class PlayerStatsError extends PlayerStatsState {
  final String message;

  const PlayerStatsError({required this.message});

  @override
  List<Object> get props => [message];
}
