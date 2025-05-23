import 'package:equatable/equatable.dart';

/// Root response structure for fixture endpoints

class FixtureResponse extends Equatable {
  final String get;
  final Map<String, dynamic> parameters;
  final Map<String, dynamic> errors;
  final int results;
  final int paging;
  final List<FixtureData> response;

  const FixtureResponse({
    required this.get,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

  @override
  List<Object?> get props =>
      [get, parameters, errors, results, paging, response];
}

/// Main fixture data model containing all fixture information

class FixtureData extends Equatable {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals goals;
  final Score score;
  final List<Event>? events;
  final List<LineupData>? lineups;
  final Statistics? statistics;
  final List<PlayerStatistics>? players;

  const FixtureData({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
    this.events,
    this.lineups,
    this.statistics,
    this.players,
  });

  @override
  List<Object?> get props => [
        fixture,
        league,
        teams,
        goals,
        score,
        events,
        lineups,
        statistics,
        players
      ];
}

/// Core fixture information

class Fixture extends Equatable {
  final int id;
  final String? referee;
  final String timezone;
  final String date;
  final int timestamp;
  final FixturePeriods periods;
  final FixtureVenue venue;
  final FixtureStatus status;

  const Fixture({
    required this.id,
    this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [id, referee, timezone, date, timestamp, periods, venue, status];
}

/// Information about fixture periods (first/second half)

class FixturePeriods extends Equatable {
  final int? first;
  final int? second;

  const FixturePeriods({
    this.first,
    this.second,
  });

  @override
  List<Object?> get props => [first, second];
}

/// Venue information
class FixtureVenue extends Equatable {
  final int? id;
  final String? name;
  final String? city;

  const FixtureVenue({
    this.id,
    this.name,
    this.city,
  });

  @override
  List<Object?> get props => [id, name, city];
}

/// Fixture status information
class FixtureStatus extends Equatable {
  final String long;
  final String short;
  final int? elapsed;

  const FixtureStatus({
    required this.long,
    required this.short,
    this.elapsed,
  });

  @override
  List<Object?> get props => [long, short, elapsed];
}

/// League information
class League extends Equatable {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String? flag;
  final int season;
  final String? round;

  const League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    this.flag,
    required this.season,
    this.round,
  });

  @override
  List<Object?> get props => [id, name, country, logo, flag, season, round];
}

/// Teams information
class Teams extends Equatable {
  final Team home;
  final Team away;

  const Teams({
    required this.home,
    required this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

/// Team information
class Team extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool? winner;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
    this.winner,
  });

  @override
  List<Object?> get props => [id, name, logo, winner];
}

/// Goals information
class Goals extends Equatable {
  final int? home;
  final int? away;

  const Goals({
    this.home,
    this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

/// Score information including halftime, fulltime, etc.
class Score extends Equatable {
  final Goals halftime;
  final Goals fulltime;
  final Goals? extratime;
  final Goals? penalty;

  const Score({
    required this.halftime,
    required this.fulltime,
    this.extratime,
    this.penalty,
  });

  @override
  List<Object?> get props => [halftime, fulltime, extratime, penalty];
}

/// Match event information (goals, cards, substitutions, etc.)
class Event extends Equatable {
  final Time time;
  final Team team;
  final Player player;
  final Player? assist;
  final String type;
  final String detail;
  final String? comments;

  const Event({
    required this.time,
    required this.team,
    required this.player,
    this.assist,
    required this.type,
    required this.detail,
    this.comments,
  });

  @override
  List<Object?> get props =>
      [time, team, player, assist, type, detail, comments];
}

/// Time information for events
class Time extends Equatable {
  final int elapsed;
  final int? extra;

  const Time({
    required this.elapsed,
    this.extra,
  });

  @override
  List<Object?> get props => [elapsed, extra];
}

/// Player information
class Player extends Equatable {
  final int? id;
  final String name;

  const Player({
    this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

/// Lineup information
class LineupData extends Equatable {
  final Team team;
  final Coach coach;
  final String formation;
  final List<StartXI> startXI;
  final List<StartXI> substitutes;

  const LineupData({
    required this.team,
    required this.coach,
    required this.formation,
    required this.startXI,
    required this.substitutes,
  });

  @override
  List<Object?> get props => [team, coach, formation, startXI, substitutes];
}

/// Coach information
class Coach extends Equatable {
  final int? id;
  final String name;
  final String? photo;

  const Coach({
    this.id,
    required this.name,
    this.photo,
  });

  @override
  List<Object?> get props => [id, name, photo];
}

/// Player in lineup (starting or substitute)

class StartXI extends Equatable {
  final PlayerDetails player;

  const StartXI({
    required this.player,
  });

  @override
  List<Object?> get props => [player];
}

/// Detailed player information used in lineups
class PlayerDetails extends Equatable {
  final int id;
  final String name;
  final int? number;
  final String? pos;
  final String? grid;

  const PlayerDetails({
    required this.id,
    required this.name,
    this.number,
    this.pos,
    this.grid,
  });

  @override
  List<Object?> get props => [id, name, number, pos, grid];
}

/// Match statistics
class Statistics extends Equatable {
  final List<TeamStatistics>? home;
  final List<TeamStatistics>? away;

  const Statistics({
    this.home,
    this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

/// Team statistics
class TeamStatistics extends Equatable {
  final String type;
  final dynamic value;

  const TeamStatistics({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}

/// Player statistics

class PlayerStatistics extends Equatable {
  final Team team;
  final List<PlayerStatDetail> players;

  const PlayerStatistics({
    required this.team,
    required this.players,
  });

  @override
  List<Object?> get props => [team, players];
}

/// Individual player statistics
class PlayerStatDetail extends Equatable {
  final PlayerDetails player;
  final List<Statistic> statistics;

  const PlayerStatDetail({
    required this.player,
    required this.statistics,
  });

  @override
  List<Object?> get props => [player, statistics];
}

/// Individual statistic for a player
class Statistic extends Equatable {
  final Map<String, dynamic> games;
  final Map<String, dynamic>? offsides;
  final Map<String, dynamic>? shots;
  final Map<String, dynamic>? goals;
  final Map<String, dynamic>? passes;
  final Map<String, dynamic>? tackles;
  final Map<String, dynamic>? duels;
  final Map<String, dynamic>? dribbles;
  final Map<String, dynamic>? fouls;
  final Map<String, dynamic>? cards;
  final Map<String, dynamic>? penalty;

  const Statistic({
    required this.games,
    this.offsides,
    this.shots,
    this.goals,
    this.passes,
    this.tackles,
    this.duels,
    this.dribbles,
    this.fouls,
    this.cards,
    this.penalty,
  });

  @override
  List<Object?> get props => [
        games,
        offsides,
        shots,
        goals,
        passes,
        tackles,
        duels,
        dribbles,
        fouls,
        cards,
        penalty
      ];
}
