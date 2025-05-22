import 'package:equatable/equatable.dart';

class MatchEvent extends Equatable {
  final int id;
  final int minute;
  final int? extraMinute;
  final String type; // 'Goal', 'Card', 'Substitution', etc.
  final String? detail; // e.g. 'Normal Goal', 'Red Card', etc.
  final String? comments;
  final String playerName;
  final int? playerId;
  final String? assistName;
  final int? assistId;
  final int teamId;

  const MatchEvent({
    required this.id,
    required this.minute,
    this.extraMinute,
    required this.type,
    this.detail,
    this.comments,
    required this.playerName,
    this.playerId,
    this.assistName,
    this.assistId,
    required this.teamId,
  });

  @override
  List<Object?> get props => [
        id,
        minute,
        extraMinute,
        type,
        detail,
        comments,
        playerName,
        playerId,
        assistName,
        assistId,
        teamId,
      ];
}
