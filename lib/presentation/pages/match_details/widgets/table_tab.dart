import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart'
    as fixture_model;
import 'package:football_live_app/data/models/standings_model.dart' hide Team;
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class TableTab extends StatelessWidget {
  final fixture_model.FixtureData fixture;

  const TableTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandingsBloc, StandingsState>(
      builder: (context, state) {
        // Check if we're loading table data
        if (state is StandingsLoading) {
          return LoadingWidget(message: 'Loading league table...');
        }

        // Check for errors
        if (state is StandingsError) {
          return ErrorDisplayWidget(
            message: 'Could not load league table: ${state.message}',
            onRetry: () {
              // Refresh the standings data with improved error handling
              try {
                context.read<StandingsBloc>().add(
                      FetchStandingsEvent(
                        leagueId: fixture.league.id,
                        season: fixture.league.season,
                      ),
                    );
              } catch (e) {
                // Log any errors that might occur during retry
                print('Error during standings refresh: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error refreshing table data: $e')),
                );
              }
            },
          );
        }

        // Check for empty state
        if (state is StandingsEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.table_chart_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        // Use real standings data if available, otherwise use mock data
        List<Map<String, dynamic>> leagueTableData;
        StandingsLeague? leagueInfo;

        if (state is StandingsLoaded) {
          leagueTableData = _convertStandingsToTableData(state.standings);
          if (state.standings.isNotEmpty) {
            leagueInfo = state.standings[0].league;
          }
        } else {
          // Fallback to mock data for demonstration
          leagueTableData = _getMockLeagueTable();
        }

        // Create a default league info if not available from standings
        leagueInfo ??= StandingsLeague(
            id: fixture.league.id,
            name: fixture.league.name,
            country: fixture.league.country,
            logo: fixture.league.logo,
            flag: '',
            season: fixture.league.season,
            standings: []);

        return SingleChildScrollView(
          padding: ResponsiveHelper.getPadding(context),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // League info
              _buildLeagueHeader(context, leagueInfo),

              SizedBox(height: 24),

              // Table visualization
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Table header
                    _buildTableHeader(context),

                    // Table content
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, thickness: 0.5),
                      itemCount: leagueTableData.length,
                      itemBuilder: (context, index) {
                        final team = leagueTableData[index];
                        return _buildTableRow(
                            context,
                            team['position'],
                            team['team'],
                            team['played'],
                            team['won'],
                            team['drawn'],
                            team['lost'],
                            team['goalsFor'],
                            team['goalsAgainst'],
                            team['points'],
                            highlight:
                                team['team'] == fixture.teams.home.name ||
                                    team['team'] == fixture.teams.away.name,
                            homeTeam: team['team'] == fixture.teams.home.name,
                            awayTeam: team['team'] == fixture.teams.away.name,
                            teamLogo: team['logo'],
                            description: team['description']);
                      },
                    ),

                    // Legend
                    _buildTableLegend(context),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeagueHeader(BuildContext context, StandingsLeague league) {
    return Row(
      children: [
        Image.network(
          league.logo,
          width: 40,
          height: 40,
          errorBuilder: (ctx, e, s) => Icon(Icons.sports_soccer, size: 40),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                league.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Season ${league.season} • ${league.country}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: isSmallScreen ? 11 : 13,
    );

    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 12, horizontal: isSmallScreen ? 4 : 8),
      color: Colors.grey[100],
      child: Row(
        children: [
          SizedBox(
              width: 30, child: Center(child: Text('#', style: headerStyle))),
          Expanded(
            flex: 4,
            child: Text('Team', style: headerStyle),
          ),
          if (!isSmallScreen)
            SizedBox(
                width: 30, child: Center(child: Text('P', style: headerStyle))),
          SizedBox(
              width: 30, child: Center(child: Text('W', style: headerStyle))),
          SizedBox(
              width: 30, child: Center(child: Text('D', style: headerStyle))),
          SizedBox(
              width: 30, child: Center(child: Text('L', style: headerStyle))),
          if (!isSmallScreen) ...[
            SizedBox(
                width: 35,
                child: Center(child: Text('GF', style: headerStyle))),
            SizedBox(
                width: 35,
                child: Center(child: Text('GA', style: headerStyle))),
            SizedBox(
                width: 35,
                child: Center(child: Text('GD', style: headerStyle))),
          ],
          SizedBox(
              width: isSmallScreen ? 35 : 40,
              child: Center(child: Text('Pts', style: headerStyle))),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    BuildContext context,
    int position,
    String team,
    int played,
    int won,
    int drawn,
    int lost,
    int goalsFor,
    int goalsAgainst,
    int points, {
    bool highlight = false,
    bool homeTeam = false,
    bool awayTeam = false,
    String? teamLogo,
    String? description,
  }) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    // Use description-based color if availabl
    final positionColor = description != null && description.isNotEmpty
        ? _getDescriptionColor(description)
        : null;

    final goalDifference = goalsFor - goalsAgainst;

    Color? rowColor;
    if (homeTeam) {
      rowColor = AppTheme.homeTeamColor.withOpacity(0.1);
    } else if (awayTeam) {
      rowColor = AppTheme.awayTeamColor.withOpacity(0.1);
    } else if (highlight) {
      rowColor = Colors.grey[50];
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: rowColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 8 : 10,
            horizontal: isSmallScreen ? 4 : 8),
        child: Row(
          children: [
            // Position
            SizedBox(
              width: 30,
              child: Center(
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: positionColor?.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: Text(
                      position.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: positionColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Team
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  if (teamLogo != null)
                    Image.network(
                      teamLogo,
                      width: 20,
                      height: 20,
                      errorBuilder: (ctx, e, s) => SizedBox(width: 20),
                    ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      team,
                      style: TextStyle(
                        fontWeight:
                            highlight ? FontWeight.bold : FontWeight.normal,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Stats
            if (!isSmallScreen)
              SizedBox(width: 30, child: Center(child: Text('$played'))),
            SizedBox(width: 30, child: Center(child: Text('$won'))),
            SizedBox(width: 30, child: Center(child: Text('$drawn'))),
            SizedBox(width: 30, child: Center(child: Text('$lost'))),

            if (!isSmallScreen) ...[
              SizedBox(width: 35, child: Center(child: Text('$goalsFor'))),
              SizedBox(width: 35, child: Center(child: Text('$goalsAgainst'))),
              SizedBox(
                width: 35,
                child: Center(
                  child: Text(
                    goalDifference > 0 ? '+$goalDifference' : '$goalDifference',
                    style: TextStyle(
                      color: goalDifference > 0
                          ? Colors.green[700]
                          : goalDifference < 0
                              ? Colors.red[700]
                              : null,
                    ),
                  ),
                ),
              ),
            ],

            // Points
            SizedBox(
              width: isSmallScreen ? 35 : 40,
              child: Center(
                child: Text(
                  '$points',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the table legend explaining qualification and relegation
  Widget _buildTableLegend(BuildContext context) {
    // Group the qualification categories to display in the legend
    Map<String, Color> qualificationCategories = {};

    // Add a legend entry for each unique description from the standings
    final currentState = BlocProvider.of<StandingsBloc>(context).state;
    if (currentState is StandingsLoaded) {
      if (currentState.standings.isNotEmpty &&
          currentState.standings[0].league.standings.isNotEmpty) {
        final standingsGroup = currentState.standings[0].league.standings[0];

        // Collect unique descriptions and assign them colors
        for (final standing in standingsGroup) {
          if (standing.description != null &&
              standing.description!.isNotEmpty) {
            qualificationCategories[standing.description!] =
                _getDescriptionColor(standing.description!);
          }
        }
      }
    }

    // If no categories found from API, add default categories
    if (qualificationCategories.isEmpty) {
      qualificationCategories = {
        'Champions League': Colors.green,
        'Europa League': Colors.blue,
        'Relegation': Colors.red,
      };
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Qualification & Relegation:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 8),
          ...qualificationCategories.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  Container(width: 12, height: 12, color: entry.value),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getDescriptionColor(String description) {
    // Assign colors based on description keywords
    final desc = description.toLowerCase();

    if (desc.contains('champion') ||
        desc.contains('promotion') ||
        desc.contains('ucl') ||
        desc.contains('uefa champions')) {
      return Colors.green;
    } else if (desc.contains('europa') ||
        desc.contains('conference') ||
        desc.contains('uel') ||
        desc.contains('uecl')) {
      return Colors.blue;
    } else if (desc.contains('relegation') || desc.contains('relegated')) {
      return Colors.red;
    } else if (desc.contains('play-off') ||
        desc.contains('playoffs') ||
        desc.contains('qualification')) {
      // Determine the context of the playoff
      if (desc.contains('champions') || desc.contains('ucl')) {
        return Colors.lightGreen;
      } else if (desc.contains('europa') || desc.contains('uel')) {
        return Colors.lightBlue;
      } else if (desc.contains('relegation')) {
        return Colors.deepOrange;
      } else {
        return Colors.orange;
      }
    }

    // Default color for other descriptions
    return Colors.purple;
  }

  // Convert the real standings data from the API to our table format
  List<Map<String, dynamic>> _convertStandingsToTableData(
      List<StandingsData> standingsData) {
    if (standingsData.isEmpty) {
      return [];
    }

    final result = <Map<String, dynamic>>[];

    // Get the first standings data (assuming we only have one league)
    final leagueData = standingsData.first;

    // Handle nested standings array (API returns array of arrays)
    if (leagueData.league.standings.isNotEmpty) {
      for (final standingGroup in leagueData.league.standings) {
        for (final standing in standingGroup) {
          result.add({
            'position': standing.rank,
            'team': standing.team.name,
            'logo': standing.team.logo,
            'played': standing.all.played,
            'won': standing.all.win,
            'drawn': standing.all.draw,
            'lost': standing.all.lose,
            'goalsFor': standing.all.goals.forGoals ?? 0,
            'goalsAgainst': standing.all.goals.against ?? 0,
            'points': standing.points,
            'description': standing.description,
          });
        }
      }
    }

    return result;
  }

  List<Map<String, dynamic>> _getMockLeagueTable() {
    // Return sample league table data
    return [
      {
        'position': 1,
        'team': 'Barcelona',
        'logo': 'https://media.api-sports.io/football/teams/529.png',
        'played': 38,
        'won': 30,
        'drawn': 5,
        'lost': 3,
        'goalsFor': 95,
        'goalsAgainst': 26,
        'points': 95,
        'description': 'Champions League',
      },
      {
        'position': 2,
        'team': 'Real Madrid',
        'logo': 'https://media.api-sports.io/football/teams/541.png',
        'played': 38,
        'won': 28,
        'drawn': 6,
        'lost': 4,
        'goalsFor': 92,
        'goalsAgainst': 29,
        'points': 90,
        'description': 'Champions League',
      },
      {
        'position': 3,
        'team': 'Atletico Madrid',
        'logo': 'https://media.api-sports.io/football/teams/530.png',
        'played': 38,
        'won': 25,
        'drawn': 8,
        'lost': 5,
        'goalsFor': 76,
        'goalsAgainst': 31,
        'points': 83,
      },
      {
        'position': 4,
        'team': 'Valencia',
        'logo': 'https://media.api-sports.io/football/teams/532.png',
        'played': 38,
        'won': 21,
        'drawn': 7,
        'lost': 10,
        'goalsFor': 71,
        'goalsAgainst': 35,
        'points': 70,
      },
      {
        'position': 5,
        'team': 'Sevilla',
        'logo': 'https://media.api-sports.io/football/teams/536.png',
        'played': 38,
        'won': 17,
        'drawn': 8,
        'lost': 13,
        'goalsFor': 62,
        'goalsAgainst': 47,
        'points': 59,
        'description': 'Europa League',
      },
      {
        'position': 6,
        'team': 'Villarreal',
        'logo': 'https://media.api-sports.io/football/teams/533.png',
        'played': 38,
        'won': 17,
        'drawn': 8,
        'lost': 13,
        'goalsFor': 57,
        'goalsAgainst': 46,
        'points': 59,
      },
      {
        'position': 17,
        'team': 'Mallorca',
        'logo': 'https://media.api-sports.io/football/teams/798.png',
        'played': 38,
        'won': 9,
        'drawn': 9,
        'lost': 20,
        'goalsFor': 40,
        'goalsAgainst': 65,
        'points': 36,
      },
      {
        'position': 18,
        'team': 'Leganes',
        'logo': 'https://media.api-sports.io/football/teams/537.png',
        'played': 38,
        'won': 8,
        'drawn': 12,
        'lost': 18,
        'goalsFor': 30,
        'goalsAgainst': 51,
        'points': 36,
        'description': 'Relegation',
      },
      {
        'position': 19,
        'team': 'Huesca',
        'logo': 'https://media.api-sports.io/football/teams/724.png',
        'played': 38,
        'won': 7,
        'drawn': 12,
        'lost': 19,
        'goalsFor': 34,
        'goalsAgainst': 65,
        'points': 33,
      },
      {
        'position': 20,
        'team': 'Eibar',
        'logo': 'https://media.api-sports.io/football/teams/545.png',
        'played': 38,
        'won': 7,
        'drawn': 9,
        'lost': 22,
        'goalsFor': 29,
        'goalsAgainst': 66,
        'points': 30,
      },
    ];
  }
}
