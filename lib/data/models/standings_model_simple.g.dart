// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standings_model_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingsResponse _$StandingsResponseFromJson(Map<String, dynamic> json) =>
    StandingsResponse(
      get: json['get'] as String,
      parameters:
          Parameters.fromJson(json['parameters'] as Map<String, dynamic>),
      errors: json['errors'] as List<dynamic>,
      results: (json['results'] as num).toInt(),
      paging: Paging.fromJson(json['paging'] as Map<String, dynamic>),
      response: (json['response'] as List<dynamic>)
          .map((e) => LeagueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StandingsResponseToJson(StandingsResponse instance) =>
    <String, dynamic>{
      'get': instance.get,
      'parameters': instance.parameters.toJson(),
      'errors': instance.errors,
      'results': instance.results,
      'paging': instance.paging.toJson(),
      'response': instance.response.map((e) => e.toJson()).toList(),
    };

LeagueResponse _$LeagueResponseFromJson(Map<String, dynamic> json) =>
    LeagueResponse(
      league: League.fromJson(json['league'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeagueResponseToJson(LeagueResponse instance) =>
    <String, dynamic>{
      'league': instance.league.toJson(),
    };

League _$LeagueFromJson(Map<String, dynamic> json) => League(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      country: json['country'] as String,
      logo: json['logo'] as String,
      flag: json['flag'] as String,
      season: (json['season'] as num).toInt(),
      standings: (json['standings'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => Standing.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'logo': instance.logo,
      'flag': instance.flag,
      'season': instance.season,
      'standings': instance.standings
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
    };

Standing _$StandingFromJson(Map<String, dynamic> json) => Standing(
      rank: (json['rank'] as num).toInt(),
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      points: (json['points'] as num).toInt(),
      goalsDiff: (json['goalsDiff'] as num).toInt(),
      group: json['group'] as String,
      form: json['form'] as String,
      status: json['status'] as String,
      description: json['description'] as String,
      all: MatchStats.fromJson(json['all'] as Map<String, dynamic>),
      home: MatchStats.fromJson(json['home'] as Map<String, dynamic>),
      away: MatchStats.fromJson(json['away'] as Map<String, dynamic>),
      update: json['update'] as String,
    );

Map<String, dynamic> _$StandingToJson(Standing instance) => <String, dynamic>{
      'rank': instance.rank,
      'team': instance.team.toJson(),
      'points': instance.points,
      'goalsDiff': instance.goalsDiff,
      'group': instance.group,
      'form': instance.form,
      'status': instance.status,
      'description': instance.description,
      'all': instance.all.toJson(),
      'home': instance.home.toJson(),
      'away': instance.away.toJson(),
      'update': instance.update,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };

MatchStats _$MatchStatsFromJson(Map<String, dynamic> json) => MatchStats(
      played: (json['played'] as num).toInt(),
      win: (json['win'] as num).toInt(),
      draw: (json['draw'] as num).toInt(),
      lose: (json['lose'] as num).toInt(),
      goals: Goals.fromJson(json['goals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchStatsToJson(MatchStats instance) =>
    <String, dynamic>{
      'played': instance.played,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
      'goals': instance.goals.toJson(),
    };

Parameters _$ParametersFromJson(Map<String, dynamic> json) => Parameters(
      league: json['league'] as String,
      season: json['season'] as String,
    );

Map<String, dynamic> _$ParametersToJson(Parameters instance) =>
    <String, dynamic>{
      'league': instance.league,
      'season': instance.season,
    };

Paging _$PagingFromJson(Map<String, dynamic> json) => Paging(
      current: (json['current'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PagingToJson(Paging instance) => <String, dynamic>{
      'current': instance.current,
      'total': instance.total,
    };

Goals _$GoalsFromJson(Map<String, dynamic> json) => Goals(
      forGoals: (json['for'] as num?)?.toInt(),
      against: (json['against'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GoalsToJson(Goals instance) => <String, dynamic>{
      'for': instance.forGoals,
      'against': instance.against,
    };
