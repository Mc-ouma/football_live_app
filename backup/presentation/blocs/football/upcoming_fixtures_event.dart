part of 'upcoming_fixtures_bloc.dart';

abstract class UpcomingFixturesEvent extends Equatable {
  const UpcomingFixturesEvent();

  @override
  List<Object?> get props => [];
}

class FetchUpcomingFixturesEvent extends UpcomingFixturesEvent {
  final DateTime? date;
  final int? teamId;
  final int? leagueId;
  final int? season;
  final int limit;

  const FetchUpcomingFixturesEvent({
    this.date,
    this.teamId,
    this.leagueId,
    this.season,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [date, teamId, leagueId, season, limit];
}
