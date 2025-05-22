part of 'live_matches_bloc.dart';

abstract class LiveMatchesState extends Equatable {
  const LiveMatchesState();
  
  @override
  List<Object> get props => [];
}

class LiveMatchesInitial extends LiveMatchesState {}

class LiveMatchesLoading extends LiveMatchesState {}

class LiveMatchesLoaded extends LiveMatchesState {
  final List<Match> matches;

  const LiveMatchesLoaded({required this.matches});

  @override
  List<Object> get props => [matches];
}

class LiveMatchesEmpty extends LiveMatchesState {
  final String message;

  const LiveMatchesEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class LiveMatchesError extends LiveMatchesState {
  final String message;

  const LiveMatchesError({required this.message});

  @override
  List<Object> get props => [message];
}
