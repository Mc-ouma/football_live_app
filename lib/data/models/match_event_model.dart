import 'package:football_live_app/domain/entities/match_event.dart';

class MatchEventModel extends MatchEvent {
  const MatchEventModel({
    required int time,
    int? extraTime,
    required String type,
    String? detail,
    String? comments,
    required EventTeam team,
    EventPlayer? player,
    EventPlayer? assist,
  }) : super(
          time: time,
          extraTime: extraTime,
          type: type,
          detail: detail,
          comments: comments,
          team: team,
          player: player,
          assist: assist,
        );

  factory MatchEventModel.fromJson(Map<String, dynamic> json) {
    return MatchEventModel(
      time: json['time']?['elapsed'] ?? 0,
      extraTime: json['time']?['extra'],
      type: json['type'] ?? '',
      detail: json['detail'] ?? '',
      comments: json['comments'],
      team: EventTeamModel.fromJson(json['team'] ?? {}),
      player: json['player'] != null
          ? EventPlayerModel.fromJson(json['player'])
          : null,
      assist: json['assist'] != null
          ? EventPlayerModel.fromJson(json['assist'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final EventTeamModel teamModel = team as EventTeamModel;
    final EventPlayerModel? playerModel = player as EventPlayerModel?;
    final EventPlayerModel? assistModel = assist as EventPlayerModel?;

    return {
      'time': {
        'elapsed': time,
        'extra': extraTime,
      },
      'type': type,
      'detail': detail,
      'comments': comments,
      'team': teamModel.toJson(),
      'player': playerModel?.toJson(),
      'assist': assistModel?.toJson(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'extra_time': extraTime,
      'type': type,
      'detail': detail,
      'comments': comments,
      'team_id': (team as EventTeamModel).id,
      'team_name': (team as EventTeamModel).name,
      'player_id': player?.id,
      'player_name': player?.name,
      'assist_id': assist?.id,
      'assist_name': assist?.name,
      'match_id': null, // This will be set when saving to database
      'last_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class EventTeamModel extends EventTeam {
  const EventTeamModel({
    required int id,
    required String name,
    String? logo,
  }) : super(
          id: id,
          name: name,
          logo: logo,
        );

  factory EventTeamModel.fromJson(Map<String, dynamic> json) {
    return EventTeamModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }
}

class EventPlayerModel extends EventPlayer {
  const EventPlayerModel({
    int? id,
    String? name,
  }) : super(
          id: id,
          name: name,
        );

  factory EventPlayerModel.fromJson(Map<String, dynamic> json) {
    return EventPlayerModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
