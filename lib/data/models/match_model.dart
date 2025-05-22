import 'package:football_live_app/domain/entities/match.dart';
import 'package:football_live_app/data/models/match_event_model.dart';

class MatchModel extends Match {
  const MatchModel({
    required int id,
    required String referee,
    required String timezone,
    required DateTime date,
    required int timestamp,
    required VenueModel venue,
    required MatchStatusModel status,
    required LeagueModel league,
    required TeamModel homeTeam,
    required TeamModel awayTeam,
    ScoreModel? score,
    List<MatchEventModel> events = const [],
  }) : super(
          id: id,
          referee: referee,
          timezone: timezone,
          date: date,
          timestamp: timestamp,
          venue: venue,
          status: status,
          league: league,
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          score: score,
          events: events,
        );

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    final fixture = json['fixture'] ?? {};
    final league = json['league'] ?? {};
    final teams = json['teams'] ?? {};
    final goals = json['goals'] ?? {};
    final score = json['score'] ?? {};
    final events = json['events'] ?? [];

    return MatchModel(
      id: fixture['id'] ?? 0,
      referee: fixture['referee'] ?? '',
      timezone: fixture['timezone'] ?? 'UTC',
      date: DateTime.parse(fixture['date'] ?? DateTime.now().toIso8601String()),
      timestamp: fixture['timestamp'] ?? 0,
      venue: VenueModel.fromJson(fixture['venue'] ?? {}),
      status: MatchStatusModel.fromJson(fixture['status'] ?? {}),
      league: LeagueModel.fromJson(league),
      homeTeam: TeamModel.fromJson(teams['home'] ?? {}, isHome: true),
      awayTeam: TeamModel.fromJson(teams['away'] ?? {}, isHome: false),
      score: goals['home'] != null && goals['away'] != null
          ? ScoreModel.fromJson(score, goals)
          : null,
      events: (events as List)
          .map((event) => MatchEventModel.fromJson(event))
          .toList(),
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
      'teams': {
        'home': homeTeamModel.toJson(),
        'away': awayTeamModel.toJson(),
      },
      'goals': scoreModel != null
          ? {'home': scoreModel.homeGoals, 'away': scoreModel.awayGoals}
          : {'home': null, 'away': null},
      'score': scoreModel?.toJson() ?? {},
      'events': eventModels.map((e) => e.toJson()).toList(),
    };
  }

  factory MatchModel.fromDatabase(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'],
      referee: map['referee'] ?? '',
      timezone: map['timezone'] ?? 'UTC',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      timestamp: map['timestamp'],
      venue: VenueModel(id: map['venue_id']),
      status: MatchStatusModel(
        long: map['status_long'] ?? '',
        short: map['status_short'] ?? '',
        elapsed: map['status_elapsed'],
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
      score: map['goals_home'] != null && map['goals_away'] != null
          ? ScoreModel(
              homeGoals: map['goals_home'],
              awayGoals: map['goals_away'],
              halftime: map['score_halftime_home'] != null
                  ? HalfTimeScoreModel(
                      home: map['score_halftime_home'],
                      away: map['score_halftime_away'],
                    )
                  : null,
              fulltime: map['score_fulltime_home'] != null
                  ? FullTimeScoreModel(
                      home: map['score_fulltime_home'],
                      away: map['score_fulltime_away'],
                    )
                  : null,
              extratime: map['score_extratime_home'] != null
                  ? ExtraTimeScoreModel(
                      home: map['score_extratime_home'],
                      away: map['score_extratime_away'],
                    )
                  : null,
              penalty: map['score_penalty_home'] != null
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
      'league_id': (league as LeagueModel).id,
      'home_team_id': (homeTeam as TeamModel).id,
      'away_team_id': (awayTeam as TeamModel).id,
      'goals_home': score?.homeGoals,
      'goals_away': score?.awayGoals,
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
  }) : super(
          id: id,
          name: name,
          city: city,
          country: country,
          capacity: capacity,
          image: image,
          address: address,
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
    };
  }
}

class MatchStatusModel extends MatchStatus {
  const MatchStatusModel({
    required String long,
    required String short,
    int? elapsed,
  }) : super(long: long, short: short, elapsed: elapsed);

  factory MatchStatusModel.fromJson(Map<String, dynamic> json) {
    return MatchStatusModel(
      long: json['long'] ?? '',
      short: json['short'] ?? '',
      elapsed: json['elapsed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long': long,
      'short': short,
      'elapsed': elapsed,
    };
  }
}

class ScoreModel extends Score {
  const ScoreModel({
    int? homeGoals,
    int? awayGoals,
    HalfTimeScoreModel? halftime,
    FullTimeScoreModel? fulltime,
    ExtraTimeScoreModel? extratime,
    PenaltyScoreModel? penalty,
  }) : super(
          homeGoals: homeGoals,
          awayGoals: awayGoals,
          halftime: halftime,
          fulltime: fulltime,
          extratime: extratime,
          penalty: penalty,
        );

  factory ScoreModel.fromJson(
      Map<String, dynamic> score, Map<String, dynamic> goals) {
    return ScoreModel(
      homeGoals: goals['home'],
      awayGoals: goals['away'],
      halftime: score['halftime'] != null
          ? HalfTimeScoreModel.fromJson(score['halftime'])
          : null,
      fulltime: score['fulltime'] != null
          ? FullTimeScoreModel.fromJson(score['fulltime'])
          : null,
      extratime: score['extratime'] != null
          ? ExtraTimeScoreModel.fromJson(score['extratime'])
          : null,
      penalty: score['penalty'] != null
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

class HalfTimeScoreModel extends HalfTimeScore {
  const HalfTimeScoreModel({int? home, int? away})
      : super(home: home, away: away);

  factory HalfTimeScoreModel.fromJson(Map<String, dynamic> json) {
    return HalfTimeScoreModel(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class FullTimeScoreModel extends FullTimeScore {
  const FullTimeScoreModel({int? home, int? away})
      : super(home: home, away: away);

  factory FullTimeScoreModel.fromJson(Map<String, dynamic> json) {
    return FullTimeScoreModel(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class ExtraTimeScoreModel extends ExtraTimeScore {
  const ExtraTimeScoreModel({int? home, int? away})
      : super(home: home, away: away);

  factory ExtraTimeScoreModel.fromJson(Map<String, dynamic> json) {
    return ExtraTimeScoreModel(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
  }
}

class PenaltyScoreModel extends PenaltyScore {
  const PenaltyScoreModel({int? home, int? away})
      : super(home: home, away: away);

  factory PenaltyScoreModel.fromJson(Map<String, dynamic> json) {
    return PenaltyScoreModel(
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
    };
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
        );

  factory TeamModel.fromJson(Map<String, dynamic> json, {bool isHome = false}) {
    return TeamModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'],
      winner: json['winner'],
      country: json['country'],
      founded: json['founded'],
      code: json['code'],
      national: json['national'],
      isHome: isHome,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'winner': winner,
      'country': country,
      'founded': founded,
      'code': code,
      'national': national,
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

class LeagueModel extends League {
  const LeagueModel({
    required int id,
    required String name,
    String? country,
    String? logo,
    String? flag,
    int? season,
    String? round,
  }) : super(
          id: id,
          name: name,
          country: country,
          logo: logo,
          flag: flag,
          season: season,
          round: round,
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
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
