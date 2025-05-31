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
    print(
        '🔍 FixtureDataProvider.getBestFixtureData() called for fixture ID: ${initialFixture.fixture.id}');

    final state = context.watch<FixtureDetailsBloc>().state;
    print('   - Current BLoC state: ${state.runtimeType}');

    // If we have loaded detailed fixture data, use that
    if (state is FixtureDetailsLoaded && state.hasFixtures) {
      final loadedFixture = state.fixture;
      if (loadedFixture != null && loadedFixture.hasDetailedData) {
        print('   - ✅ Using detailed fixture data from BLoC state');
        print(
            '   - Detailed data includes: ${loadedFixture.getEvents().length} events, ${loadedFixture.getLineups().length} lineups, stats: ${loadedFixture.getStatistics() != null}');
        return loadedFixture;
      } else {
        print('   - ⚠️  BLoC has fixture data but no detailed data');
      }
    } else {
      print('   - ⚠️  BLoC state does not contain loaded fixtures');
    }

    // Otherwise, use the initial fixture data
    print('   - 📋 Using initial fixture data (may be limited)');
    print(
        '   - Initial data includes: ${initialFixture.getEvents().length} events, ${initialFixture.getLineups().length} lineups, stats: ${initialFixture.getStatistics() != null}');
    return initialFixture;
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

  // Store last refresh time for each fixture to prevent excessive API calls
  static final Map<int, DateTime> _lastRefreshTimes = {};

  /// Request fresh fixture data from the API
  static void requestFixtureRefresh(BuildContext context, int fixtureId) {
    print(
        '🔄 FixtureDataProvider.requestFixtureRefresh() called for fixture ID: $fixtureId');

    try {
      // Check if we've refreshed this fixture recently (within the last 30 seconds)
      final now = DateTime.now();
      final lastRefresh = _lastRefreshTimes[fixtureId];

      if (lastRefresh != null) {
        final timeSinceLastRefresh = now.difference(lastRefresh);
        if (timeSinceLastRefresh.inSeconds < 30) {
          print(
              '⏰ FixtureDataProvider: Skipping refresh for fixture $fixtureId - last refreshed ${timeSinceLastRefresh.inSeconds}s ago');
          return;
        }
      }

      // Update last refresh time
      _lastRefreshTimes[fixtureId] = now;

      print(
          '📡 FixtureDataProvider: Requesting fresh fixture data for match ID: $fixtureId');
      context.read<FixtureDetailsBloc>().add(RefreshFixtureDetails(fixtureId));

      // Use SchedulerBinding to show snackbar after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Refreshing match data...'),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    } catch (e) {
      print('Error requesting fixture refresh: $e');
      // Use SchedulerBinding to show error snackbar after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to refresh data: $e'),
              backgroundColor: Colors.red[400],
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
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

  /// Get a specific statistic value for a team
  static String getStatValue(FixtureData fixture, int teamId, String statType) {
    final statistics = fixture.getStatistics();
    if (statistics == null) return 'N/A';

    // Determine if we need home or away stats
    final isHome = teamId == fixture.teams.home.id;
    final teamStats = isHome ? statistics.home : statistics.away;

    // If no stats available for the team
    if (teamStats == null || teamStats.isEmpty) return 'N/A';

    // Find the specific stat
    try {
      final stat = teamStats.firstWhere(
        (s) => s.type.toLowerCase() == statType.toLowerCase(),
        orElse: () => TeamStatistics(type: 'Not found', value: 'N/A'),
      );

      // Handle different value types (string, number, null)
      if (stat.value == null) return 'N/A';
      if (stat.value is String) return stat.value as String;
      if (stat.value is num) return (stat.value as num).toString();

      return stat.value.toString();
    } catch (e) {
      print('Error getting stat $statType for team $teamId: $e');
      return 'N/A';
    }
  }

  /// Get goals scored by a team in this fixture
  static int getTeamGoals(FixtureData fixture, int teamId) {
    final isHome = teamId == fixture.teams.home.id;
    final goals = isHome ? fixture.goals.home : fixture.goals.away;
    return goals ?? 0;
  }

  /// Check if the match is already finished
  static bool isMatchFinished(FixtureData fixture) {
    final status = fixture.fixture.status.short.toLowerCase();
    return status == 'ft' || status == 'aet' || status == 'pen';
  }

  /// Check if the match is currently live
  static bool isMatchLive(FixtureData fixture) {
    final status = fixture.fixture.status.short.toLowerCase();
    return status == '1h' ||
        status == '2h' ||
        status == 'ht' ||
        status == 'et' ||
        status == 'p' ||
        status == 'bt';
  }

  /// Get comprehensive match summary with key information
  static Map<String, dynamic> getMatchSummary(FixtureData fixture) {
    final statistics = fixture.getStatistics();

    // Extract key stats
    String homePossession = 'N/A';
    String awayPossession = 'N/A';
    String homeShots = 'N/A';
    String awayShots = 'N/A';

    if (statistics != null) {
      // Get possession stats
      homePossession =
          getStatValue(fixture, fixture.teams.home.id, 'possession');
      awayPossession =
          getStatValue(fixture, fixture.teams.away.id, 'possession');

      // Get shots stats
      homeShots = getStatValue(fixture, fixture.teams.home.id, 'total shots');
      awayShots = getStatValue(fixture, fixture.teams.away.id, 'total shots');
    }

    // Count yellow and red cards
    final events = fixture.getEvents();
    int homeYellowCards = 0;
    int homeRedCards = 0;
    int awayYellowCards = 0;
    int awayRedCards = 0;

    for (final event in events) {
      if (event.type.toLowerCase() == 'card') {
        final isYellow = event.detail.toLowerCase().contains('yellow');
        final isRed = event.detail.toLowerCase().contains('red');

        if (event.team.id == fixture.teams.home.id) {
          if (isYellow) homeYellowCards++;
          if (isRed) homeRedCards++;
        } else if (event.team.id == fixture.teams.away.id) {
          if (isYellow) awayYellowCards++;
          if (isRed) awayRedCards++;
        }
      }
    }

    return {
      'status': fixture.fixture.status,
      'homeTeam': fixture.teams.home,
      'awayTeam': fixture.teams.away,
      'score': '${fixture.goals.home ?? 0} - ${fixture.goals.away ?? 0}',
      'homeGoals': fixture.goals.home ?? 0,
      'awayGoals': fixture.goals.away ?? 0,
      'homePossession': homePossession,
      'awayPossession': awayPossession,
      'homeShots': homeShots,
      'awayShots': awayShots,
      'homeYellowCards': homeYellowCards,
      'homeRedCards': homeRedCards,
      'awayYellowCards': awayYellowCards,
      'awayRedCards': awayRedCards,
      'isFinished': isMatchFinished(fixture),
      'isLive': isMatchLive(fixture),
    };
  }
}
