// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeagueImpl _$$LeagueImplFromJson(Map<String, dynamic> json) => _$LeagueImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      country: json['country'] as String,
      logo: json['logo'] as String,
      flag: json['flag'] as String?,
      season: (json['season'] as num).toInt(),
      round: json['round'] as String?,
    );

Map<String, dynamic> _$$LeagueImplToJson(_$LeagueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'logo': instance.logo,
      'flag': instance.flag,
      'season': instance.season,
      'round': instance.round,
    };

_$TeamsImpl _$$TeamsImplFromJson(Map<String, dynamic> json) => _$TeamsImpl(
      home: Team.fromJson(json['home'] as Map<String, dynamic>),
      away: Team.fromJson(json['away'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TeamsImplToJson(_$TeamsImpl instance) =>
    <String, dynamic>{
      'home': instance.home.toJson(),
      'away': instance.away.toJson(),
    };

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logo: json['logo'] as String,
      winner: json['winner'] as bool?,
      statistics: json['statistics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'winner': instance.winner,
      'statistics': instance.statistics,
    };

_$GoalsImpl _$$GoalsImplFromJson(Map<String, dynamic> json) => _$GoalsImpl(
      home: (json['home'] as num?)?.toInt(),
      away: (json['away'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GoalsImplToJson(_$GoalsImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$ScoreImpl _$$ScoreImplFromJson(Map<String, dynamic> json) => _$ScoreImpl(
      halftime: Goals.fromJson(json['halftime'] as Map<String, dynamic>),
      fulltime: Goals.fromJson(json['fulltime'] as Map<String, dynamic>),
      extratime: json['extratime'] == null
          ? null
          : Goals.fromJson(json['extratime'] as Map<String, dynamic>),
      penalty: json['penalty'] == null
          ? null
          : Goals.fromJson(json['penalty'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ScoreImplToJson(_$ScoreImpl instance) =>
    <String, dynamic>{
      'halftime': instance.halftime.toJson(),
      'fulltime': instance.fulltime.toJson(),
      'extratime': instance.extratime?.toJson(),
      'penalty': instance.penalty?.toJson(),
    };

_$FixtureImpl _$$FixtureImplFromJson(Map<String, dynamic> json) =>
    _$FixtureImpl(
      id: (json['id'] as num).toInt(),
      referee: json['referee'] as String?,
      timezone: json['timezone'] as String,
      date: json['date'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      periods: json['periods'] == null
          ? null
          : FixturePeriods.fromJson(json['periods'] as Map<String, dynamic>),
      venue: FixtureVenue.fromJson(json['venue'] as Map<String, dynamic>),
      status: FixtureStatus.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FixtureImplToJson(_$FixtureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referee': instance.referee,
      'timezone': instance.timezone,
      'date': instance.date,
      'timestamp': instance.timestamp,
      'periods': instance.periods?.toJson(),
      'venue': instance.venue.toJson(),
      'status': instance.status.toJson(),
    };

_$FixturePeriodsImpl _$$FixturePeriodsImplFromJson(Map<String, dynamic> json) =>
    _$FixturePeriodsImpl(
      first: (json['first'] as num?)?.toInt(),
      second: (json['second'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FixturePeriodsImplToJson(
        _$FixturePeriodsImpl instance) =>
    <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
    };

_$FixtureVenueImpl _$$FixtureVenueImplFromJson(Map<String, dynamic> json) =>
    _$FixtureVenueImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$$FixtureVenueImplToJson(_$FixtureVenueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
    };

_$FixtureStatusImpl _$$FixtureStatusImplFromJson(Map<String, dynamic> json) =>
    _$FixtureStatusImpl(
      long: json['long'] as String,
      short: json['short'] as String,
      elapsed: (json['elapsed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FixtureStatusImplToJson(_$FixtureStatusImpl instance) =>
    <String, dynamic>{
      'long': instance.long,
      'short': instance.short,
      'elapsed': instance.elapsed,
    };
