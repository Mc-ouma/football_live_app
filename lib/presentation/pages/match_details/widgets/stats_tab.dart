import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class StatsTab extends StatelessWidget {
  final FixtureData fixture;

  const StatsTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return LoadingWidget(message: 'Loading match statistics...');
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
        FixtureData fixtureToUse =
            FixtureDataProvider.getBestFixtureData(context, fixture);

        // Check if we have statistics data
        if (!FixtureDataProvider.hasStatisticsData(fixtureToUse)) {
          // If we don't have stats data yet and we're not already loading, try requesting it
          if (state is! FixtureDetailsLoading) {
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.insert_chart_outlined,
                    size: 64, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'No statistics available for this match',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Statistics are typically available during or after the match',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        // Get statistics using the fixture extension
        final stats = fixtureToUse.getStatistics();

        if (stats == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.insert_chart_outlined,
                    size: 64, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'No statistics available for this match',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Statistics are typically available during or after the match',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        // Extract home and away team stats
        final homeStats = stats.home;
        final awayStats = stats.away;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
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
                        SizedBox(height: 8),
                        Text(
                          fixtureToUse.teams.home.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'STATS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${fixtureToUse.goals.home ?? 0} - ${fixtureToUse.goals.away ?? 0}',
                        style: TextStyle(
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
                        SizedBox(height: 8),
                        Text(
                          fixtureToUse.teams.away.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Team stats visualizations
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Ball Possession"),
              Divider(),
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Total Shots"),
              Divider(),
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Shots on Goal"),
              Divider(),
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Corner Kicks"),
              Divider(),
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Fouls"),
              Divider(),
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Yellow Cards"),
              Divider(),
              _buildStatRowFromTeamStats(
                  context, homeStats ?? [], awayStats ?? [], "Red Cards"),
              Divider(),
            ],
          ),
        );
      },
    );
  } // Removed unused _buildStatRowFromData method

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
      int homeNum = int.tryParse(homeValue) ?? 0;
      int awayNum = int.tryParse(awayValue) ?? 0;

      // Avoid division by zero
      if (homeNum + awayNum > 0) {
        ratio = homeNum / (homeNum + awayNum);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeValue,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                awayValue,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
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
                    child: Container(color: AppTheme.primaryColor),
                  ),
                  Flexible(
                    flex: 100 - (ratio * 100).round(),
                    child: Container(color: AppTheme.secondaryColor),
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
      if (stat.type == statType) {
        homeValue = stat.value?.toString() ?? "0";
        break;
      }
    }

    for (var stat in awayStats) {
      if (stat.type == statType) {
        awayValue = stat.value?.toString() ?? "0";
        break;
      }
    }

    // If both values are "0", don't display this stat row
    if (homeValue == "0" && awayValue == "0") {
      return SizedBox.shrink();
    }

    return _buildStatRow(context, statType, homeValue, awayValue);
  }
}
