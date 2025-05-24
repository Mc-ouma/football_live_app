import 'package:freezed_annotation/freezed_annotation.dart';

part 'leagues_model.freezed.dart';
part 'leagues_model.g.dart';

@freezed
class LeaguesResponse with _$LeaguesResponse {
  const factory LeaguesResponse({
    required String get,
    required Parameters parameters,
    required List<dynamic> errors,
    required int results,
    required Paging paging,
    required List<LeagueData> response,
  }) = _LeaguesResponse;

  factory LeaguesResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaguesResponseFromJson(json);
}

@freezed
class Parameters with _$Parameters {
  const factory Parameters({
    required String id,
    String? name,
    String? country,
    String? code,
    String? season,
    String? team,
    String? type,
    String? current,
    String? search,
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

  factory Paging.fromJson(Map<String, dynamic> json) =>
      _$PagingFromJson(json);
}

@freezed
class LeagueData with _$LeagueData {
  const factory LeagueData({
    required League league,
    required Country country,
    required List<Season> seasons,
  }) = _LeagueData;

  factory LeagueData.fromJson(Map<String, dynamic> json) =>
      _$LeagueDataFromJson(json);
}

@freezed
class League with _$League {
  const factory League({
    required int id,
    required String name,
    required String type,
    required String logo,
  }) = _League;

  factory League.fromJson(Map<String, dynamic> json) =>
      _$LeagueFromJson(json);
}

@freezed
class Country with _$Country {
  const factory Country({
    required String name,
    required String code,
    required String flag,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
class Season with _$Season {
  const factory Season({
    required int year,
    required String start,
    required String end,
    required bool current,
    required Coverage coverage,
  }) = _Season;

  factory Season.fromJson(Map<String, dynamic> json) =>
      _$SeasonFromJson(json);
}

@freezed
class Coverage with _$Coverage {
  const factory Coverage({
    required Fixtures fixtures,
    required bool standings,
    required bool players,
    required bool top_scorers,
    required bool top_assists,
    required bool top_cards,
    required bool injuries,
    required bool predictions,
    required bool odds,
  }) = _Coverage;

  factory Coverage.fromJson(Map<String, dynamic> json) =>
      _$CoverageFromJson(json);
}

@freezed
class Fixtures with _$Fixtures {
  const factory Fixtures({
    required bool events,
    required bool lineups,
    required bool statistics_fixtures,
    required bool statistics_players,
  }) = _Fixtures;

  factory Fixtures.fromJson(Map<String, dynamic> json) =>
      _$FixturesFromJson(json);
}