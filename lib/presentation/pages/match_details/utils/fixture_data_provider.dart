import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';

/// A utility class that helps access and manage fixture data across the match details tabs
class FixtureDataProvider {
  /// Gets the most complete fixture data available, combining data from multiple sources
  static FixtureData getBestFixtureData(
      BuildContext context, FixtureData initialFixture) {
    try {
      final state = context.watch<FixtureDetailsBloc>().state;

      // If we have loaded detailed fixture data, use that
      if (state is FixtureDetailsLoaded && state.hasFixtures) {
        final loadedFixture = state.fixture;
        if (loadedFixture != null && loadedFixture.hasDetailedData) {
          print(
              'Using detailed fixture data from API for match ID: ${loadedFixture.fixture.id}');
          return loadedFixture;
        }
      }

      // Otherwise, use the initial fixture data
      print(
          'Using initial fixture data for match ID: ${initialFixture.fixture.id}');
      return initialFixture;
    } catch (e) {
      print('Error in getBestFixtureData: $e');
      return initialFixture; // Fallback to initial fixture on error
    }
  }

  /// Get all events for a fixture, sorted by time
  static List<Event> getSortedEvents(FixtureData fixture) {
    final events = fixture.getEvents();

    // Sort events by time (ascending)
    events.sort((a, b) {
      if (a.time.elapsed == b.time.elapsed) {
        // If elapsed time is the same, use extra time as a tiebreaker
        final aExtra = a.time.extra ?? 0;
        final bExtra = b.time.extra ?? 0;
        return aExtra.compareTo(bExtra);
      }
      return a.time.elapsed.compareTo(b.time.elapsed);
    });

    return events;
  }

  /// Get events filtered by team
  static List<Event> getTeamEvents(FixtureData fixture, int teamId) {
    return getSortedEvents(fixture)
        .where((event) => event.team.id == teamId)
        .toList();
  }

  /// Get lineup for a specific team
  static LineupData? getTeamLineup(FixtureData fixture, int teamId) {
    final lineups = fixture.getLineups();
    if (lineups.isEmpty) return null;

    try {
      return lineups.firstWhere((lineup) => lineup.team.id == teamId);
    } catch (e) {
      return null;
    }
  }

  /// Request fresh fixture data from the API
  static void requestFixtureRefresh(BuildContext context, int fixtureId) {
    try {
      print('Requesting fresh fixture data for match ID: $fixtureId');
      context.read<FixtureDetailsBloc>().add(RefreshFixtureDetails(fixtureId));
    } catch (e) {
      print('Error requesting fixture refresh: $e');
    }
  }

  /// Check if we have lineup data available
  static bool hasLineupData(FixtureData fixture) {
    return fixture.getLineups().isNotEmpty;
  }

  /// Check if we have statistics data available
  static bool hasStatisticsData(FixtureData fixture) {
    return fixture.getStatistics() != null;
  }

  /// Check if we have events data available
  static bool hasEventsData(FixtureData fixture) {
    return fixture.getEvents().isNotEmpty;
  }
}
