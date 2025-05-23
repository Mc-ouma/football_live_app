import 'package:football_live_app/data/models/match_statistics.dart';
import 'package:football_live_app/domain/entities/fixture.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/data/models/match_event_model.dart';
import 'package:football_live_app/data/models/prediction_model.dart';

// These models are defined in this file, no need for separate imports
class MatchModel extends Match {
  final PredictionModel? _predictionModel;

  const MatchModel({
    required super.id,
    super.referee,
    required super.timezone,
    required super.date,
    required super.timestamp,
    required super.venue,
    required super.status,
    required super.league,
    required super.homeTeam,
    required super.awayTeam,
    super.score,
    super.events = const [],
    PredictionModel? prediction,
    super.lineups,
    super.statistics,
  }) : _predictionModel = prediction,
       super(prediction: null); // We'll override the getter

  @override
  Prediction? get prediction => _predictionModel?.toEntity();

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    final fixture = json['fixture'] ?? {};
    final league = json['league'] ?? {};
    final teams = json['teams'] ?? {};
    final goals = json['goals'] ?? {};
    final score = json['score'] ?? {};
    final events = json['events'] ?? [];
    final lineups = json['lineups'] ?? [];
    final statistics = json['statistics'] ?? [];
    final predictions = json['predictions'];

    PredictionModel? prediction;
    if (predictions != null && predictions is Map<String, dynamic>) {
      prediction = PredictionModel.fromJson(json);
    }

    LineUpModel? lineupsModel;
    if (lineups.isNotEmpty) {
      lineupsModel = LineUpModel.fromJson(lineups);
    }

    MatchStatisticsModel? statsModel;
    if (statistics.isNotEmpty) {
      statsModel = MatchStatisticsModel.fromJson(statistics);
    }

