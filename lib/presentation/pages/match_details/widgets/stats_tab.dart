// filepath: /home/luizzy/Flutter Projects/football_live_app/lib/presentation/pages/match_details/widgets/stats_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';

class StatsTab extends StatelessWidget {
  final FixtureData fixture;

  const StatsTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // For a real app, we would extract statistics from the fixture data
        // But for now we'll use sample data since the model structure may vary

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
                              NetworkImage(fixture.teams.home.logo),
                          radius: 24,
                        ),
                        SizedBox(height: 8),
                        Text(
                          fixture.teams.home.name,
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
                        '${fixture.goals.home ?? 0} - ${fixture.goals.away ?? 0}',
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
                              NetworkImage(fixture.teams.away.logo),
                          radius: 24,
                        ),
                        SizedBox(height: 8),
                        Text(
                          fixture.teams.away.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Team stats visualizations with more match-relevant data
              _buildStatRow(context, "Ball Possession", "62%", "38%"),
              Divider(),
              _buildStatRow(context, "Total Shots", "15", "8"),
              Divider(),
              _buildStatRow(context, "Shots on Goal", "7", "3"),
              Divider(),
              _buildStatRow(context, "Corners", "8", "2"),
              Divider(),
              _buildStatRow(context, "Fouls", "9", "14"),
              Divider(),
              _buildStatRow(context, "Yellow Cards", "1", "3"),
              Divider(),
              _buildStatRow(context, "Red Cards", "0", "1"),
              Divider(),
              _buildStatRow(context, "Offsides", "3", "5"),
              Divider(),
              _buildStatRow(context, "Passes", "598", "372"),
              Divider(),
              _buildStatRow(context, "Pass Accuracy", "91%", "78%"),
              Divider(),
              _buildStatRow(context, "Expected Goals (xG)", "2.3", "0.8"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatRow(BuildContext context, String statName, String homeValue,
      String awayValue) {
    final homeNumValue = int.tryParse(homeValue.replaceAll('%', '')) ?? 0;
    final awayNumValue = int.tryParse(awayValue.replaceAll('%', '')) ?? 0;
    final total = homeNumValue + awayNumValue;
    final homePercentage = total > 0 ? homeNumValue / total : 0.5;

    // Use responsive padding based on screen size
    final verticalPadding = ResponsiveHelper.isMobile(context) ? 8.0 : 12.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            statName,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              // Home value
              Expanded(
                child: Text(
                  homeValue,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Progress bar
              Expanded(
                flex: 2,
                child: _buildStatProgressBar(context, homePercentage),
              ),

              // Away value
              Expanded(
                child: Text(
                  awayValue,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatProgressBar(BuildContext context, double homePercentage) {
    // Get height based on screen size for better visibility on larger screens
    final barHeight = ResponsiveHelper.isMobile(context) ? 8.0 : 10.0;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(barHeight / 2),
      ),
      child: Row(
        children: [
          Expanded(
            flex: (homePercentage * 100).round(),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.homeTeamColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(barHeight / 2),
                  bottomLeft: Radius.circular(barHeight / 2),
                  topRight: homePercentage >= 0.98
                      ? Radius.circular(barHeight / 2)
                      : Radius.zero,
                  bottomRight: homePercentage >= 0.98
                      ? Radius.circular(barHeight / 2)
                      : Radius.zero,
                ),
              ),
            ),
          ),
          Expanded(
            flex: ((1 - homePercentage) * 100).round(),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.awayTeamColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(barHeight / 2),
                  bottomRight: Radius.circular(barHeight / 2),
                  topLeft: homePercentage <= 0.02
                      ? Radius.circular(barHeight / 2)
                      : Radius.zero,
                  bottomLeft: homePercentage <= 0.02
                      ? Radius.circular(barHeight / 2)
                      : Radius.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
