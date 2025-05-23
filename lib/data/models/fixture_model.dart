import 'package:freezed_annotation/freezed_annotation.dart';
import 'shared_models.dart';

part 'fixture_model.freezed.dart';
part 'fixture_model.g.dart';

/// Root response structure for fixture endpoints
@freezed
class FixtureResponse with _$FixtureResponse {
  const factory FixtureResponse({
    required String get,
    required Map<String, dynamic> parameters,
    required Map<String, dynamic> errors,
    required int results,
    required int paging,
    required List<FixtureData> response,
  }) = _FixtureResponse;

  factory FixtureResponse.fromJson(Map<String, dynamic> json) =>
      _$FixtureResponseFromJson(json);
}

/// Main fixture data model containing all fixture information
@freezed
class FixtureData with _$FixtureData {
  /// Fixture data model with basic information
  const factory FixtureData({
    required Fixture fixture,
    required League league,
    required Teams teams,
    required Goals goals,
    required Score score,
  }) = _FixtureData;

  /// Single Fixture data model with detailed information including events, lineups, statistics, and players
  const factory FixtureData.detailed({
    required Fixture fixture,
    required League league,
    required Teams teams,
    required Goals goals,
    required Score score,
    List<Event>? events,
    List<LineupData>? lineups,
    Statistics? statistics,
    List<PlayerStatistics>? players,
  }) = _FixtureDataDetailed;

  const factory FixtureData.live({
    required Fixture fixture,
    required League league,
    required Teams teams,
    required Goals goals,
    required Score score,
    required List<Event> events,
  }) = _FixtureDataLive;

  factory FixtureData.fromJson(Map<String, dynamic> json) {
    final hasEvents = json['events'] != null && (json['events'] is List);
    final hasLineups = json['lineups'] != null && (json['lineups'] is List);
    final hasStatistics =
        json['statistics'] != null && (json['statistics'] is List);
    final hasPlayers = json['players'] != null && (json['players'] is List);
    final fixture = json['fixture'] as Map<String, dynamic>;
    final status = fixture['status'] as Map<String, dynamic>;
    final isLive =
        status['long'] == 'In Play' ||
        status['short'] == '1H' ||
        status['short'] == '2H' ||
        status['short'] == 'HT' ||
        status['short'] == 'ET' ||
        status['short'] == 'BT' ||
        status['short'] == 'PP' ||
        status['short'] == 'AET' ||
        status['short'] == 'PEN' ||
        status['short'] == 'LIVE' ||
        status['short'] == 'INT' ||
        status['short'] == 'TBD' ||
        status['short'] == 'NS' ||
        status['short'] == 'FT' ||
        status['short'] == 'SUSP' ||
        status['short'] == 'PST' ||
        status['short'] == 'CANC' ||
        status['short'] == 'ABD' ||
        status['short'] == 'AWD' ||
        status['short'] == 'WO';

    if (hasEvents && hasLineups && hasStatistics && hasPlayers) {
      return _$FixtureDataFromJson(json);
    } else if (hasEvents && isLive) {
      return _$FixtureDataFromJson(json);
    } else {
      return _$FixtureDataFromJson(json);
    }
  }
}

/// Match event information (goals, cards, substitutions, etc.)
@freezed
class Event with _$Event {
  const factory Event({
    required Time time,
    required Team team,
    required Player player,
    Player? assist,
    required String type,
    required String detail,
    String? comments,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

/// Time information for events
@freezed
class Time with _$Time {
  const factory Time({required int elapsed, int? extra}) = _Time;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
}

/// Player information
@freezed
class Player with _$Player {
  const factory Player({int? id, required String name}) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

/// Lineup information
@freezed
class LineupData with _$LineupData {
  const factory LineupData({
    required Team team,
    required Coach coach,
    required String formation,
    required List<StartXI> startXI,
    required List<StartXI> substitutes,
  }) = _LineupData;

  factory LineupData.fromJson(Map<String, dynamic> json) =>
      _$LineupDataFromJson(json);
}

/// Coach information
@freezed
class Coach with _$Coach {
  const factory Coach({int? id, required String name, String? photo}) = _Coach;

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
}

/// Player in lineup (starting or substitute)
@freezed
class StartXI with _$StartXI {
  const factory StartXI({required PlayerDetails player}) = _StartXI;

  factory StartXI.fromJson(Map<String, dynamic> json) =>
      _$StartXIFromJson(json);
}

/// Detailed player information used in lineups
@freezed
class PlayerDetails with _$PlayerDetails {
  const factory PlayerDetails({
    required int id,
    required String name,
    int? number,
    String? pos,
    String? grid,
  }) = _PlayerDetails;

  factory PlayerDetails.fromJson(Map<String, dynamic> json) =>
      _$PlayerDetailsFromJson(json);
}

/// Match statistics
@freezed
class Statistics with _$Statistics {
  const factory Statistics({
    List<TeamStatistics>? home,
    List<TeamStatistics>? away,
  }) = _Statistics;

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);
}

/// Team statistics
@freezed
class TeamStatistics with _$TeamStatistics {
  const factory TeamStatistics({required String type, required dynamic value}) =
      _TeamStatistics;

  factory TeamStatistics.fromJson(Map<String, dynamic> json) =>
      _$TeamStatisticsFromJson(json);
}

/// Player statistics
@freezed
class PlayerStatistics with _$PlayerStatistics {
  const factory PlayerStatistics({
    required Team team,
    required List<PlayerStatDetail> players,
  }) = _PlayerStatistics;

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatisticsFromJson(json);
}

/// Individual player statistics
@freezed
class PlayerStatDetail with _$PlayerStatDetail {
  const factory PlayerStatDetail({
    required PlayerDetails player,
    required List<Statistic> statistics,
  }) = _PlayerStatDetail;

  factory PlayerStatDetail.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatDetailFromJson(json);
}

/// Individual statistic for a player
@freezed
class Statistic with _$Statistic {
  const factory Statistic({
    required Map<String, dynamic> games,
    Map<String, dynamic>? offsides,
    Map<String, dynamic>? shots,
    Map<String, dynamic>? goals,
    Map<String, dynamic>? passes,
    Map<String, dynamic>? tackles,
    Map<String, dynamic>? duels,
    Map<String, dynamic>? dribbles,
    Map<String, dynamic>? fouls,
    Map<String, dynamic>? cards,
    Map<String, dynamic>? penalty,
  }) = _Statistic;

  factory Statistic.fromJson(Map<String, dynamic> json) =>
      _$StatisticFromJson(json);
}
