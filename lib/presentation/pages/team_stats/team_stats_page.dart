import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/entities/fixture.dart';
import 'package:football_live_app/domain/entities/standing.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/widgets/error_view.dart';
import 'package:football_live_app/presentation/widgets/loading_indicator.dart';
import 'package:intl/intl.dart';

class TeamStatsPage extends StatefulWidget {
  final Team team;

  const TeamStatsPage({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  State<TeamStatsPage> createState() => _TeamStatsPageState();
}

class _TeamStatsPageState extends State<TeamStatsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _currentSeason = 2024; // Current season year

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              widget.team.logo!,
              height: 32,
              errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.team.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Fixtures'),
            Tab(text: 'Squad'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TeamOverviewTab(team: widget.team, season: _currentSeason),
          _TeamFixturesTab(team: widget.team),
          _TeamSquadTab(team: widget.team),
        ],
      ),
    );
  }
}

class _TeamOverviewTab extends StatefulWidget {
  final Team team;
  final int season;

  const _TeamOverviewTab({
    Key? key,
    required this.team,
    required this.season,
  }) : super(key: key);

  @override
  State<_TeamOverviewTab> createState() => _TeamOverviewTabState();
}

class _TeamOverviewTabState extends State<_TeamOverviewTab> {
  @override
  void initState() {
    super.initState();
    // Load standings for relevant leagues
    // This is a simplified approach - in a real app you would
    // first determine which leagues the team belongs to
    _loadStandings();
  }

