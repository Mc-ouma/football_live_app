import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class LineupTabEnhanced extends StatelessWidget {
  final FixtureData fixture;

  const LineupTabEnhanced({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return const LoadingWidget(message: 'Loading lineup data...');
        }

        // Show error state with retry button
        if (state is FixtureDetailsError) {
          return ErrorDisplayWidget(
            message: 'Failed to load lineup data: ${state.message}',
            onRetry: () {
              // Retry loading fixture details using our provider
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            },
          );
        }

        // Get the most complete fixture data using our utility
        final fixtureToUse =
            FixtureDataProvider.getBestFixtureData(context, fixture);

        // Check if lineup data is available
        if (!FixtureDataProvider.hasLineupData(fixtureToUse) &&
            state is! FixtureDetailsLoading) {
          print(
              'No lineup data found for match ID: ${fixture.fixture.id}, requesting data...');
          // Use post-frame callback to avoid calling during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            }
          });
        }

        // Get lineups using the selected fixture
        List<LineupData> lineups = fixtureToUse.getLineups();

        // If lineups are empty, show a helpful message
        if (lineups.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text(
                  'No lineup data available',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lineups are typically available closer to match time',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => FixtureDataProvider.requestFixtureRefresh(
                      context, fixture.fixture.id),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Check for Updates'),
                ),
              ],
            ),
          );
        }

        // Log the retrieved lineup data for debugging
        print(
            'Retrieved ${lineups.length} lineups for match ID: ${fixtureToUse.fixture.id}');

        if (lineups.isNotEmpty) {
          print('Home team formation: ${lineups[0].formation}');
        }
        if (lineups.length > 1) {
          print('Away team formation: ${lineups[1].formation}');
        }

        // Get the home and away teams from the fixture
        final homeTeam = fixtureToUse.teams.home;
        final awayTeam = fixtureToUse.teams.away;

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
                  Tab(text: homeTeam.name),
                  Tab(text: awayTeam.name),
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
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lineup.team.name,
                    style: const TextStyle(
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
          const SizedBox(height: 12),

          // Coach information
          Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(width: 12),
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
                        style: const TextStyle(
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
          padding: const EdgeInsets.symmetric(vertical: 12),
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
              style: const TextStyle(fontStyle: FontStyle.italic),
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
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                player.player.name,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                player.player.pos ?? '?',
                style: const TextStyle(
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
