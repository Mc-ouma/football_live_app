import 'package:football_live_app/domain/entities/match_event.dart';

class MatchEventModel extends MatchEvent {
  const MatchEventModel({
    required int id,
    required int minute,
    int? extraMinute,
    required String type,
    String? detail,
    String? comments,
    required String playerName,
    int? playerId,
    String? assistName,
    int? assistId,
    required int teamId,
  }) : super(
          id: id,
          minute: minute,
          extraMinute: extraMinute,
          type: type,
          detail: detail,
          comments: comments,
          playerName: playerName,
          playerId: playerId,
          assistName: assistName,
          assistId: assistId,
          teamId: teamId,
        );

  factory MatchEventModel.fromJson(Map<String, dynamic> json) {
    return MatchEventModel(
      id: json['id'] ?? 0,
      minute: json['time']?['elapsed'] ?? 0,
      extraMinute: json['time']?['extra'],
      type: json['type'] ?? '',
      detail: json['detail'] ?? '',
      comments: json['comments'],
      playerName: json['player']?['name'] ?? '',
      playerId: json['player']?['id'],
      assistName: json['assist']?['name'],
      assistId: json['assist']?['id'],
      teamId: json['team']?['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': {
        'elapsed': minute,
        'extra': extraMinute,
      },
      'type': type,
      'detail': detail,
      'comments': comments,
      'player': {
        'id': playerId,
        'name': playerName,
      },
      'assist': assistId != null && assistName != null
          ? {
              'id': assistId,
              'name': assistName,
            }
          : null,
      'team': {
        'id': teamId,
      },
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'minute': minute,
      'extra_minute': extraMinute,
      'type': type,
      'detail': detail,
      'comments': comments,
      'player_name': playerName,
      'player_id': playerId,
      'assist_name': assistName,
      'assist_id': assistId,
      'team_id': teamId,
      'match_id': null, // This will be set when saving to database
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
