// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StandingsResponseImpl _$$StandingsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$StandingsResponseImpl(
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

Map<String, dynamic> _$$StandingsResponseImplToJson(
        _$StandingsResponseImpl instance) =>
    <String, dynamic>{
      'get': instance.get,
      'parameters': instance.parameters.toJson(),
      'errors': instance.errors,
      'results': instance.results,
      'paging': instance.paging.toJson(),
      'response': instance.response.map((e) => e.toJson()).toList(),
    };

_$LeagueResponseImpl _$$LeagueResponseImplFromJson(Map<String, dynamic> json) =>
    _$LeagueResponseImpl(
      league: StandingsLeague.fromJson(json['league'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LeagueResponseImplToJson(
        _$LeagueResponseImpl instance) =>
    <String, dynamic>{
      'league': instance.league.toJson(),
    };

_$StandingsLeagueImpl _$$StandingsLeagueImplFromJson(
        Map<String, dynamic> json) =>
    _$StandingsLeagueImpl(
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

Map<String, dynamic> _$$StandingsLeagueImplToJson(
        _$StandingsLeagueImpl instance) =>
    <String, dynamic>{
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

_$StandingImpl _$$StandingImplFromJson(Map<String, dynamic> json) =>
    _$StandingImpl(
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

Map<String, dynamic> _$$StandingImplToJson(_$StandingImpl instance) =>
    <String, dynamic>{
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

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };

_$MatchStatsImpl _$$MatchStatsImplFromJson(Map<String, dynamic> json) =>
    _$MatchStatsImpl(
      played: (json['played'] as num).toInt(),
      win: (json['win'] as num).toInt(),
      draw: (json['draw'] as num).toInt(),
      lose: (json['lose'] as num).toInt(),
      goals: Goals.fromJson(json['goals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MatchStatsImplToJson(_$MatchStatsImpl instance) =>
    <String, dynamic>{
      'played': instance.played,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
      'goals': instance.goals.toJson(),
    };

_$ParametersImpl _$$ParametersImplFromJson(Map<String, dynamic> json) =>
    _$ParametersImpl(
      league: json['league'] as String,
      season: json['season'] as String,
    );

Map<String, dynamic> _$$ParametersImplToJson(_$ParametersImpl instance) =>
    <String, dynamic>{
      'league': instance.league,
      'season': instance.season,
    };

_$PagingImpl _$$PagingImplFromJson(Map<String, dynamic> json) => _$PagingImpl(
      current: (json['current'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$PagingImplToJson(_$PagingImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'total': instance.total,
    };