    return MatchModel(
      id: fixture['id'] ?? 0,
      referee: fixture['referee'],
      timezone: fixture['timezone'] ?? 'UTC',
      date: DateTime.parse(fixture['date'] ?? DateTime.now().toIso8601String()),
      timestamp: fixture['timestamp'] ?? 0,
      venue: VenueModel.fromJson(fixture['venue'] ?? {}),
      status: MatchStatusModel.fromJson(fixture['status'] ?? {}),
      league: LeagueModel.fromJson(league),
      homeTeam: TeamModel.fromJson(teams['home'] ?? {}, isHome: true),
      awayTeam: TeamModel.fromJson(teams['away'] ?? {}, isHome: false),
      score: ScoreModel.fromJson(goals, score),
      events: List<MatchEventModel>.from(
        events.map((e) => MatchEventModel.fromJson(e)),
      ),
      prediction: prediction,
      lineups: lineupsModel,
      statistics: statsModel,
    );
  }

  Map<String, dynamic> toJson() {
    final VenueModel venueModel = venue as VenueModel;
    final MatchStatusModel statusModel = status as MatchStatusModel;
    final LeagueModel leagueModel = league as LeagueModel;
    final TeamModel homeTeamModel = homeTeam as TeamModel;
    final TeamModel awayTeamModel = awayTeam as TeamModel;
    final ScoreModel? scoreModel = score as ScoreModel?;
    final List<MatchEventModel> eventModels =
        events.map((e) => e as MatchEventModel).toList();
    final LineUpModel? lineupModel = lineups as LineUpModel?;
    final MatchStatisticsModel? statsModel =
        statistics as MatchStatisticsModel?;

    return {
      'fixture': {
        'id': id,
        'referee': referee,
        'timezone': timezone,
        'date': date.toIso8601String(),
        'timestamp': timestamp,
        'venue': venueModel.toJson(),
        'status': statusModel.toJson(),
      },
      'league': leagueModel.toJson(),
      'teams': {'home': homeTeamModel.toJson(), 'away': awayTeamModel.toJson()},
      'goals':
          scoreModel?.goals != null
              ? {
                'home': scoreModel?.goals?.home,
                'away': scoreModel?.goals?.away,
              }
              : {'home': null, 'away': null},
      'score': scoreModel?.toJson() ?? {},
      'events': eventModels.map((e) => e.toJson()).toList(),
      'lineups': lineupModel?.toJson() ?? [],
      'statistics': statsModel?.toJson() ?? [],
    };
  }

  factory MatchModel.fromDatabase(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'],
      referee: map['referee'],
      timezone: map['timezone'] ?? 'UTC',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      timestamp: map['timestamp'],
      venue: VenueModel(id: map['venue_id']),
      status: MatchStatusModel(
        long: map['status_long'] ?? '',
        short: map['status_short'] ?? '',
        elapsed: map['status_elapsed'],
        secondHalfTime: map['status_second_half_time'],
      ),
      league: LeagueModel(
        id: map['league_id'],
        name: '', // Needs to be loaded from leagues table
      ),
      homeTeam: TeamModel(
        id: map['home_team_id'],
        name: '', // Needs to be loaded from teams table
      ),
      awayTeam: TeamModel(
        id: map['away_team_id'],
        name: '', // Needs to be loaded from teams table
      ),
      score:
          map['goals_home'] != null || map['goals_away'] != null
              ? ScoreModel(
                goals: GoalsScoreModel(
                  home: map['goals_home'],
                  away: map['goals_away'],
                ),
                halftime:
                    map['score_halftime_home'] != null
                        ? HalfTimeScoreModel(
                          home: map['score_halftime_home'],
                          away: map['score_halftime_away'],
                        )
                        : null,
                fulltime:
                    map['score_fulltime_home'] != null
                        ? FullTimeScoreModel(
                          home: map['score_fulltime_home'],
                          away: map['score_fulltime_away'],
                        )
                        : null,
                extratime:
                    map['score_extratime_home'] != null
                        ? ExtraTimeScoreModel(
                          home: map['score_extratime_home'],
                          away: map['score_extratime_away'],
                        )
                        : null,
                penalty:
                    map['score_penalty_home'] != null
                        ? PenaltyScoreModel(
                          home: map['score_penalty_home'],
                          away: map['score_penalty_away'],
                        )
                        : null,
              )
              : null,
      // Events need to be loaded separately from the events table
      events: const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'referee': referee,
      'timezone': timezone,
      'date': date.millisecondsSinceEpoch,
      'timestamp': timestamp,
      'venue_id': (venue as VenueModel).id,
      'status_long': (status as MatchStatusModel).long,
      'status_short': (status as MatchStatusModel).short,
      'status_elapsed': (status as MatchStatusModel).elapsed,
      'status_second_half_time': (status as MatchStatusModel).secondHalfTime,
      'league_id': (league as LeagueModel).id,
      'home_team_id': (homeTeam as TeamModel).id,
      'away_team_id': (awayTeam as TeamModel).id,
      'goals_home': score?.goals?.home,
      'goals_away': score?.goals?.away,
      'score_halftime_home': (score as ScoreModel?)?.halftime?.home,
      'score_halftime_away': (score as ScoreModel?)?.halftime?.away,
      'score_fulltime_home': (score as ScoreModel?)?.fulltime?.home,
      'score_fulltime_away': (score as ScoreModel?)?.fulltime?.away,
      'score_extratime_home': (score as ScoreModel?)?.extratime?.home,
      'score_extratime_away': (score as ScoreModel?)?.extratime?.away,
      'score_penalty_home': (score as ScoreModel?)?.penalty?.home,
      'score_penalty_away': (score as ScoreModel?)?.penalty?.away,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
      // Events are stored separately in their own table
    };
  }
}

