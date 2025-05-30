import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class LineupTab extends StatelessWidget {
  final FixtureData fixture;

  const LineupTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return LoadingWidget(message: 'Loading lineup data...');
        }

        // Show error state with retry button
        if (state is FixtureDetailsError) {
          return ErrorDisplayWidget(
            message: 'Failed to load lineup data: ${state.message}',
            onRetry: () {
              // Retry loading fixture details
              context.read<FixtureDetailsBloc>().add(
                    RefreshFixtureDetails(fixture.fixture.id),
                  );
            },
          );
        }

        // Get data from loaded fixture if available
        List<LineupData> lineups = [];
        if (state is FixtureDetailsLoaded && state.hasFixtures) {
          final loadedFixture = state.fixture;
          if (loadedFixture != null) {
            // Use the extension method from fixture_converter.dart
            lineups = loadedFixture.getLineups();
          }
        }

        // If we don't have lineup data, show an appropriate placeholder
        if (lineups.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'No lineup data available for this match',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Lineups are typically published closer to match time',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        // Get the home and away teams from the fixture
        final homeTeam = fixture.teams.home;
        final awayTeam = fixture.teams.away;

        // Get the actual lineup data for home and away teams
        final homeLineup = lineups.firstWhere(
          (lineup) => lineup.team.id == homeTeam.id,
          orElse: () => LineupData(
            team: homeTeam,
            coach: Coach(id: 0, name: "Unknown Coach", photo: ""),
            formation: "Unknown",
            startXI: [],
            substitutes: [],
          ),
        );

        final awayLineup = lineups.firstWhere(
          (lineup) => lineup.team.id == awayTeam.id,
          orElse: () => LineupData(
            team: awayTeam,
            coach: Coach(id: 0, name: "Unknown Coach", photo: ""),
            formation: "Unknown",
            startXI: [],
            substitutes: [],
          ),
        );

        // Use DefaultTabController for the team lineups tabs
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: fixture.teams.home.name),
                  Tab(text: fixture.teams.away.name),
                ],
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTeamLineup(context, homeLineup),
                    _buildTeamLineup(context, awayLineup),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamLineup(BuildContext context, LineupData lineup) {
    // Use responsive padding based on screen size
    final padding = ResponsiveHelper.getPadding(context);

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Formation and team info
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(lineup.team.logo),
                radius: 20,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lineup.team.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Formation: ${lineup.formation}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),

          // Coach information
          Card(
            elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Icon(Icons.person, color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coach',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        lineup.coach.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Starting XI
          _buildPlayerSection(context, 'Starting XI', lineup.startXI),

          // Substitutes
          _buildPlayerSection(context, 'Substitutes', lineup.substitutes),
        ],
      ),
    );
  }

  Widget _buildPlayerSection(
      BuildContext context, String title, List<StartXI> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        if (players.isEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No $title data available',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        else
          ...players
              .map((player) => _buildPlayerCard(context, player))
              .toList(),
      ],
    );
  }

  Widget _buildPlayerCard(BuildContext context, StartXI player) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _getPositionColor(player.player.pos),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  player.player.number != null
                      ? '${player.player.number}'
                      : '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                player.player.name,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                player.player.pos ?? '?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPositionColor(String? position) {
    if (position == null) return Colors.grey;

    switch (position.toUpperCase()) {
      case 'G':
      case 'GK':
        return Colors.orange;
      case 'D':
      case 'DF':
      case 'DEF':
        return Colors.blue;
      case 'M':
      case 'MF':
      case 'MID':
        return Colors.green;
      case 'F':
      case 'FW':
      case 'ATT':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
