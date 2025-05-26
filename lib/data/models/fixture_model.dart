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

  factory FixtureResponse.fromJson(Map<String, dynamic> json) {
    try {
      // Handle case where errors could be a List (from API) or a Map (for our model)
      var errorsValue = <String, dynamic>{};
      if (json['errors'] is List<dynamic>) {
        // If API returns a list, convert to a map with indices as keys
        final errorsList = json['errors'] as List<dynamic>;
        for (var i = 0; i < errorsList.length; i++) {
          errorsValue['$i'] = errorsList[i];
        }
      } else if (json['errors'] is Map<String, dynamic>) {
        errorsValue = json['errors'] as Map<String, dynamic>;
      }

      // Handle paging which can be an object or an integer in the API
      int pagingValue;
      if (json['paging'] is Map) {
        // If paging is an object with structure {"current": 1, "total": 1}
        final pagingMap = json['paging'] as Map<String, dynamic>;
        pagingValue = pagingMap.containsKey('current')
            ? (pagingMap['current'] is num
                ? (pagingMap['current'] as num).toInt()
                : 1)
            : 1;
      } else if (json['paging'] is int) {
        pagingValue = json['paging'] as int;
      } else if (json['paging'] is num) {
        pagingValue = (json['paging'] as num).toInt();
      } else {
        // Default value if paging is not in expected format
        pagingValue = 1;
      }

      // Handle parameters
      Map<String, dynamic> parametersValue;
      if (json['parameters'] is Map<String, dynamic>) {
        parametersValue = json['parameters'] as Map<String, dynamic>;
      } else {
        parametersValue = <String, dynamic>{};
      }

      // Carefully process the response list to ensure proper type conversion
      final responseList = json['response'] as List<dynamic>;
      final typedResponseList = responseList
          .map((item) => FixtureData.fromJson(item as Map<String, dynamic>))
          .toList();

      return FixtureResponse(
        get: json['get'] as String,
        parameters: parametersValue,
        errors: errorsValue,
        results: json['results'] is int
            ? json['results'] as int
            : (json['results'] is num ? (json['results'] as num).toInt() : 0),
        paging: pagingValue,
        response: typedResponseList,
      );
    } catch (e) {
      print('Error parsing FixtureResponse: $e');
      // Return a default response with empty data in case of parsing error
      return FixtureResponse(
        get: json['get'] as String? ?? '',
        parameters: <String, dynamic>{},
        errors: <String, dynamic>{'parsing_error': e.toString()},
        results: 0,
        paging: 1,
        response: <FixtureData>[],
      );
    }
  }
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
    // For now, return a basic fixture regardless of the type
    // Once the generated code exists we can use the specific constructors
    return FixtureData(
      fixture: Fixture.fromJson(json['fixture'] as Map<String, dynamic>),
      league: League.fromJson(json['league'] as Map<String, dynamic>),
      teams: Teams.fromJson(json['teams'] as Map<String, dynamic>),
      goals: Goals.fromJson(json['goals'] as Map<String, dynamic>),
      score: Score.fromJson(json['score'] as Map<String, dynamic>),
    );
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
