import 'package:json_annotation/json_annotation.dart';

part 'standings_model_simple.g.dart';

@JsonSerializable()
class StandingsResponse {
  final String get;
  final Parameters parameters;
  final List<dynamic> errors;
  final int results;
  final Paging paging;
  final List<LeagueResponse> response;

  const StandingsResponse({
    required this.get,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

  factory StandingsResponse.fromJson(Map<String, dynamic> json) =>
      _$StandingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StandingsResponseToJson(this);
}

@JsonSerializable()
class LeagueResponse {
  final League league;

  const LeagueResponse({
    required this.league,
  });

  factory LeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$LeagueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueResponseToJson(this);
}

@JsonSerializable()
class League {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final List<List<Standing>> standings;

  const League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.standings,
  });

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueToJson(this);
}

@JsonSerializable()
class Standing {
  final int rank;
  final Team team;
  final int points;
  final int goalsDiff;
  final String group;
  final String form;
  final String status;
  final String description;
  final MatchStats all;
  final MatchStats home;
  final MatchStats away;
  final String update;

  const Standing({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.status,
    required this.description,
    required this.all,
    required this.home,
    required this.away,
    required this.update,
  });

  factory Standing.fromJson(Map<String, dynamic> json) =>
      _$StandingFromJson(json);

  Map<String, dynamic> toJson() => _$StandingToJson(this);
}

@JsonSerializable()
class Team {
  final int id;
  final String name;
  final String logo;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class MatchStats {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final Goals goals;

  const MatchStats({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  factory MatchStats.fromJson(Map<String, dynamic> json) =>
      _$MatchStatsFromJson(json);

  Map<String, dynamic> toJson() => _$MatchStatsToJson(this);
}

@JsonSerializable()
class Parameters {
  final String league;
  final String season;

  const Parameters({
    required this.league,
    required this.season,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) =>
      _$ParametersFromJson(json);

  Map<String, dynamic> toJson() => _$ParametersToJson(this);
}

@JsonSerializable()
class Paging {
  final int current;
  final int total;

  const Paging({
    required this.current,
    required this.total,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  Map<String, dynamic> toJson() => _$PagingToJson(this);
}

@JsonSerializable()
class Goals {
  @JsonKey(name: 'for')
  final int? forGoals;
  final int? against;

  const Goals({
    required this.forGoals,
    required this.against,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);

  Map<String, dynamic> toJson() => _$GoalsToJson(this);
}
