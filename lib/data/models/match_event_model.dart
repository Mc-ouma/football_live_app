// This file has been migrated to use the fixture model.
// The MatchEventModel has been replaced with the Event class from fixture_model.dart
// 
// For backward compatibility, re-export the Event-related classes from fixture_model
export 'package:football_live_app/data/models/fixture_model.dart' show Event, Time, Player;
export 'package:football_live_app/data/models/shared_models.dart' show Team;

// If you need the old MatchEvent entity classes, import them from:
// import 'package:football_live_app/domain/entities/match_event.dart';

// Migration guide:
// - MatchEventModel -> Event (from fixture_model.dart)
// - EventTeamModel -> Team (from shared_models.dart) 
// - EventPlayerModel -> Player (from fixture_model.dart)
// - time/extraTime fields -> Time(elapsed: time, extra: extraTime)
// - fromJson/toJson methods -> Use the generated freezed methods on Event class
