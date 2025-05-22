import 'package:equatable/equatable.dart';
import 'package:football_live_app/domain/entities/match_event.dart';

class Match extends Equatable {
  final int id;
  final String referee;
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

  const Match({
    required this.id,
    required this.referee,
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

  const Venue({
    this.id,
    this.name,
    this.city,
    this.country,
    this.capacity,
    this.image,
    this.address,
  });

  @override
  List<Object?> get props =>
      [id, name, city, country, capacity, image, address];
}

class MatchStatus extends Equatable {
  final String long;
  final String short;
  final int? elapsed;

  const MatchStatus({
    required this.long,
    required this.short,
    this.elapsed,
  });

  @override
  List<Object?> get props => [long, short, elapsed];
}

class Score extends Equatable {
  final int? homeGoals;
  final int? awayGoals;
  final HalfTimeScore? halftime;
  final FullTimeScore? fulltime;
  final ExtraTimeScore? extratime;
  final PenaltyScore? penalty;

  const Score({
    this.homeGoals,
    this.awayGoals,
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  @override
  List<Object?> get props => [
        homeGoals,
        awayGoals,
        halftime,
        fulltime,
        extratime,
        penalty,
      ];
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

  const Team({
    required this.id,
    required this.name,
    this.logo,
    this.winner,
    this.country,
    this.founded,
    this.code,
    this.national,
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
      ];
}

class League extends Equatable {
  final int id;
  final String name;
  final String? country;
  final String? logo;
  final String? flag;
  final int? season;
  final String? round;

  const League({
    required this.id,
    required this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
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
      ];
}
