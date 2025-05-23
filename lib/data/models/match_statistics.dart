import 'package:football_live_app/domain/entities/fixture.dart';
import 'package:football_live_app/data/models/team_model.dart';

class MatchStatisticsResponseModel {
  final String get;
  final Map<String, String> parameters;
  final List<dynamic> errors;
  final int results;
  final Map<String, dynamic> paging;
  final List<MatchStatisticsModel> response;

  MatchStatisticsResponseModel({
    required this.get,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

  factory MatchStatisticsResponseModel.fromJson(Map<String, dynamic> json) {
    return MatchStatisticsResponseModel(
      get: json['get'] as String,
      parameters: Map<String, String>.from(json['parameters'] as Map),
      errors: json['errors'] as List<dynamic>,
      results: json['results'] as int,
      paging: json['paging'] as Map<String, dynamic>,
      response:
          (json['response'] as List)
              .map((stat) => MatchStatisticsModel.fromJson(stat))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'get': get,
      'parameters': parameters,
      'errors': errors,
      'results': results,
      'paging': paging,
      'response': response.map((stat) => stat.toJson()).toList(),
    };
  }
}

class MatchStatisticsModel extends MatchStatistics {
  const MatchStatisticsModel({required super.team, required super.statistics});

  factory MatchStatisticsModel.fromJson(Map<String, dynamic> json) {
    final teamData = json['team'] as Map<String, dynamic>;
    final statisticsData = json['statistics'] as List<dynamic>;

    return MatchStatisticsModel(
      team: TeamModel.fromJson(teamData),
      statistics:
          statisticsData
              .map((stat) => MatchStatisticModel.fromJson(stat))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team': (team as TeamModel).toJson(),
      'statistics':
          statistics
              .map((stat) => (stat as MatchStatisticModel).toJson())
              .toList(),
    };
  }
}

class MatchStatisticModel extends MatchStatistic {
  const MatchStatisticModel({required super.type, required super.value});

  factory MatchStatisticModel.fromJson(Map<String, dynamic> json) {
    return MatchStatisticModel(
      type: json['type'] as String,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'value': value};
  }
}

//
