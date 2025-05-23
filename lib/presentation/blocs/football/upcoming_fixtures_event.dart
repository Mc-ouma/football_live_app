part of 'upcoming_fixtures_bloc.dart';

abstract class UpcomingFixturesEvent extends Equatable {
  const UpcomingFixturesEvent();

  @override
  List<Object?> get props => [];
}

class FetchUpcomingFixturesEvent extends UpcomingFixturesEvent {
  final DateTime? date;
  final int limit;

  const FetchUpcomingFixturesEvent({
    this.date,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [date, limit];
}

class FetchTeamFixturesEvent extends UpcomingFixturesEvent {
  final int teamId;
  final int? season;
  final int limit;

  const FetchTeamFixturesEvent({
    required this.teamId,
    this.season,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [teamId, season, limit];
}

class FetchLeagueFixturesEvent extends UpcomingFixturesEvent {
  final int leagueId;
  final int? season;
  final int limit;

  const FetchLeagueFixturesEvent({
    required this.leagueId,
    this.season,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [leagueId, season, limit];
}
