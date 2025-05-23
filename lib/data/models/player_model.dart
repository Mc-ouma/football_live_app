import 'package:football_live_app/domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required int id,
    required String name,
    String? firstname,
    String? lastname,
    int? age,
    String? nationality,
    String? height,
    String? weight,
    bool? injured,
    String? photo,
  }) : super(
          id: id,
          name: name,
          firstname: firstname,
          lastname: lastname,
          age: age,
          nationality: nationality,
          height: height,
          weight: weight,
          injured: injured,
          photo: photo,
        );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    // Handle both direct player object and nested player object
    final player = json['player'] ?? json;

    return PlayerModel(
      id: player['id'] ?? 0,
      name: player['name'] ?? '',
      firstname: player['firstname'],
      lastname: player['lastname'],
      age: player['age'],
      nationality: player['nationality'],
      height: player['height'],
      weight: player['weight'],
      injured: player['injured'] == true,
      photo: player['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'nationality': nationality,
      'height': height,
      'weight': weight,
      'injured': injured,
      'photo': photo,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'nationality': nationality,
      'height': height,
      'weight': weight,
      'injured': injured == true ? 1 : 0,
      'photo': photo,
      'team_id': null, // Must be set by caller
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class PlayerStatisticsModel extends PlayerStatistics {
  const PlayerStatisticsModel({
    required PlayerModel player,
    int? teamId,
    int? leagueId,
    int? season,
    PlayerGamesModel? games,
    PlayerGoalsModel? goals,
    PlayerPassesModel? passes,
    PlayerShotsModel? shots,
    PlayerTacklesModel? tackles,
    PlayerDuelsModel? duels,
    PlayerDribblesModel? dribbles,
    PlayerFoulsModel? fouls,
    PlayerCardsModel? cards,
    PlayerPenaltyModel? penalty,
  }) : super(
          player: player,
          teamId: teamId,
          leagueId: leagueId,
          season: season,
          games: games,
          goals: goals,
          passes: passes,
          shots: shots,
          tackles: tackles,
          duels: duels,
          dribbles: dribbles,
          fouls: fouls,
          cards: cards,
          penalty: penalty,
        );

  factory PlayerStatisticsModel.fromJson(Map<String, dynamic> json) {
    // Handle response format where statistics is an array
    final List<dynamic> statistics;

    if (json.containsKey('response')) {
      // Handle API response format from the example:
      // {"get":"players", "response":[{"player":{...}, "statistics":[...]}]}
      final responseData = json['response'];
      if (responseData is List && responseData.isNotEmpty) {
        statistics = responseData[0]['statistics'] ?? [];
      } else {
        statistics = [];
      }
    } else {
      statistics = json['statistics'] ?? [];
    }

    // Take the first statistics entry if available
    final stats = statistics.isNotEmpty ? statistics[0] : {};
    final teamData = stats['team'] ?? {};
    final leagueData = stats['league'] ?? {};

    return PlayerStatisticsModel(
      player: PlayerModel.fromJson(json),
      teamId: teamData['id'],
      leagueId: leagueData['id'],
      season: leagueData['season'],
      games: stats['games'] != null
          ? PlayerGamesModel.fromJson(stats['games'])
          : null,
      goals: stats['goals'] != null
          ? PlayerGoalsModel.fromJson(stats['goals'])
          : null,
      passes: stats['passes'] != null
          ? PlayerPassesModel.fromJson(stats['passes'])
          : null,
      shots: stats['shots'] != null
          ? PlayerShotsModel.fromJson(stats['shots'])
          : null,
      tackles: stats['tackles'] != null
          ? PlayerTacklesModel.fromJson(stats['tackles'])
          : null,
      duels: stats['duels'] != null
          ? PlayerDuelsModel.fromJson(stats['duels'])
          : null,
      dribbles: stats['dribbles'] != null
          ? PlayerDribblesModel.fromJson(stats['dribbles'])
          : null,
      fouls: stats['fouls'] != null
          ? PlayerFoulsModel.fromJson(stats['fouls'])
          : null,
      cards: stats['cards'] != null
          ? PlayerCardsModel.fromJson(stats['cards'])
          : null,
      penalty: stats['penalty'] != null
          ? PlayerPenaltyModel.fromJson(stats['penalty'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player': (player as PlayerModel).toJson(),
      'statistics': [
        {
          'team': {
            'id': teamId,
          },
          'league': {
            'id': leagueId,
            'season': season,
          },
          'games': games != null ? (games as PlayerGamesModel).toJson() : null,
          'goals': goals != null ? (goals as PlayerGoalsModel).toJson() : null,
          'passes':
              passes != null ? (passes as PlayerPassesModel).toJson() : null,
          'shots': shots != null ? (shots as PlayerShotsModel).toJson() : null,
          'tackles':
              tackles != null ? (tackles as PlayerTacklesModel).toJson() : null,
          'duels': duels != null ? (duels as PlayerDuelsModel).toJson() : null,
          'dribbles': dribbles != null
              ? (dribbles as PlayerDribblesModel).toJson()
              : null,
          'fouls': fouls != null ? (fouls as PlayerFoulsModel).toJson() : null,
          'cards': cards != null ? (cards as PlayerCardsModel).toJson() : null,
          'penalty':
              penalty != null ? (penalty as PlayerPenaltyModel).toJson() : null,
        },
      ],
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'player_id': (player as PlayerModel).id,
      'team_id': teamId,
      'league_id': leagueId,
      'season': season,
      'appearances': games?.appearences,
      'lineups': games?.lineups,
      'minutes': games?.minutes,
      'goals': goals?.total,
      'assists': goals?.assists,
      'yellowcards': cards?.yellow,
      'yellowred': cards?.yellowred,
      'redcards': cards?.red,
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class PlayerGamesModel extends PlayerGames {
  PlayerGamesModel({
    int? appearences,
    int? lineups,
    int? minutes,
    int? position,
    double? rating,
    bool? captain,
  }) : super(
          appearences: appearences,
          lineups: lineups,
          minutes: minutes,
          position: position,
          rating:
              rating, // Using the value directly since toInt() is not constant
          captain: captain,
        );

  factory PlayerGamesModel.fromJson(Map<String, dynamic> json) {
    // Parse position as a string rather than a number
    // In the example payload, position is "Attacker" not a number
    int? positionInt;
    if (json['position'] != null) {
      if (json['position'] is int) {
        positionInt = json['position'];
      } else {
        // Handle string position by converting to a code
        final positionStr = json['position'].toString().toLowerCase();
        if (positionStr.contains('attack')) {
          positionInt = 4;
        } else if (positionStr.contains('midfield')) {
          positionInt = 3;
        } else if (positionStr.contains('defend')) {
          positionInt = 2;
        } else if (positionStr.contains('goal') ||
            positionStr.contains('keeper')) {
          positionInt = 1;
        }
      }
    }

    return PlayerGamesModel(
      appearences: json['appearences'],
      lineups: json['lineups'],
      minutes: json['minutes'],
      position: positionInt,
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      captain: json['captain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appearences': appearences,
      'lineups': lineups,
      'minutes': minutes,
      'position': position,
      'rating': rating,
      'captain': captain,
    };
  }
}

class PlayerGoalsModel extends PlayerGoals {
  const PlayerGoalsModel({
    int? total,
    int? conceded,
    int? assists,
    int? saves,
  }) : super(
          total: total,
          conceded: conceded,
          assists: assists,
          saves: saves,
        );

  factory PlayerGoalsModel.fromJson(Map<String, dynamic> json) {
    return PlayerGoalsModel(
      total: json['total'],
      conceded: json['conceded'],
      assists: json['assists'],
      saves: json['saves'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'conceded': conceded,
      'assists': assists,
      'saves': saves,
    };
  }
}

class PlayerPassesModel extends PlayerPasses {
  const PlayerPassesModel({
    int? total,
    int? key,
    int? accuracy,
  }) : super(
          total: total,
          key: key,
          accuracy: accuracy,
        );

  factory PlayerPassesModel.fromJson(Map<String, dynamic> json) {
    return PlayerPassesModel(
      total: json['total'],
      key: json['key'],
      accuracy: json['accuracy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'key': key,
      'accuracy': accuracy,
    };
  }
}

class PlayerShotsModel extends PlayerShots {
  const PlayerShotsModel({
    int? total,
    int? on,
  }) : super(
          total: total,
          on: on,
        );

  factory PlayerShotsModel.fromJson(Map<String, dynamic> json) {
    return PlayerShotsModel(
      total: json['total'],
      on: json['on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'on': on,
    };
  }
}

class PlayerTacklesModel extends PlayerTackles {
  const PlayerTacklesModel({
    int? total,
    int? blocks,
    int? interceptions,
  }) : super(
          total: total,
          blocks: blocks,
          interceptions: interceptions,
        );

  factory PlayerTacklesModel.fromJson(Map<String, dynamic> json) {
    return PlayerTacklesModel(
      total: json['total'],
      blocks: json['blocks'],
      interceptions: json['interceptions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'blocks': blocks,
      'interceptions': interceptions,
    };
  }
}

class PlayerDuelsModel extends PlayerDuels {
  const PlayerDuelsModel({
    int? total,
    int? won,
  }) : super(
          total: total,
          won: won,
        );

  factory PlayerDuelsModel.fromJson(Map<String, dynamic> json) {
    return PlayerDuelsModel(
      total: json['total'],
      won: json['won'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'won': won,
    };
  }
}

class PlayerDribblesModel extends PlayerDribbles {
  const PlayerDribblesModel({
    int? attempts,
    int? success,
    int? past,
  }) : super(
          attempts: attempts,
          success: success,
          past: past,
        );

  factory PlayerDribblesModel.fromJson(Map<String, dynamic> json) {
    return PlayerDribblesModel(
      attempts: json['attempts'],
      success: json['success'],
      past: json['past'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attempts': attempts,
      'success': success,
      'past': past,
    };
  }
}

class PlayerFoulsModel extends PlayerFouls {
  const PlayerFoulsModel({
    int? drawn,
    int? committed,
  }) : super(
          drawn: drawn,
          committed: committed,
        );

  factory PlayerFoulsModel.fromJson(Map<String, dynamic> json) {
    return PlayerFoulsModel(
      drawn: json['drawn'],
      committed: json['committed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drawn': drawn,
      'committed': committed,
    };
  }
}

class PlayerCardsModel extends PlayerCards {
  const PlayerCardsModel({
    int? yellow,
    int? yellowred,
    int? red,
  }) : super(
          yellow: yellow,
          yellowred: yellowred,
          red: red,
        );

  factory PlayerCardsModel.fromJson(Map<String, dynamic> json) {
    return PlayerCardsModel(
      yellow: json['yellow'],
      yellowred: json['yellowred'],
      red: json['red'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'yellow': yellow,
      'yellowred': yellowred,
      'red': red,
    };
  }
}

class PlayerPenaltyModel extends PlayerPenalty {
  const PlayerPenaltyModel({
    int? won,
    int? committed,
    int? scored,
    int? missed,
    int? saved,
  }) : super(
          won: won,
          committed: committed,
          scored: scored,
          missed: missed,
          saved: saved,
        );

  factory PlayerPenaltyModel.fromJson(Map<String, dynamic> json) {
    return PlayerPenaltyModel(
      won: json['won'],
      // API has a typo 'commited' instead of 'committed'
      committed: json['committed'] ?? json['commited'],
      scored: json['scored'],
      missed: json['missed'],
      saved: json['saved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'won': won,
      'committed': committed, // Use the correct spelling in our code
      'scored': scored,
      'missed': missed,
      'saved': saved,
    };
  }
}
