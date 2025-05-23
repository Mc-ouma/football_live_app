import 'package:equatable/equatable.dart';

class MatchEvent extends Equatable {
  final int time;
  final int? extraTime;
  final String type; // 'Goal', 'Card', 'Subst', 'Var', etc.
  final String? detail; // e.g. 'Normal Goal', 'Red Card', etc.
  final String? comments;
  final EventTeam team;
  final EventPlayer? player;
  final EventPlayer? assist;

  const MatchEvent({
    required this.time,
    this.extraTime,
    required this.type,
    this.detail,
    this.comments,
    required this.team,
    this.player,
    this.assist,
  });

  @override
  List<Object?> get props => [
        time,
        extraTime,
        type,
        detail,
        comments,
        team,
        player,
        assist,
      ];
}

class EventTeam extends Equatable {
  final int id;
  final String name;
  final String? logo;

  const EventTeam({
    required this.id,
    required this.name,
    this.logo,
  });

  @override
  List<Object?> get props => [id, name, logo];
}

class EventPlayer extends Equatable {
  final int? id;
  final String? name;

  const EventPlayer({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
