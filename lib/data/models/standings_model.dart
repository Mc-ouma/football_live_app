import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'standings_model.freezed.dart';
part 'standings_model.g.dart';

@freezed
class StandingsResponse with _$StandingsResponse {
  const factory StandingsResponse({
    required String get,
    required Parameters parameters,
    required List<dynamic> errors,
    required int results,
    required Paging paging,
    required List<LeagueResponse> response,
  }) = _StandingsResponse;

  factory StandingsResponse.fromJson(Map<String, dynamic> json) =>
      _$StandingsResponseFromJson(json);
}

@freezed
class LeagueResponse with _$LeagueResponse {
  const factory LeagueResponse({
    required StandingsLeague league,
  }) = _LeagueResponse;

  factory LeagueResponse.fromJson(Map<String, dynamic> json) =>
      _$LeagueResponseFromJson(json);
}

@freezed
class StandingsLeague with _$StandingsLeague {
  const factory StandingsLeague({
    required int id,
    required String name,
    required String country,
    required String logo,
    required String flag,
    required int season,
    required List<List<Standing>> standings,
  }) = _StandingsLeague;

  factory StandingsLeague.fromJson(Map<String, dynamic> json) =>
      _$StandingsLeagueFromJson(json);
}

@freezed
class Standing with _$Standing {
  const factory Standing({
    required int rank,
    required Team team,
    required int points,
    required int goalsDiff,
    required String group,
    required String form,
    required String status,
    required String description,
    required MatchStats all,
    required MatchStats home,
    required MatchStats away,
    required String update,
  }) = _Standing;

  factory Standing.fromJson(Map<String, dynamic> json) =>
      _$StandingFromJson(json);
}

@freezed
class Team with _$Team {
  const factory Team({
    required int id,
    required String name,
    required String logo,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

@freezed
class MatchStats with _$MatchStats {
  const factory MatchStats({
    required int played,
    required int win,
    required int draw,
    required int lose,
    required Goals goals,
  }) = _MatchStats;

  factory MatchStats.fromJson(Map<String, dynamic> json) =>
      _$MatchStatsFromJson(json);
}

@freezed
class Parameters with _$Parameters {
  const factory Parameters({
    required String league,
    required String season,
  }) = _Parameters;

  factory Parameters.fromJson(Map<String, dynamic> json) =>
      _$ParametersFromJson(json);
}

@freezed
class Paging with _$Paging {
  const factory Paging({
    required int current,
    required int total,
  }) = _Paging;

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
}

// Using a regular class for Goals to avoid annotation issues
class Goals {
  final int? forGoals;
  final int? against;

  const Goals({
    required this.forGoals,
    required this.against,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      forGoals: json['for'] as int?,
      against: json['against'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for': forGoals,
      'against': against,
    };
  }
}
