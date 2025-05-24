// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FixtureResponseImpl _$$FixtureResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FixtureResponseImpl(
      get: json['get'] as String,
      parameters: json['parameters'] as Map<String, dynamic>,
      errors: json['errors'] as Map<String, dynamic>,
      results: (json['results'] as num).toInt(),
      paging: (json['paging'] as num).toInt(),
      response: json['response'] as List<dynamic>,
    );

Map<String, dynamic> _$$FixtureResponseImplToJson(
        _$FixtureResponseImpl instance) =>
    <String, dynamic>{
      'get': instance.get,
      'parameters': instance.parameters,
      'errors': instance.errors,
      'results': instance.results,
      'paging': instance.paging,
      'response': instance.response,
    };

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      time: Time.fromJson(json['time'] as Map<String, dynamic>),
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
      assist: json['assist'] == null
          ? null
          : Player.fromJson(json['assist'] as Map<String, dynamic>),
      type: json['type'] as String,
      detail: json['detail'] as String,
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'time': instance.time.toJson(),
      'team': instance.team.toJson(),
      'player': instance.player.toJson(),
      'assist': instance.assist?.toJson(),
      'type': instance.type,
      'detail': instance.detail,
      'comments': instance.comments,
    };

_$TimeImpl _$$TimeImplFromJson(Map<String, dynamic> json) => _$TimeImpl(
      elapsed: (json['elapsed'] as num).toInt(),
      extra: (json['extra'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TimeImplToJson(_$TimeImpl instance) =>
    <String, dynamic>{
      'elapsed': instance.elapsed,
      'extra': instance.extra,
    };

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$LineupDataImpl _$$LineupDataImplFromJson(Map<String, dynamic> json) =>
    _$LineupDataImpl(
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      coach: Coach.fromJson(json['coach'] as Map<String, dynamic>),
      formation: json['formation'] as String,
      startXI: (json['startXI'] as List<dynamic>)
          .map((e) => StartXI.fromJson(e as Map<String, dynamic>))
          .toList(),
      substitutes: (json['substitutes'] as List<dynamic>)
          .map((e) => StartXI.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LineupDataImplToJson(_$LineupDataImpl instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'coach': instance.coach.toJson(),
      'formation': instance.formation,
      'startXI': instance.startXI.map((e) => e.toJson()).toList(),
      'substitutes': instance.substitutes.map((e) => e.toJson()).toList(),
    };

_$CoachImpl _$$CoachImplFromJson(Map<String, dynamic> json) => _$CoachImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$CoachImplToJson(_$CoachImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
    };

_$StartXIImpl _$$StartXIImplFromJson(Map<String, dynamic> json) =>
    _$StartXIImpl(
      player: PlayerDetails.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StartXIImplToJson(_$StartXIImpl instance) =>
    <String, dynamic>{
      'player': instance.player.toJson(),
    };

_$PlayerDetailsImpl _$$PlayerDetailsImplFromJson(Map<String, dynamic> json) =>
    _$PlayerDetailsImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      number: (json['number'] as num?)?.toInt(),
      pos: json['pos'] as String?,
      grid: json['grid'] as String?,
    );

Map<String, dynamic> _$$PlayerDetailsImplToJson(_$PlayerDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'pos': instance.pos,
      'grid': instance.grid,
    };

_$StatisticsImpl _$$StatisticsImplFromJson(Map<String, dynamic> json) =>
    _$StatisticsImpl(
      home: (json['home'] as List<dynamic>?)
          ?.map((e) => TeamStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
      away: (json['away'] as List<dynamic>?)
          ?.map((e) => TeamStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StatisticsImplToJson(_$StatisticsImpl instance) =>
    <String, dynamic>{
      'home': instance.home?.map((e) => e.toJson()).toList(),
      'away': instance.away?.map((e) => e.toJson()).toList(),
    };

_$TeamStatisticsImpl _$$TeamStatisticsImplFromJson(Map<String, dynamic> json) =>
    _$TeamStatisticsImpl(
      type: json['type'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$$TeamStatisticsImplToJson(
        _$TeamStatisticsImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

_$PlayerStatisticsImpl _$$PlayerStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerStatisticsImpl(
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      players: (json['players'] as List<dynamic>)
          .map((e) => PlayerStatDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlayerStatisticsImplToJson(
        _$PlayerStatisticsImpl instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'players': instance.players.map((e) => e.toJson()).toList(),
    };

_$PlayerStatDetailImpl _$$PlayerStatDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerStatDetailImpl(
      player: PlayerDetails.fromJson(json['player'] as Map<String, dynamic>),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) => Statistic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlayerStatDetailImplToJson(
        _$PlayerStatDetailImpl instance) =>
    <String, dynamic>{
      'player': instance.player.toJson(),
      'statistics': instance.statistics.map((e) => e.toJson()).toList(),
    };

_$StatisticImpl _$$StatisticImplFromJson(Map<String, dynamic> json) =>
    _$StatisticImpl(
      games: json['games'] as Map<String, dynamic>,
      offsides: json['offsides'] as Map<String, dynamic>?,
      shots: json['shots'] as Map<String, dynamic>?,
      goals: json['goals'] as Map<String, dynamic>?,
      passes: json['passes'] as Map<String, dynamic>?,
      tackles: json['tackles'] as Map<String, dynamic>?,
      duels: json['duels'] as Map<String, dynamic>?,
      dribbles: json['dribbles'] as Map<String, dynamic>?,
      fouls: json['fouls'] as Map<String, dynamic>?,
      cards: json['cards'] as Map<String, dynamic>?,
      penalty: json['penalty'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$StatisticImplToJson(_$StatisticImpl instance) =>
    <String, dynamic>{
      'games': instance.games,
      'offsides': instance.offsides,
      'shots': instance.shots,
      'goals': instance.goals,
      'passes': instance.passes,
      'tackles': instance.tackles,
      'duels': instance.duels,
      'dribbles': instance.dribbles,
      'fouls': instance.fouls,
      'cards': instance.cards,
      'penalty': instance.penalty,
    };
