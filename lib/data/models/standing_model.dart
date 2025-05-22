import 'package:football_live_app/data/models/match_model.dart';
import 'package:football_live_app/domain/entities/standing.dart';

class LeagueStandingModel extends LeagueStanding {
  const LeagueStandingModel({
    required LeagueModel league,
    required List<List<StandingModel>> standings,
  }) : super(
          league: league,
          standings: standings,
        );

  factory LeagueStandingModel.fromJson(Map<String, dynamic> json) {
    final leagueData = json['league'] ?? {};
    final List<dynamic> standingsData = leagueData['standings'] ?? [];
    
    final List<List<StandingModel>> standings = [];
    
    for (var standingGroupData in standingsData) {
      final List<StandingModel> standingGroup = [];
      for (var standingData in standingGroupData) {
        standingGroup.add(StandingModel.fromJson(standingData));
      }
      standings.add(standingGroup);
    }
    
    return LeagueStandingModel(
      league: LeagueModel.fromJson(leagueData),
      standings: standings,
    );
  }

  Map<String, dynamic> toJson() {
    final List<List<Map<String, dynamic>>> standingsJson = [];
    
    for (var standingGroup in standings) {
      final List<Map<String, dynamic>> standingGroupJson = [];
      for (var standing in standingGroup) {
        standingGroupJson.add((standing as StandingModel).toJson());
      }
      standingsJson.add(standingGroupJson);
    }
    
    return {
      'league': {
        ...(league as LeagueModel).toJson(),
        'standings': standingsJson,
      },
    };
  }
}

class StandingModel extends Standing {
  const StandingModel({
    required int rank,
    required TeamModel team,
    required int points,
    String? description,
    String? form,
    StandingStatsModel? all,
    StandingStatsModel? home,
    StandingStatsModel? away,
    required int goalsDiff,
    String? group,
    int? update,
  }) : super(
          rank: rank,
          team: team,
          points: points,
          description: description,
          form: form,
          all: all,
          home: home,
          away: away,
          goalsDiff: goalsDiff,
          group: group,
          update: update,
        );

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    return StandingModel(
      rank: json['rank'] ?? 0,
      team: TeamModel.fromJson(json['team'] ?? {}),
      points: json['points'] ?? 0,
      description: json['description'],
      form: json['form'],
      all: json['all'] != null ? StandingStatsModel.fromJson(json['all']) : null,
      home: json['home'] != null ? StandingStatsModel.fromJson(json['home']) : null,
      away: json['away'] != null ? StandingStatsModel.fromJson(json['away']) : null,
      goalsDiff: json['goalsDiff'] ?? 0,
      group: json['group'],
      update: json['update'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'team': (team as TeamModel).toJson(),
      'points': points,
      'description': description,
      'form': form,
      'all': all != null ? (all as StandingStatsModel).toJson() : null,
      'home': home != null ? (home as StandingStatsModel).toJson() : null,
      'away': away != null ? (away as StandingStatsModel).toJson() : null,
      'goalsDiff': goalsDiff,
      'group': group,
      'update': update,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'league_id': 0, // must be set by the caller
      'team_id': (team as TeamModel).id,
      'rank': rank,
      'points': points,
      'form': form,
      'description': description,
      'played': all?.played,
      'win': all?.win,
      'draw': all?.draw,
      'lose': all?.lose,
      'goals_for': all?.goals.forGoals,
      'goals_against': all?.goals.against,
      'goal_diff': goalsDiff,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class StandingStatsModel extends StandingStats {
  const StandingStatsModel({
    required int played,
    required int win,
    required int draw,
    required int lose,
    required GoalsModel goals,
  }) : super(
          played: played,
          win: win,
          draw: draw,
          lose: lose,
          goals: goals,
        );

  factory StandingStatsModel.fromJson(Map<String, dynamic> json) {
    return StandingStatsModel(
      played: json['played'] ?? 0,
      win: json['win'] ?? 0,
      draw: json['draw'] ?? 0,
      lose: json['lose'] ?? 0,
      goals: GoalsModel.fromJson(json['goals'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'played': played,
      'win': win,
      'draw': draw,
      'lose': lose,
      'goals': (goals as GoalsModel).toJson(),
    };
  }
}

class GoalsModel extends Goals {
  const GoalsModel({
    int? forGoals,
    int? against,
  }) : super(
          forGoals: forGoals,
          against: against,
        );

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      forGoals: json['for'],
      against: json['against'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'for': forGoals,
      'against': against,
    };
  }
}
