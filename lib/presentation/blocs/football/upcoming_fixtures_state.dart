part of 'upcoming_fixtures_bloc.dart';

abstract class UpcomingFixturesState extends Equatable {
  const UpcomingFixturesState();

  @override
  List<Object> get props => [];
}

class UpcomingFixturesInitial extends UpcomingFixturesState {}

class UpcomingFixturesLoading extends UpcomingFixturesState {}

class UpcomingFixturesLoaded extends UpcomingFixturesState {
  final List<Match> fixtures;

  const UpcomingFixturesLoaded({required this.fixtures});

  @override
  List<Object> get props => [fixtures];
}

class UpcomingFixturesEmpty extends UpcomingFixturesState {
  final String message;

  const UpcomingFixturesEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class UpcomingFixturesError extends UpcomingFixturesState {
  final String message;

  const UpcomingFixturesError({required this.message});

  @override
  List<Object> get props => [message];
}
