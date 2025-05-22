import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int id;
  final String name;
  final String? firstname;
  final String? lastname;
  final int? age;
  final String? nationality;
  final String? height;
  final String? weight;
  final bool? injured;
  final String? photo;

  const Player({
    required this.id,
    required this.name,
    this.firstname,
    this.lastname,
    this.age,
    this.nationality,
    this.height,
    this.weight,
    this.injured,
    this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        firstname,
        lastname,
        age,
        nationality,
        height,
        weight,
        injured,
        photo,
      ];
}

class PlayerStatistics extends Equatable {
  final Player player;
  final int? teamId;
  final int? leagueId;
  final int? season;
  final PlayerGames? games;
  final PlayerGoals? goals;
  final PlayerPasses? passes;
  final PlayerShots? shots;
  final PlayerTackles? tackles;
  final PlayerDuels? duels;
  final PlayerDribbles? dribbles;
  final PlayerFouls? fouls;
  final PlayerCards? cards;
  final PlayerPenalty? penalty;

  const PlayerStatistics({
    required this.player,
    this.teamId,
    this.leagueId,
    this.season,
    this.games,
    this.goals,
    this.passes,
    this.shots,
    this.tackles,
    this.duels,
    this.dribbles,
    this.fouls,
    this.cards,
    this.penalty,
  });

  @override
  List<Object?> get props => [
        player,
        teamId,
        leagueId,
        season,
        games,
        goals,
        passes,
        shots,
        tackles,
        duels,
        dribbles,
        fouls,
        cards,
        penalty,
      ];
}

class PlayerGames extends Equatable {
  final int? appearences;
  final int? lineups;
  final int? minutes;
  final int? position;
  final double? rating; // Using double? to match API response
  final bool? captain;

  const PlayerGames({
    this.appearences,
    this.lineups,
    this.minutes,
    this.position,
    this.rating,
    this.captain,
  });

  @override
  List<Object?> get props => [
        appearences,
        lineups,
        minutes,
        position,
        rating,
        captain,
      ];
}

class PlayerGoals extends Equatable {
  final int? total;
  final int? conceded;
  final int? assists;
  final int? saves;

  const PlayerGoals({
    this.total,
    this.conceded,
    this.assists,
    this.saves,
  });

  @override
  List<Object?> get props => [total, conceded, assists, saves];
}

class PlayerPasses extends Equatable {
  final int? total;
  final int? key;
  final int? accuracy;

  const PlayerPasses({
    this.total,
    this.key,
    this.accuracy,
  });

  @override
  List<Object?> get props => [total, key, accuracy];
}

class PlayerShots extends Equatable {
  final int? total;
  final int? on;

  const PlayerShots({
    this.total,
    this.on,
  });

  @override
  List<Object?> get props => [total, on];
}

class PlayerTackles extends Equatable {
  final int? total;
  final int? blocks;
  final int? interceptions;

  const PlayerTackles({
    this.total,
    this.blocks,
    this.interceptions,
  });

  @override
  List<Object?> get props => [total, blocks, interceptions];
}

class PlayerDuels extends Equatable {
  final int? total;
  final int? won;

  const PlayerDuels({
    this.total,
    this.won,
  });

  @override
  List<Object?> get props => [total, won];
}

class PlayerDribbles extends Equatable {
  final int? attempts;
  final int? success;
  final int? past;

  const PlayerDribbles({
    this.attempts,
    this.success,
    this.past,
  });

  @override
  List<Object?> get props => [attempts, success, past];
}

class PlayerFouls extends Equatable {
  final int? drawn;
  final int? committed;

  const PlayerFouls({
    this.drawn,
    this.committed,
  });

  @override
  List<Object?> get props => [drawn, committed];
}

class PlayerCards extends Equatable {
  final int? yellow;
  final int? yellowred;
  final int? red;

  const PlayerCards({
    this.yellow,
    this.yellowred,
    this.red,
  });

  @override
  List<Object?> get props => [yellow, yellowred, red];
}

class PlayerPenalty extends Equatable {
  final int? won;
  final int? committed;
  final int? scored;
  final int? missed;
  final int? saved;

  const PlayerPenalty({
    this.won,
    this.committed,
    this.scored,
    this.missed,
    this.saved,
  });

  @override
  List<Object?> get props => [won, committed, scored, missed, saved];
}