class VenueModel extends Venue {
  const VenueModel({
    int? id,
    String? name,
    String? city,
    String? country,
    int? capacity,
    String? image,
    String? address,
    String? surface,
  }) : super(
         id: id,
         name: name,
         city: city,
         country: country,
         capacity: capacity,
         image: image,
         address: address,
         surface: surface,
       );

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      image: json['image'],
      address: json['address'],
      surface: json['surface'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'country': country,
      'capacity': capacity,
      'image': image,
      'address': address,
      'surface': surface,
    };
  }
}

class MatchStatusModel extends MatchStatus {
  const MatchStatusModel({
    required String long,
    required String short,
    int? elapsed,
    String? secondHalfTime,
  }) : super(
         long: long,
         short: short,
         elapsed: elapsed,
         secondHalfTime: secondHalfTime,
       );

  factory MatchStatusModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusModel(
      long: json['long'] ?? '',
      short: json['short'] ?? '',
      elapsed: json['elapsed'],
      secondHalfTime: json['secondHalfTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long': long,
      'short': short,
      'elapsed': elapsed,
      'secondHalfTime': secondHalfTime,
    };
  }
}

class ScoreModel extends Score {
  const ScoreModel({
    GoalsScoreModel? goals,
    HalfTimeScoreModel? halftime,
    FullTimeScoreModel? fulltime,
    ExtraTimeScoreModel? extratime,
    PenaltyScoreModel? penalty,
  }) : super(
         goals: goals,
         halftime: halftime,
         fulltime: fulltime,
         extratime: extratime,
         penalty: penalty,
       );

