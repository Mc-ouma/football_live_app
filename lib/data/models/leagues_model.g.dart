// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leagues_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaguesResponseImpl _$$LeaguesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaguesResponseImpl(
      get: json['get'] as String,
      parameters:
          Parameters.fromJson(json['parameters'] as Map<String, dynamic>),
      errors: json['errors'] as List<dynamic>,
      results: (json['results'] as num).toInt(),
      paging: Paging.fromJson(json['paging'] as Map<String, dynamic>),
      response: (json['response'] as List<dynamic>)
          .map((e) => LeagueData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LeaguesResponseImplToJson(
        _$LeaguesResponseImpl instance) =>
    <String, dynamic>{
      'get': instance.get,
      'parameters': instance.parameters.toJson(),
      'errors': instance.errors,
      'results': instance.results,
      'paging': instance.paging.toJson(),
      'response': instance.response.map((e) => e.toJson()).toList(),
    };

_$ParametersImpl _$$ParametersImplFromJson(Map<String, dynamic> json) =>
    _$ParametersImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      country: json['country'] as String?,
      code: json['code'] as String?,
      season: json['season'] as String?,
      team: json['team'] as String?,
      type: json['type'] as String?,
      current: json['current'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$$ParametersImplToJson(_$ParametersImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'code': instance.code,
      'season': instance.season,
      'team': instance.team,
      'type': instance.type,
      'current': instance.current,
      'search': instance.search,
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

_$LeagueDataImpl _$$LeagueDataImplFromJson(Map<String, dynamic> json) =>
    _$LeagueDataImpl(
      league: League.fromJson(json['league'] as Map<String, dynamic>),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LeagueDataImplToJson(_$LeagueDataImpl instance) =>
    <String, dynamic>{
      'league': instance.league.toJson(),
      'country': instance.country.toJson(),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
    };

_$LeagueImpl _$$LeagueImplFromJson(Map<String, dynamic> json) => _$LeagueImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$$LeagueImplToJson(_$LeagueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'logo': instance.logo,
    };

_$CountryImpl _$$CountryImplFromJson(Map<String, dynamic> json) =>
    _$CountryImpl(
      name: json['name'] as String,
      code: json['code'] as String,
      flag: json['flag'] as String,
    );

Map<String, dynamic> _$$CountryImplToJson(_$CountryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'flag': instance.flag,
    };

_$SeasonImpl _$$SeasonImplFromJson(Map<String, dynamic> json) => _$SeasonImpl(
      year: (json['year'] as num).toInt(),
      start: json['start'] as String,
      end: json['end'] as String,
      current: json['current'] as bool,
      coverage: Coverage.fromJson(json['coverage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SeasonImplToJson(_$SeasonImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'start': instance.start,
      'end': instance.end,
      'current': instance.current,
      'coverage': instance.coverage.toJson(),
    };

_$CoverageImpl _$$CoverageImplFromJson(Map<String, dynamic> json) =>
    _$CoverageImpl(
      fixtures: Fixtures.fromJson(json['fixtures'] as Map<String, dynamic>),
      standings: json['standings'] as bool,
      players: json['players'] as bool,
      top_scorers: json['top_scorers'] as bool,
      top_assists: json['top_assists'] as bool,
      top_cards: json['top_cards'] as bool,
      injuries: json['injuries'] as bool,
      predictions: json['predictions'] as bool,
      odds: json['odds'] as bool,
    );

Map<String, dynamic> _$$CoverageImplToJson(_$CoverageImpl instance) =>
    <String, dynamic>{
      'fixtures': instance.fixtures.toJson(),
      'standings': instance.standings,
      'players': instance.players,
      'top_scorers': instance.top_scorers,
      'top_assists': instance.top_assists,
      'top_cards': instance.top_cards,
      'injuries': instance.injuries,
      'predictions': instance.predictions,
      'odds': instance.odds,
    };

_$FixturesImpl _$$FixturesImplFromJson(Map<String, dynamic> json) =>
    _$FixturesImpl(
      events: json['events'] as bool,
      lineups: json['lineups'] as bool,
      statistics_fixtures: json['statistics_fixtures'] as bool,
      statistics_players: json['statistics_players'] as bool,
    );

Map<String, dynamic> _$$FixturesImplToJson(_$FixturesImpl instance) =>
    <String, dynamic>{
      'events': instance.events,
      'lineups': instance.lineups,
      'statistics_fixtures': instance.statistics_fixtures,
      'statistics_players': instance.statistics_players,
    };
