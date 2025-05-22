part of 'team_info_bloc.dart';

abstract class TeamInfoState extends Equatable {
  const TeamInfoState();

  @override
  List<Object> get props => [];
}

class TeamInfoInitial extends TeamInfoState {}

class TeamInfoLoading extends TeamInfoState {}

class TeamInfoLoaded extends TeamInfoState {
  final Team team;

  const TeamInfoLoaded({required this.team});

  @override
  List<Object> get props => [team];
}

class TeamInfoError extends TeamInfoState {
  final String message;

  const TeamInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
