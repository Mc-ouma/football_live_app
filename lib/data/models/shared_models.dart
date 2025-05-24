import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_models.freezed.dart';
part 'shared_models.g.dart';

/// League information
@freezed
class League with _$League {
  const factory League({
    required int id,
    required String name,
    required String country,
    required String logo,
    String? flag,
    required int season,
    String? round,
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
}

/// Teams information
@freezed
class Teams with _$Teams {
  const factory Teams({required Team home, required Team away}) = _Teams;

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);
}

/// Team information
@freezed
class Team with _$Team {
  const factory Team({
    required int id,
    required String name,
    required String logo,
    bool? winner,
    Map<String, dynamic>? statistics,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

/// Goals information
@freezed
class Goals with _$Goals {
  const factory Goals({int? home, int? away}) = _Goals;

  factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);
}

/// Score information including halftime, fulltime, etc.
@freezed
class Score with _$Score {
  const factory Score({
    required Goals halftime,
    required Goals fulltime,
    Goals? extratime,
    Goals? penalty,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

/// Core fixture information
@freezed
class Fixture with _$Fixture {
  const factory Fixture({
    required int id,
    String? referee,
    required String timezone,
    required String date,
    required int timestamp,
    FixturePeriods? periods,
    required FixtureVenue venue,
    required FixtureStatus status,
  }) = _Fixture;

  factory Fixture.fromJson(Map<String, dynamic> json) =>
      _$FixtureFromJson(json);
}

/// Information about fixture periods (first/second half)
@freezed
class FixturePeriods with _$FixturePeriods {
  const factory FixturePeriods({int? first, int? second}) = _FixturePeriods;

  factory FixturePeriods.fromJson(Map<String, dynamic> json) =>
      _$FixturePeriodsFromJson(json);
}

/// Venue information
@freezed
class FixtureVenue with _$FixtureVenue {
  const factory FixtureVenue({int? id, String? name, String? city}) =
      _FixtureVenue;

  factory FixtureVenue.fromJson(Map<String, dynamic> json) =>
      _$FixtureVenueFromJson(json);
}

/// Fixture status information
@freezed
class FixtureStatus with _$FixtureStatus {
  const factory FixtureStatus({
    required String long,
    required String short,
    int? elapsed,
  }) = _FixtureStatus;

  factory FixtureStatus.fromJson(Map<String, dynamic> json) =>
      _$FixtureStatusFromJson(json);
}
