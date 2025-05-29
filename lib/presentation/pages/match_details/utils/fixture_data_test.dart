import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';

/// This is a test file to demonstrate the functionality of the FixtureDataProvider utility
/// It can be used as a reference for how to use the utility in different contexts

class FixtureDataTest {
  /// Test the getBestFixtureData method
  static void testGetBestFixtureData(
      BuildContext context, FixtureData initialFixture) {
    print("\n===== TESTING getBestFixtureData =====");

    final fixtureToUse =
        FixtureDataProvider.getBestFixtureData(context, initialFixture);

    print("Initial Fixture ID: ${initialFixture.fixture.id}");
    print("Used Fixture ID: ${fixtureToUse.fixture.id}");
    print("Is same instance: ${identical(initialFixture, fixtureToUse)}");
    print("Has detailed data: ${fixtureToUse.hasDetailedData}");

    // Check what data is available in the fixture
    print("\nAvailable data:");
    print("Events: ${fixtureToUse.getEvents().length}");
    print("Lineups: ${fixtureToUse.getLineups().length}");
    print("Statistics: ${fixtureToUse.getStatistics() != null}");
    print("Player stats: ${fixtureToUse.getPlayerStats().length}");

    print("===== END TESTING =====\n");
  }

  /// Test the team lineup extraction
  static void testTeamLineupExtraction(FixtureData fixture) {
    print("\n===== TESTING TEAM LINEUP EXTRACTION =====");

    // Get home team lineup
    final homeLineup =
        FixtureDataProvider.getTeamLineup(fixture, fixture.teams.home.id);
    if (homeLineup != null) {
      print("Home team: ${fixture.teams.home.name}");
      print("Formation: ${homeLineup.formation}");
      print("Starting XI: ${homeLineup.startXI.length} players");
      print("Substitutes: ${homeLineup.substitutes.length} players");

      // Print some player details if available
      if (homeLineup.startXI.isNotEmpty) {
        final player = homeLineup.startXI.first.player;
        print(
            "Sample player: ${player.name} (${player.pos ?? 'Unknown position'})");
      }
    } else {
      print(
          "No lineup data available for home team: ${fixture.teams.home.name}");
    }

    // Get away team lineup
    final awayLineup =
        FixtureDataProvider.getTeamLineup(fixture, fixture.teams.away.id);
    if (awayLineup != null) {
      print("\nAway team: ${fixture.teams.away.name}");
      print("Formation: ${awayLineup.formation}");
      print("Starting XI: ${awayLineup.startXI.length} players");
      print("Substitutes: ${awayLineup.substitutes.length} players");

      // Print some player details if available
      if (awayLineup.startXI.isNotEmpty) {
        final player = awayLineup.startXI.first.player;
        print(
            "Sample player: ${player.name} (${player.pos ?? 'Unknown position'})");
      }
    } else {
      print(
          "No lineup data available for away team: ${fixture.teams.away.name}");
    }

    print("===== END TESTING =====\n");
  }

  /// Test event extraction and sorting
  static void testEventExtraction(FixtureData fixture) {
    print("\n===== TESTING EVENT EXTRACTION =====");

    // Get sorted events
    final events = FixtureDataProvider.getSortedEvents(fixture);
    print("Total events: ${events.length}");

    if (events.isNotEmpty) {
      // Group events by type
      final goals =
          events.where((e) => e.type.toLowerCase() == 'goal').toList();
      final cards =
          events.where((e) => e.type.toLowerCase() == 'card').toList();
      final substitutions =
          events.where((e) => e.type.toLowerCase() == 'subst').toList();

      print("Goals: ${goals.length}");
      print("Cards: ${cards.length}");
      print("Substitutions: ${substitutions.length}");

      // Print the first event of each type
      if (goals.isNotEmpty) {
        final goal = goals.first;
        print("\nFirst goal: ${goal.player.name} at ${goal.time.elapsed}'");
        print("Team: ${goal.team.name}");
        print("Detail: ${goal.detail}");
      }

      if (cards.isNotEmpty) {
        final card = cards.first;
        print("\nFirst card: ${card.player.name} at ${card.time.elapsed}'");
        print("Team: ${card.team.name}");
        print("Detail: ${card.detail}");
      }

      if (substitutions.isNotEmpty) {
        final sub = substitutions.first;
        print(
            "\nFirst substitution: ${sub.player.name} at ${sub.time.elapsed}'");
        print("Team: ${sub.team.name}");
        if (sub.assist != null) {
          print(
              "Player in: ${sub.player.name}, Player out: ${sub.assist!.name}");
        }
      }

      // Check event order (should be chronological)
      print("\nEvent chronology check:");
      print(
          "First event: ${events.first.type} at ${events.first.time.elapsed}'");
      print("Last event: ${events.last.type} at ${events.last.time.elapsed}'");

      // Verify events are properly sorted
      bool isSorted = true;
      for (int i = 1; i < events.length; i++) {
        if (events[i].time.elapsed < events[i - 1].time.elapsed) {
          isSorted = false;
          print("WARNING: Events not properly sorted at index $i");
          break;
        }
      }
      print("Events are properly sorted by time: $isSorted");
    }

    print("===== END TESTING =====\n");
  }

  /// Test statistics extraction
  static void testStatisticsExtraction(FixtureData fixture) {
    print("\n===== TESTING STATISTICS EXTRACTION =====");

    // Get statistics
    final statistics = fixture.getStatistics();
    print("Statistics available: ${statistics != null}");

    if (statistics != null) {
      // Check home team statistics
      final homeStats = statistics.home;
      if (homeStats != null && homeStats.isNotEmpty) {
        print(
            "\n${fixture.teams.home.name} statistics (${homeStats.length} categories):");
        for (var stat in homeStats) {
          print("${stat.type}: ${stat.value ?? 'N/A'}");
        }
      } else {
        print("No home team statistics available");
      }

      // Check away team statistics
      final awayStats = statistics.away;
      if (awayStats != null && awayStats.isNotEmpty) {
        print(
            "\n${fixture.teams.away.name} statistics (${awayStats.length} categories):");
        for (var stat in awayStats) {
          print("${stat.type}: ${stat.value ?? 'N/A'}");
        }
      } else {
        print("No away team statistics available");
      }
    }

    print("===== END TESTING =====\n");
  }

  /// Run all tests
  static void runAllTests(BuildContext context, FixtureData fixture) {
    print("\n========== FIXTURE DATA PROVIDER TESTS ==========");
    print("Match: ${fixture.teams.home.name} vs ${fixture.teams.away.name}");
    print("ID: ${fixture.fixture.id}");
    print("================================================\n");

    testGetBestFixtureData(context, fixture);
    testTeamLineupExtraction(fixture);
    testEventExtraction(fixture);
    testStatisticsExtraction(fixture);

    print("\n========== ALL TESTS COMPLETED ==========\n");
  }
}
