part of 'live_matches_bloc.dart';

abstract class LiveMatchesEvent extends Equatable {
  const LiveMatchesEvent();

  @override
  List<Object> get props => [];
}

class FetchLiveMatchesEvent extends LiveMatchesEvent {}

class StartLiveUpdatesEvent extends LiveMatchesEvent {}

class StopLiveUpdatesEvent extends LiveMatchesEvent {}
