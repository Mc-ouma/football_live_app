part of 'standings_bloc.dart';

abstract class StandingsState extends Equatable {
  const StandingsState();
  
  @override
  List<Object> get props => [];
}

class StandingsInitial extends StandingsState {}

class StandingsLoading extends StandingsState {}

class StandingsLoaded extends StandingsState {
  final List<Standing> standings;

  const StandingsLoaded({required this.standings});

  @override
  List<Object> get props => [standings];
}

class StandingsEmpty extends StandingsState {
  final String message;

  const StandingsEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class StandingsError extends StandingsState {
  final String message;

  const StandingsError({required this.message});

  @override
  List<Object> get props => [message];
}
