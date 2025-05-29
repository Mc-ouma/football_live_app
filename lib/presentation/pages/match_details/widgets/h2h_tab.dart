import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

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
              // Use our FixtureDataProvider utility to request a refresh
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            },
          );
        }

        // Check if we have H2H data available
        List<FixtureData> h2hFixtures = [];

        if (state is FixtureDetailsLoaded && state.fixtures.length > 1) {
          // The first fixture is the current match, additional fixtures are H2H matches
          h2hFixtures = state.fixtures.sublist(1);
        }

        // If we don't have H2H data, show an appropriate message
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
                SizedBox(height: 8),
                Text(
                  'These teams may not have played against each other before',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Calculate H2H stats based on available fixtures
        int homeTeamWins = 0;
        int draws = 0;
        int awayTeamWins = 0;

        for (var match in h2hFixtures) {
          if (match.goals.home == null || match.goals.away == null) continue;

          bool isHomeTeamActuallyHome =
              match.teams.home.id == fixture.teams.home.id;

          if (match.goals.home! > match.goals.away!) {
            if (isHomeTeamActuallyHome) {
              homeTeamWins++;
            } else {
              awayTeamWins++;
            }
          } else if (match.goals.home == match.goals.away) {
            draws++;
          } else {
            if (isHomeTeamActuallyHome) {
              awayTeamWins++;
            } else {
              homeTeamWins++;
            }
          }
        }

        return SingleChildScrollView(
          padding: ResponsiveHelper.getPadding(context),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // H2H overview card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Head-to-Head Overview',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          _buildTeamColumn(
                            context,
                            fixture.teams.home.name,
                            homeTeamWins,
                            fixture.teams.home.logo,
                          ),
                          _buildStatColumn(context, 'Draws', draws),
                          _buildTeamColumn(
                            context,
                            fixture.teams.away.name,
                            awayTeamWins,
                            fixture.teams.away.logo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Previous matches list
              Text(
                'Previous Encounters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),

              ...h2hFixtures
                  .map((match) => _buildMatchCard(context, match))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamColumn(
      BuildContext context, String name, int wins, String logo) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(logo),
            radius: 24,
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$wins ${wins == 1 ? 'win' : 'wins'}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String label, int value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, FixtureData match) {
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    String dateStr;

    try {
      final date = DateTime.parse(match.fixture.date);
      dateStr = formatter.format(date);
    } catch (e) {
      dateStr = 'Unknown date';
    }

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateStr,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  match.league.name,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(match.teams.home.logo),
                        radius: 16,
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          match.teams.home.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: match.teams.home.winner == true
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${match.goals.home ?? '-'} - ${match.goals.away ?? '-'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          match.teams.away.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: match.teams.away.winner == true
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundImage: NetworkImage(match.teams.away.logo),
                        radius: 16,
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
