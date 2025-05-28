import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';

class LineupTab extends StatelessWidget {
  final FixtureData fixture;

  const LineupTab({Key? key, required this.fixture}) : super(key: key);

  // Helper method to get a position based on index
  String _getPositionByIndex(int index) {
    if (index == 0) return 'GK';
    if (index < 5) return 'DEF';
    if (index < 9) return 'MID';
    return 'FWD';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // In a real implementation, you would extract lineups from the fixture state
        // For now we'll create a mock lineup for demonstration

        // Create example lineups for both teams
        final homeTeam = fixture.teams.home;
        final awayTeam = fixture.teams.away;

        // Mock players for starting XI
        List<StartXI> homeStarters = List.generate(
            11,
            (index) => StartXI(
                    player: PlayerDetails(
                  id: index + 1,
                  name: 'Player ${index + 1}',
                  number: index + 1,
                  pos: _getPositionByIndex(index),
                )));

        List<StartXI> awayStarters = List.generate(
            11,
            (index) => StartXI(
                    player: PlayerDetails(
                  id: index + 100,
                  name: 'Player ${index + 1}',
                  number: index + 1,
                  pos: _getPositionByIndex(index),
                )));

        // Mock substitutes
        List<StartXI> homeSubs = List.generate(
            7,
            (index) => StartXI(
                    player: PlayerDetails(
                  id: index + 12,
                  name: 'Sub ${index + 1}',
                  number: index + 12,
                  pos: 'Sub',
                )));

        List<StartXI> awaySubs = List.generate(
            7,
            (index) => StartXI(
                    player: PlayerDetails(
                  id: index + 112,
                  name: 'Sub ${index + 1}',
                  number: index + 12,
                  pos: 'Sub',
                )));

        // Create mock lineup data
        LineupData homeLineup = LineupData(
            team: homeTeam,
            coach: Coach(id: 1, name: "${homeTeam.name} Coach", photo: ""),
            formation: "4-3-3",
            startXI: homeStarters,
            substitutes: homeSubs);

        LineupData awayLineup = LineupData(
            team: awayTeam,
            coach: Coach(id: 2, name: "${awayTeam.name} Coach", photo: ""),
            formation: "4-4-2",
            startXI: awayStarters,
            substitutes: awaySubs);

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

  // Removed unused method _buildNoLineupView()

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
                  SizedBox(height: 4),
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

          SizedBox(height: 24),

          // Starting XI
          Text(
            'Starting XI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Divider(),

          // Starting XI players from lineup data
          _buildPlayersList(context, lineup.startXI),

          SizedBox(height: 24),

          // Substitutes
          Text(
            'Substitutes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Divider(),

          // Substitute players from lineup data
          _buildPlayersList(context, lineup.substitutes),

          SizedBox(height: 24),

          // Coach
          Text(
            'Coach',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.sports, color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            title: Text(lineup.coach.name),
            subtitle: Text('Coach'),
            dense: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersList(BuildContext context, List<StartXI> players) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index].player;

        // Determine badge color based on position
        final badgeColor = _getPositionColor(player.pos);

        // Adjust item density based on screen size
        final dense = ResponsiveHelper.isMobile(context);

        return Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                player.number?.toString() ?? 'N/A',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: badgeColor,
            ),
            title: Text(
              player.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(player.pos ?? 'Unknown Position'),
            dense: dense,
            trailing: player.grid != null
                ? Text(
                    'Grid: ${player.grid}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  // Helper method to get color based on player position
  Color _getPositionColor(String? position) {
    if (position == null) return Colors.grey;

    switch (position.toUpperCase()) {
      case 'G':
      case 'GK':
        return AppTheme.primaryColor.withOpacity(0.8);
      case 'D':
      case 'DEF':
        return Colors.blue[700]!;
      case 'M':
      case 'MID':
        return Colors.green[700]!;
      case 'F':
      case 'FWD':
      case 'A':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
