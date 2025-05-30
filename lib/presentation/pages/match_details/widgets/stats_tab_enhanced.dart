import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class StatsTabEnhanced extends StatelessWidget {
  final FixtureData fixture;

  const StatsTabEnhanced({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return const LoadingWidget(message: 'Loading match statistics...');
        }

        // Show error state with retry button
        if (state is FixtureDetailsError) {
          return ErrorDisplayWidget(
            message: 'Failed to load statistics: ${state.message}',
            onRetry: () {
              // Retry loading fixture details using our provider
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            },
          );
        }

        // Get the most complete fixture data available using our utility
        final fixtureToUse =
            FixtureDataProvider.getBestFixtureData(context, fixture);

        // Get statistics data
        final stats = fixtureToUse.getStatistics();

        // If we don't have stats data yet, try requesting it
        if (stats == null && state is! FixtureDetailsLoading) {
          print(
              'No statistics found for match ID: ${fixture.fixture.id}, requesting data...');
          // Use post-frame callback to avoid calling during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            }
          });
        }

        // If we don't have statistics data, show an appropriate placeholder
        if (stats == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.insert_chart_outlined,
                    size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text(
                  'No statistics available for this match',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Statistics are typically available during or after the match',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        // Extract home and away team stats
        final homeStats = stats.home ?? [];
        final awayStats = stats.away ?? [];

        // Get comprehensive match summary from our provider
        final summary = FixtureDataProvider.getMatchSummary(fixtureToUse);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Teams header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(fixtureToUse.teams.home.logo),
                          radius: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          fixtureToUse.teams.home.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'STATS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${summary['homeGoals']} - ${summary['awayGoals']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(fixtureToUse.teams.away.logo),
                          radius: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          fixtureToUse.teams.away.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Team stats cards
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Match Statistics",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Team stats visualizations
                      _buildStatRow(
                          context,
                          "Ball Possession",
                          summary['homePossession'].toString(),
                          summary['awayPossession'].toString()),
                      const Divider(),

                      _buildStatRow(
                          context,
                          "Total Shots",
                          summary['homeShots'].toString(),
                          summary['awayShots'].toString()),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Shots on Goal"),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Corner Kicks"),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Offsides"),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Fouls"),
                      const Divider(),

                      // Yellow and red card indicators
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 15,
                                  height: 20,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${summary['homeYellowCards']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 15,
                                  height: 20,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${summary['homeRedCards']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Cards",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${summary['awayYellowCards']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 15,
                                  height: 20,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  '${summary['awayRedCards']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 15,
                                  height: 20,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Additional stats
              const SizedBox(height: 16),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Advanced Statistics",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // More detailed statistics
                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Passes"),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Passes Accurate"),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Blocked Shots"),
                      const Divider(),

                      _buildStatRowFromTeamStats(
                          context, homeStats, awayStats, "Goalkeeper Saves"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatRow(
      BuildContext context, String title, String homeValue, String awayValue) {
    // Calculate ratio for the progress indicator
    double ratio = 0.5; // Default to 50-50

    if (title == "Ball Possession") {
      // Ball possession is already a percentage
      int homePoss = int.tryParse(homeValue.replaceAll("%", "")) ?? 50;
      int awayPoss = int.tryParse(awayValue.replaceAll("%", "")) ?? 50;
      ratio = homePoss / (homePoss + awayPoss);
    } else {
      // For other stats, calculate the ratio
      int homeNum = int.tryParse(homeValue.replaceAll(",", "")) ?? 0;
      int awayNum = int.tryParse(awayValue.replaceAll(",", "")) ?? 0;

      // Avoid division by zero
      if (homeNum + awayNum > 0) {
        ratio = homeNum / (homeNum + awayNum);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeValue,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                awayValue,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Custom progress indicator for the stat
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: (ratio * 100).round(),
                    child: Container(color: AppTheme.homeTeamColor),
                  ),
                  Flexible(
                    flex: 100 - (ratio * 100).round(),
                    child: Container(color: AppTheme.awayTeamColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRowFromTeamStats(
      BuildContext context,
      List<TeamStatistics> homeStats,
      List<TeamStatistics> awayStats,
      String statType) {
    // Find the stat with the given type in each team's stats
    String homeValue = "0";
    String awayValue = "0";

    for (var stat in homeStats) {
      if (stat.type.toLowerCase() == statType.toLowerCase()) {
        homeValue = stat.value?.toString() ?? "0";
        break;
      }
    }

    for (var stat in awayStats) {
      if (stat.type.toLowerCase() == statType.toLowerCase()) {
        awayValue = stat.value?.toString() ?? "0";
        break;
      }
    }

    // If both values are "0", don't display this stat row
    if (homeValue == "0" && awayValue == "0") {
      return const SizedBox.shrink();
    }

    return _buildStatRow(context, statType, homeValue, awayValue);
  }
}
