// Helper utility to convert between fixture data types
import 'package:football_live_app/data/models/fixture_model.dart';

extension FixtureExtension on FixtureData {
  // Get events from this fixture, regardless of its type
  List<Event> getEvents() {
    return when(
      (fixture, league, teams, goals, score) => <Event>[],
      detailed: (fixture, league, teams, goals, score, events, lineups,
              statistics, players) =>
          events ?? [],
      live: (fixture, league, teams, goals, score, events) => events,
    );
  }

  // Get lineups from this fixture, regardless of its type
  List<LineupData> getLineups() {
    return when(
      (fixture, league, teams, goals, score) => <LineupData>[],
      detailed: (fixture, league, teams, goals, score, events, lineups,
              statistics, players) =>
          lineups ?? [],
      live: (fixture, league, teams, goals, score, events) => <LineupData>[],
    );
  }

  // Get statistics from this fixture, regardless of its type
  Statistics? getStatistics() {
    return when(
      (fixture, league, teams, goals, score) => null,
      detailed: (fixture, league, teams, goals, score, events, lineups,
              statistics, players) =>
          statistics,
      live: (fixture, league, teams, goals, score, events) => null,
    );
  }

  // Get player statistics from this fixture, regardless of its type
  List<PlayerStatistics> getPlayerStats() {
    return when(
      (fixture, league, teams, goals, score) => <PlayerStatistics>[],
      detailed: (fixture, league, teams, goals, score, events, lineups,
              statistics, players) =>
          players ?? [],
      live: (fixture, league, teams, goals, score, events) =>
          <PlayerStatistics>[],
    );
  }

  // Check if this fixture has detailed data
  bool get hasDetailedData {
    final events = getEvents();
    final lineups = getLineups();
    final stats = getStatistics();
    final players = getPlayerStats();

    return events.isNotEmpty ||
        lineups.isNotEmpty ||
        stats != null ||
        players.isNotEmpty;
  }
}