  void _loadStandings() {
    // For demo purposes, assume Premier League (id: 39)
    context.read<StandingsBloc>().add(
          FetchStandingsEvent(leagueId: 39, season: widget.season),
        );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    Color? color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color ?? Colors.blue, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: color ?? Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandingsSection(StandingsLoaded state) {
    final standings = state.standings;

    // Find team in standings
    final teamStanding = standings.firstWhere(
      (s) => s.team.id == widget.team.id,
      orElse: () => Standing(
        rank: 0,
        team: widget.team,
        points: 0,
        goalsDiff: 0,
      ),
    );

    if (teamStanding.rank == 0) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'No league standing information available for this team',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'League Standing',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Position
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  '${teamStanding.rank}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: const Text('Current Position'),
              trailing: Text(
                '${teamStanding.points} pts',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const Divider(),

            // Form
            if (teamStanding.form != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Form',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: teamStanding.form!.split('').map((result) {
                        Color color;
                        switch (result) {
                          case 'W':
                            color = Colors.green;
                            break;
                          case 'L':
                            color = Colors.red;
                            break;
                          case 'D':
                            color = Colors.orange;
                            break;
                          default:
                            color = Colors.grey;
                        }
                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              result,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            const Divider(),

            // Stats grid
            if (teamStanding.all != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Season Stats',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildStatCard(
                          title: 'Played',
                          value: '${teamStanding.all!.played}',
                          icon: Icons.sports_soccer,
                        ),
                        _buildStatCard(
                          title: 'Won',
                          value: '${teamStanding.all!.win}',
                          icon: Icons.emoji_events,
                          color: Colors.green,
                        ),
                        _buildStatCard(
                          title: 'Lost',
                          value: '${teamStanding.all!.lose}',
                          icon: Icons.close,
                          color: Colors.red,
                        ),
                        _buildStatCard(
                          title: 'Draw',
                          value: '${teamStanding.all!.draw}',
                          icon: Icons.horizontal_rule,
                          color: Colors.orange,
                        ),
                        _buildStatCard(
                          title: 'Goals For',
                          value: '${teamStanding.all!.goals.forGoals ?? 0}',
                          icon: Icons.sports_score,
                          color: Colors.blue,
                        ),
                        _buildStatCard(
                          title: 'Goals Against',
                          value: '${teamStanding.all!.goals.against ?? 0}',
                          icon: Icons.shield,
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Team overview card
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.team.logo!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.team.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  if (widget.team.country != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.team.country!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Follow'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Team followed!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.notifications_none),
                        label: const Text('Notify'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Notifications enabled for this team!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Standing section
          BlocBuilder<StandingsBloc, StandingsState>(
            builder: (context, state) {
              if (state is StandingsLoading) {
                return const Center(child: LoadingIndicator());
              } else if (state is StandingsError) {
                return ErrorView(
                  message: state.message,
                  onRetry: _loadStandings,
                );
              } else if (state is StandingsLoaded) {
                return _buildStandingsSection(state);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _TeamFixturesTab extends StatelessWidget {
  final Team team;

  const _TeamFixturesTab({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For demo purposes, we'll show placeholder data
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Upcoming Fixtures',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Placeholder upcoming matches
        _buildFixtureCard(
          homeTeam: team,
          awayTeam: Team(id: 42, name: 'Arsenal FC'),
          date: DateTime.now().add(const Duration(days: 5)),
          competition: 'Premier League',
        ),
        _buildFixtureCard(
          homeTeam: Team(id: 50, name: 'Manchester United'),
          awayTeam: team,
          date: DateTime.now().add(const Duration(days: 12)),
          competition: 'Premier League',
        ),
        _buildFixtureCard(
          homeTeam: team,
          awayTeam: Team(id: 47, name: 'Tottenham Hotspur'),
          date: DateTime.now().add(const Duration(days: 19)),
          competition: 'Premier League',
        ),

        const SizedBox(height: 24),
        const Text(
          'Recent Results',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Placeholder past matches
        _buildFixtureCard(
          homeTeam: Team(id: 49, name: 'Chelsea FC'),
          awayTeam: team,
          date: DateTime.now().subtract(const Duration(days: 7)),
          competition: 'Premier League',
          homeScore: 1,
          awayScore: 2,
          isCompleted: true,
        ),
        _buildFixtureCard(
          homeTeam: team,
          awayTeam: Team(id: 40, name: 'Liverpool FC'),
          date: DateTime.now().subtract(const Duration(days: 14)),
          competition: 'Premier League',
          homeScore: 2,
          awayScore: 2,
          isCompleted: true,
        ),
        _buildFixtureCard(
          homeTeam: Team(id: 44, name: 'Aston Villa'),
          awayTeam: team,
          date: DateTime.now().subtract(const Duration(days: 21)),
          competition: 'Premier League',
          homeScore: 0,
          awayScore: 3,
          isCompleted: true,
        ),
      ],
    );
  }

  Widget _buildFixtureCard({
    required Team homeTeam,
    required Team awayTeam,
    required DateTime date,
    required String competition,
    int? homeScore,
    int? awayScore,
    bool isCompleted = false,
  }) {
    final dateFormat =
        isCompleted ? 'EEE, MMM d, yyyy' : 'EEE, MMM d, yyyy • HH:mm';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.sports_soccer,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  competition,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat(dateFormat).format(date),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.network(
                        homeTeam.logo!,
                        height: 36,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.sports_soccer,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        homeTeam.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: homeTeam.id == team.id
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$homeScore - $awayScore',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'VS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      Image.network(
                        awayTeam.logo!,
                        height: 36,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.sports_soccer,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        awayTeam.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: awayTeam.id == team.id
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
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

class _TeamSquadTab extends StatelessWidget {
  final Team team;

  const _TeamSquadTab({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For demo purposes, we'll show placeholder data
    final playersByPosition = {
      'Goalkeepers': [
        {'name': 'Ederson', 'number': 31, 'nationality': 'Brazil'},
        {'name': 'Stefan Ortega', 'number': 18, 'nationality': 'Germany'},
      ],
      'Defenders': [
        {'name': 'Kyle Walker', 'number': 2, 'nationality': 'England'},
        {'name': 'Ruben Dias', 'number': 3, 'nationality': 'Portugal'},
        {'name': 'John Stones', 'number': 5, 'nationality': 'England'},
        {'name': 'Nathan Ake', 'number': 6, 'nationality': 'Netherlands'},
        {'name': 'Manuel Akanji', 'number': 25, 'nationality': 'Switzerland'},
      ],
      'Midfielders': [
        {'name': 'Rodri', 'number': 16, 'nationality': 'Spain'},
        {'name': 'Kevin De Bruyne', 'number': 17, 'nationality': 'Belgium'},
        {'name': 'Bernardo Silva', 'number': 20, 'nationality': 'Portugal'},
        {'name': 'Mateo Kovacic', 'number': 8, 'nationality': 'Croatia'},
      ],
      'Forwards': [
        {'name': 'Erling Haaland', 'number': 9, 'nationality': 'Norway'},
        {'name': 'Jack Grealish', 'number': 10, 'nationality': 'England'},
        {'name': 'Jeremy Doku', 'number': 11, 'nationality': 'Belgium'},
        {'name': 'Phil Foden', 'number': 47, 'nationality': 'England'},
      ],
    };

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final position in playersByPosition.keys) ...[
          Text(
            position,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...playersByPosition[position]!.map((player) => _buildPlayerCard(
                name: player['name'] as String,
                number: player['number'] as int,
                nationality: player['nationality'] as String,
              )),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildPlayerCard({
    required String name,
    required int number,
    required String nationality,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('$number'),
        ),
        title: Text(name),
        subtitle: Text(nationality),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
