import 'package:equatable/equatable.dart';
import 'package:football_live_app/domain/entities/match_event.dart';
import 'package:football_live_app/domain/entities/prediction.dart';

class Match extends Equatable {
  final int id;
  final String? referee;
  final String timezone;
  final DateTime date;
  final int timestamp;
  final Venue venue;
  final MatchStatus status;
  final League league;
  final Team homeTeam;
  final Team awayTeam;
  final Score? score;
  final List<MatchEvent> events;
  final Prediction? prediction;
  final LineUp? lineups;
  final MatchStatistics? statistics;

  const Match({
    required this.id,
    this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.venue,
    required this.status,
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    this.score,
    this.events = const [],
    this.prediction,
    this.lineups,
    this.statistics,
  });

  @override
  List<Object?> get props => [
        id,
        referee,
        timezone,
        date,
        timestamp,
        venue,
        status,
        league,
        homeTeam,
        awayTeam,
        score,
        events,
        prediction,
        lineups,
        statistics,
      ];
}

class Venue extends Equatable {
  final int? id;
  final String? name;
  final String? city;
  final String? country;
  final int? capacity;
  final String? image;
  final String? address;
  final String? surface;

  const Venue({
    this.id,
    this.name,
    this.city,
    this.country,
    this.capacity,
    this.image,
    this.address,
    this.surface,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        city,
        country,
        capacity,
        image,
        address,
        surface,
      ];
}

class MatchStatus extends Equatable {
  final String long;
  final String short;
  final int? elapsed;
  final String? secondHalfTime;

  const MatchStatus({
    required this.long,
    required this.short,
    this.elapsed,
    this.secondHalfTime,
  });

  @override
  List<Object?> get props => [long, short, elapsed, secondHalfTime];
}

class Score extends Equatable {
  final GoalsScore? goals;
  final HalfTimeScore? halftime;
  final FullTimeScore? fulltime;
  final ExtraTimeScore? extratime;
  final PenaltyScore? penalty;

  const Score({
    this.goals,
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  int? get homeGoals => goals?.home;
  int? get awayGoals => goals?.away;

  @override
  List<Object?> get props => [
        goals,
        halftime,
        fulltime,
        extratime,
        penalty,
      ];
}

class GoalsScore extends Equatable {
  final int? home;
  final int? away;

  const GoalsScore({this.home, this.away});

  @override
  List<Object?> get props => [home, away];
}

class HalfTimeScore extends Equatable {
  final int? home;
  final int? away;

  const HalfTimeScore({this.home, this.away});

  @override
  List<Object?> get props => [home, away];
}

class FullTimeScore extends Equatable {
  final int? home;
  final int? away;

  const FullTimeScore({this.home, this.away});

  @override
  List<Object?> get props => [home, away];
}

class ExtraTimeScore extends Equatable {
  final int? home;
  final int? away;

  const ExtraTimeScore({this.home, this.away});

  @override
  List<Object?> get props => [home, away];
}

class PenaltyScore extends Equatable {
  final int? home;
  final int? away;

  const PenaltyScore({this.home, this.away});

  @override
  List<Object?> get props => [home, away];
}

class Team extends Equatable {
  final int id;
  final String name;
  final String? logo;
  final bool? winner;
  final String? country;
  final int? founded;
  final String? code;
  final bool? national;
  final String? form;
  final Statistics? statistics;

  const Team({
    required this.id,
    required this.name,
    this.logo,
    this.winner,
    this.country,
    this.founded,
    this.code,
    this.national,
    this.form,
    this.statistics,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        logo,
        winner,
        country,
        founded,
        code,
        national,
        form,
        statistics,
      ];
}

class Statistics extends Equatable {
  final Map<String, dynamic> stats;

  const Statistics({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class League extends Equatable {
  final int id;
  final String name;
  final String? country;
  final String? logo;
  final String? flag;
  final int? season;
  final String? round;
  final String? type;

  const League({
    required this.id,
    required this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
    this.type,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        logo,
        flag,
        season,
        round,
        type,
      ];
}

class LineUp extends Equatable {
  final TeamLineUp? home;
  final TeamLineUp? away;

  const LineUp({this.home, this.away});

  @override
  List<Object?> get props => [home, away];
}

class TeamLineUp extends Equatable {
  final int? id;
  final String? name;
  final String? formation;
  final String? coach;
  final String? coachId;
  final List<Player>? startXI;
  final List<Player>? substitutes;

  const TeamLineUp({
    this.id,
    this.name,
    this.formation,
    this.coach,
    this.coachId,
    this.startXI,
    this.substitutes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        formation,
        coach,
        coachId,
        startXI,
        substitutes,
      ];
}

class Player extends Equatable {
  final int? id;
  final String? name;
  final int? number;
  final String? pos;
  final String? grid;

  const Player({
    this.id,
    this.name,
    this.number,
    this.pos,
    this.grid,
  });

  @override
  List<Object?> get props => [id, name, number, pos, grid];
}

class MatchStatistics extends Equatable {
  final Team team;
  final List<MatchStatistic> statistics;

  const MatchStatistics({
    required this.team,
    required this.statistics,
  });

  @override
  List<Object?> get props => [team, statistics];
}

class MatchStatistic extends Equatable {
  final String type;
  final dynamic value;

  const MatchStatistic({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}
