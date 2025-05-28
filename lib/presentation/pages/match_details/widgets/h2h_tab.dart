import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class H2HTab extends StatelessWidget {
  final FixtureData fixture;

  const H2HTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Check if we're loading H2H data
        if (state is FixtureDetailsLoading) {
          return LoadingWidget(message: 'Loading head-to-head matches...');
        }

        // Check for errors
        if (state is FixtureDetailsError) {
          return ErrorDisplayWidget(
            message: 'Could not load head-to-head matches',
            onRetry: () {
              context.read<FixtureDetailsBloc>().add(
                    RefreshFixtureDetails(fixture.fixture.id),
                  );
            },
          );
        }

        // In a real app, these fixtures would come from the API
        // For now, we'll just show a demo list with 3 simulated fixtures
        List<Map<String, dynamic>> h2hFixtures = [
          {
            'date': '2024-12-15',
            'league': fixture.league.name,
            'homeTeam': fixture.teams.home.name,
            'awayTeam': fixture.teams.away.name,
            'homeScore': 2,
            'awayScore': 1,
            'homeLogo': fixture.teams.home.logo,
            'awayLogo': fixture.teams.away.logo,
          },
          {
            'date': '2024-05-22',
            'league': fixture.league.name,
            'homeTeam': fixture.teams.away.name,
            'awayTeam': fixture.teams.home.name,
            'homeScore': 1,
            'awayScore': 1,
            'homeLogo': fixture.teams.away.logo,
            'awayLogo': fixture.teams.home.logo,
          },
          {
            'date': '2023-09-08',
            'league': fixture.league.name,
            'homeTeam': fixture.teams.home.name,
            'awayTeam': fixture.teams.away.name,
            'homeScore': 0,
            'awayScore': 3,
            'homeLogo': fixture.teams.home.logo,
            'awayLogo': fixture.teams.away.logo,
          },
        ];

        if (h2hFixtures.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No head-to-head matches found',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }

        // Calculate H2H stats
        int homeTeamWins = 0;
        int draws = 0;
        int awayTeamWins = 0;

        for (var match in h2hFixtures) {
          if (match['homeTeam'] == fixture.teams.home.name) {
            if (match['homeScore'] > match['awayScore']) {
              homeTeamWins++;
            } else if (match['homeScore'] == match['awayScore']) {
              draws++;
            } else {
              awayTeamWins++;
            }
          } else {
            if (match['homeScore'] > match['awayScore']) {
              awayTeamWins++;
            } else if (match['homeScore'] == match['awayScore']) {
              draws++;
            } else {
              homeTeamWins++;
            }
          }
        }

        return Padding(
          padding: ResponsiveHelper.getPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // H2H Stats Card
              _buildH2HStatsCard(context, fixture.teams.home.name,
                  fixture.teams.away.name, homeTeamWins, draws, awayTeamWins),

              SizedBox(height: 24),

              // Section title
              Text(
                'Previous Encounters',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              // List of H2H matches
              Expanded(
                child: ListView.builder(
                  itemCount: h2hFixtures.length,
                  itemBuilder: (context, index) {
                    final match = h2hFixtures[index];
                    return _buildH2HItem(context, match);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildH2HStatsCard(BuildContext context, String homeTeamName,
      String awayTeamName, int homeWins, int draws, int awayWins) {
    final totalMatches = homeWins + draws + awayWins;
    final homeWinPercentage = totalMatches > 0 ? homeWins / totalMatches : 0.0;
    final drawPercentage = totalMatches > 0 ? draws / totalMatches : 0.0;
    final awayWinPercentage = totalMatches > 0 ? awayWins / totalMatches : 0.0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Head-to-Head Record',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            // Stats row
            Row(
              children: [
                // Home team wins
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$homeWins',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.homeTeamColor,
                        ),
                      ),
                      Text(
                        'Wins',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        homeTeamName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Draws
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$draws',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Draws',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Away team wins
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$awayWins',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.awayTeamColor,
                        ),
                      ),
                      Text(
                        'Wins',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        awayTeamName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Visual bar
            Row(
              children: [
                Expanded(
                  flex: (homeWinPercentage * 100).round(),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.homeTeamColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: (drawPercentage * 100).round(),
                  child: Container(
                    height: 8,
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  flex: (awayWinPercentage * 100).round(),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.awayTeamColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            Text(
              'Total matches: $totalMatches',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildH2HItem(BuildContext context, Map<String, dynamic> match) {
    final bool homeTeamWon = match['homeScore'] > match['awayScore'];
    final bool draw = match['homeScore'] == match['awayScore'];

    // Use responsive paddings
    final isSmallScreen = ResponsiveHelper.isMobile(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          children: [
            // Date & League
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  match['date'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Spacer(),
                Text(
                  match['league'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            Divider(height: 16),

            // Teams and score with responsive layout
            Row(
              children: [
                // Home team
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(match['homeLogo']),
                        radius: isSmallScreen ? 14 : 18,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          match['homeTeam'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: homeTeamWon ? AppTheme.homeTeamColor : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Score with animated container
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 10 : 16,
                      vertical: isSmallScreen ? 6 : 8),
                  decoration: BoxDecoration(
                    color: draw ? Colors.grey.shade200 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${match['homeScore']} - ${match['awayScore']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),

                // Away team
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          match['awayTeam'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !homeTeamWon && !draw
                                ? AppTheme.awayTeamColor
                                : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(width: 12),
                      CircleAvatar(
                        backgroundImage: NetworkImage(match['awayLogo']),
                        radius: isSmallScreen ? 14 : 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
