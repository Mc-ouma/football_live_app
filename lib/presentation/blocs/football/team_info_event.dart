part of 'team_info_bloc.dart';

abstract class TeamInfoEvent extends Equatable {
  const TeamInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchTeamInfoEvent extends TeamInfoEvent {
  final int teamId;

  const FetchTeamInfoEvent({
    required this.teamId,
  });

  @override
  List<Object> get props => [teamId];
}
