part of 'standings_bloc.dart';

abstract class StandingsEvent extends Equatable {
  const StandingsEvent();

  @override
  List<Object> get props => [];
}

class FetchStandingsEvent extends StandingsEvent {
  final int leagueId;
  final int season;

  const FetchStandingsEvent({
    required this.leagueId,
    required this.season,
  });

  @override
  List<Object> get props => [leagueId, season];
}