  factory ScoreModel.fromJson(
    Map<String, dynamic> goals,
    Map<String, dynamic> score,
  ) {
    return ScoreModel(
      goals: GoalsScoreModel.fromJson(goals),
      halftime:
          score['halftime'] != null
              ? HalfTimeScoreModel.fromJson(score['halftime'])
              : null,
      fulltime:
          score['fulltime'] != null
              ? FullTimeScoreModel.fromJson(score['fulltime'])
              : null,
      extratime:
          score['extratime'] != null
              ? ExtraTimeScoreModel.fromJson(score['extratime'])
              : null,
      penalty:
          score['penalty'] != null
              ? PenaltyScoreModel.fromJson(score['penalty'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final HalfTimeScoreModel? halftimeModel = halftime as HalfTimeScoreModel?;
    final FullTimeScoreModel? fulltimeModel = fulltime as FullTimeScoreModel?;
    final ExtraTimeScoreModel? extratimeModel =
        extratime as ExtraTimeScoreModel?;
    final PenaltyScoreModel? penaltyModel = penalty as PenaltyScoreModel?;

    return {
      'halftime': halftimeModel?.toJson(),
      'fulltime': fulltimeModel?.toJson(),
      'extratime': extratimeModel?.toJson(),
      'penalty': penaltyModel?.toJson(),
    };
  }
}

class GoalsScoreModel extends GoalsScore {
  const GoalsScoreModel({int? home, int? away}) : super(home: home, away: away);

  factory GoalsScoreModel.fromJson(Map<String, dynamic> json) {
    return GoalsScoreModel(home: json['home'], away: json['away']);
  }

  Map<String, dynamic> toJson() {
    return {'home': home, 'away': away};
  }
}

class HalfTimeScoreModel extends HalfTimeScore {
  const HalfTimeScoreModel({int? home, int? away})
    : super(home: home, away: away);

  factory HalfTimeScoreModel.fromJson(Map<String, dynamic> json) {
    return HalfTimeScoreModel(home: json['home'], away: json['away']);
  }

  Map<String, dynamic> toJson() {
    return {'home': home, 'away': away};
  }
}

class FullTimeScoreModel extends FullTimeScore {
  const FullTimeScoreModel({int? home, int? away})
    : super(home: home, away: away);

  factory FullTimeScoreModel.fromJson(Map<String, dynamic> json) {
    return FullTimeScoreModel(home: json['home'], away: json['away']);
  }

  Map<String, dynamic> toJson() {
    return {'home': home, 'away': away};
  }
}

class ExtraTimeScoreModel extends ExtraTimeScore {
  const ExtraTimeScoreModel({int? home, int? away})
    : super(home: home, away: away);

  factory ExtraTimeScoreModel.fromJson(Map<String, dynamic> json) {
    return ExtraTimeScoreModel(home: json['home'], away: json['away']);
  }

  Map<String, dynamic> toJson() {
    return {'home': home, 'away': away};
  }
}

class PenaltyScoreModel extends PenaltyScore {
  const PenaltyScoreModel({int? home, int? away})
    : super(home: home, away: away);

  factory PenaltyScoreModel.fromJson(Map<String, dynamic> json) {
    return PenaltyScoreModel(home: json['home'], away: json['away']);
  }

  Map<String, dynamic> toJson() {
    return {'home': home, 'away': away};
  }
}

class TeamModel extends Team {
  const TeamModel({
    required int id,
    required String name,
    String? logo,
    bool? winner,
    String? country,
    int? founded,
    String? code,
    bool? national,
    String? form,
    StatisticsModel? statistics,
    bool isHome = false,
  }) : super(
         id: id,
         name: name,
         logo: logo,
         winner: winner,
         country: country,
         founded: founded,
         code: code,
         national: national,
         form: form,
         statistics: statistics,
       );

  factory TeamModel.fromJson(Map<String, dynamic> json, {bool isHome = false}) {
    StatisticsModel? statsModel;
    if (json['statistics'] != null) {
      statsModel = StatisticsModel.fromJson(json['statistics']);
    }

    return TeamModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'],
      winner: json['winner'],
      country: json['country'],
      founded: json['founded'],
      code: json['code'],
      national: json['national'],
      form: json['form'],
      statistics: statsModel,
      isHome: isHome,
    );
  }

  Map<String, dynamic> toJson() {
    final StatisticsModel? statsModel = statistics as StatisticsModel?;
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'winner': winner,
      'country': country,
      'founded': founded,
      'code': code,
      'national': national,
      'form': form,
      'statistics': statsModel?.toJson(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'founded': founded,
      'logo': logo,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class StatisticsModel extends Statistics {
  const StatisticsModel({required Map<String, dynamic> stats})
    : super(stats: stats);

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(stats: json);
  }

  Map<String, dynamic> toJson() => stats;
}

class LeagueModel extends League {
  const LeagueModel({
    required int id,
    required String name,
    String? country,
    String? logo,
    String? flag,
    int? season,
    String? round,
    String? type,
  }) : super(
         id: id,
         name: name,
         country: country,
         logo: logo,
         flag: flag,
         season: season,
         round: round,
         type: type,
       );

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'logo': logo,
      'flag': flag,
      'season': season,
      'round': round,
      'type': type,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'logo': logo,
      'flag': flag,
      'season': season,
      'type': type,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class LineUpModel extends LineUp {
  const LineUpModel({TeamLineUpModel? home, TeamLineUpModel? away})
    : super(home: home, away: away);

  factory LineUpModel.fromJson(List<dynamic> json) {
    TeamLineUpModel? homeLineup;
    TeamLineUpModel? awayLineup;

    for (var lineup in json) {
      final teamData = lineup['team'] ?? {};
      final teamId = teamData['id'];
      if (teamId != null) {
        final lineupModel = TeamLineUpModel.fromJson(lineup);
        // First lineup is typically home team, second is away
        if (homeLineup == null) {
          homeLineup = lineupModel;
        } else {
          awayLineup = lineupModel;
        }
      }
    }

    return LineUpModel(home: homeLineup, away: awayLineup);
  }

  Map<String, dynamic> toJson() {
    final TeamLineUpModel? homeModel = home as TeamLineUpModel?;
    final TeamLineUpModel? awayModel = away as TeamLineUpModel?;
    final result = [];

    if (homeModel != null) {
      result.add(homeModel.toJson());
    }

    if (awayModel != null) {
      result.add(awayModel.toJson());
    }

    return {'lineups': result};
  }
}

class TeamLineUpModel extends TeamLineUp {
  const TeamLineUpModel({
    int? id,
    String? name,
    String? formation,
    String? coach,
    String? coachId,
    List<PlayerModel>? startXI,
    List<PlayerModel>? substitutes,
  }) : super(
         id: id,
         name: name,
         formation: formation,
         coach: coach,
         coachId: coachId,
         startXI: startXI,
         substitutes: substitutes,
       );

  factory TeamLineUpModel.fromJson(Map<String, dynamic> json) {
    final team = json['team'] ?? {};
    final coach = json['coach'] ?? {};
    final startXI =
        (json['startXI'] as List?)
            ?.map((p) => PlayerModel.fromJson(p))
            .toList() ??
        [];
    final substitutes =
        (json['substitutes'] as List?)
            ?.map((p) => PlayerModel.fromJson(p))
            .toList() ??
        [];

    return TeamLineUpModel(
      id: team['id'],
      name: team['name'],
      formation: json['formation'],
      coach: coach['name'],
      coachId: coach['id']?.toString(),
      startXI: startXI,
      substitutes: substitutes,
    );
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> startXIJson =
        startXI != null
            ? startXI!.map((p) => (p as PlayerModel).toJson()).toList()
            : [];

    final List<Map<String, dynamic>> subsJson =
        substitutes != null
            ? substitutes!.map((p) => (p as PlayerModel).toJson()).toList()
            : [];

    return {
      'team': {'id': id, 'name': name},
      'formation': formation,
      'coach': {'id': coachId, 'name': coach},
      'startXI': startXIJson,
      'substitutes': subsJson,
    };
  }
}

/* class PlayerModel extends Player {
  const PlayerModel({
    int? id,
    String? name,
    int? number,
    String? pos,
    String? grid,
  }) : super(
          id: id,
          name: name,
          number: number,
          pos: pos,
          grid: grid,
        );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    final player = json['player'] ?? {};
    return PlayerModel(
      id: player['id'],
      name: player['name'],
      number: player['number'],
      pos: player['pos'],
      grid: player['grid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player': {
        'id': id,
        'name': name,
        'number': number,
        'pos': pos,
        'grid': grid,
      }
    };
  }
}
 */
/* class MatchStatisticsModel extends MatchStatistics {
  const MatchStatisticsModel({
    List<MatchStatisticModel>? home,
    List<MatchStatisticModel>? away,
  }) : super(home: home, away: away);

  factory MatchStatisticsModel.fromJson(List<dynamic> json) {
    List<MatchStatisticModel>? homeStats;
    List<MatchStatisticModel>? awayStats;

    for (var stats in json) {
      final team = stats['team'];
      if (team != null) {
        final List<dynamic> teamStats = stats['statistics'] ?? [];
        final statsList =
            teamStats.map((s) => MatchStatisticModel.fromJson(s)).toList();

        // First statistics entry is typically home team, second is away
        if (homeStats == null) {
          homeStats = statsList;
        } else {
          awayStats = statsList;
        }
      }
    }

    return MatchStatisticsModel(
      home: homeStats,
      away: awayStats,
    );
  }

  Map<String, dynamic> toJson() {
    final List<MatchStatisticModel>? homeList =
        home as List<MatchStatisticModel>?;
    final List<MatchStatisticModel>? awayList =
        away as List<MatchStatisticModel>?;
    final result = [];

    if (homeList != null) {
      result.add({
        'team': {
          'id': 0,
          'name': 'Home'
        }, // This would be replaced with actual team data
        'statistics': homeList.map((s) => s.toJson()).toList(),
      });
    }

    if (awayList != null) {
      result.add({
        'team': {
          'id': 0,
          'name': 'Away'
        }, // This would be replaced with actual team data
        'statistics': awayList.map((s) => s.toJson()).toList(),
      });
    }

    return {'statistics': result};
  }
}

 */
