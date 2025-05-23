import 'package:equatable/equatable.dart';
import 'package:football_live_app/domain/entities/fixture.dart';

class Standing extends Equatable {
  final int rank;
  final Team team;
  final int points;
  final String? description;
  final String? form;
  final StandingStats? all;
  final StandingStats? home;
  final StandingStats? away;
  final int goalsDiff;
  final String? group;
  final int? update;

  const Standing({
    required this.rank,
    required this.team,
    required this.points,
    this.description,
    this.form,
    this.all,
    this.home,
    this.away,
    required this.goalsDiff,
    this.group,
    this.update,
  });

  @override
  List<Object?> get props => [
    rank,
    team,
    points,
    description,
    form,
    all,
    home,
    away,
    goalsDiff,
    group,
    update,
  ];
}

class StandingStats extends Equatable {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final Goals goals;

  const StandingStats({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  @override
  List<Object?> get props => [played, win, draw, lose, goals];
}

class Goals extends Equatable {
  final int? forGoals;
  final int? against;

  const Goals({this.forGoals, this.against});

  @override
  List<Object?> get props => [forGoals, against];
}

class LeagueStanding extends Equatable {
  final League league;
  final List<List<Standing>> standings;

  const LeagueStanding({required this.league, required this.standings});

  @override
  List<Object?> get props => [league, standings];
}
