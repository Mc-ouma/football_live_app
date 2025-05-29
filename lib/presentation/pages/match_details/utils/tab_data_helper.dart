import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';

class TabDataHelper {
  /// Loads all required data for match detail tabs
  static void loadAllTabData(BuildContext context, FixtureData fixture) {
    final fixtureId = fixture.fixture.id;
    final leagueId = fixture.league.id;
    final season = fixture.league.season;

    // Load detailed fixture data (for events, lineups, stats tabs)
    context.read<FixtureDetailsBloc>().add(LoadFixtureDetails(fixtureId));

    // Load standings data for table tab
    context.read<StandingsBloc>().add(
          FetchStandingsEvent(
            leagueId: leagueId,
            season: season,
          ),
        );

    // Load prediction data for predictions tab
    context.read<PredictionBloc>().add(
          FetchMatchPredictionEvent(matchId: fixtureId),
        );
  }

  /// Get detailed fixture data by ID - useful when you need to refresh a specific tab
  static void loadFixtureDetailsById(BuildContext context, int fixtureId) {
    context.read<FixtureDetailsBloc>().add(LoadFixtureDetails(fixtureId));
  }

  /// Helper to check if fixture contains the detailed data needed for tabs
  static bool hasRequiredDataForTab(FixtureData fixture, MatchTab tab) {
    switch (tab) {
      case MatchTab.summary:
        // Summary tab can work with basic fixture data
        return true;
      case MatchTab.lineup:
        return fixture.getLineups().isNotEmpty;
      case MatchTab.stats:
        return fixture.getStatistics() != null;
      case MatchTab.events:
        return fixture.getEvents().isNotEmpty;
      case MatchTab.h2h:
        // H2H requires separate API calls, so we assume it's not in the fixture data
        return false;
      case MatchTab.table:
        // Table requires separate league standings API call
        return false;
      case MatchTab.predictions:
        // Predictions require separate API call
        return false;
    }
  }
}

/// Enum representing the different tabs in match details
enum MatchTab {
  summary,
  lineup,
  stats,
  events,
  h2h,
  table,
  predictions,
}
