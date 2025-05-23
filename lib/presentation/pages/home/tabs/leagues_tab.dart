import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart' as di;
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/pages/standings/standings_page.dart';

class LeaguesTab extends StatefulWidget {
  const LeaguesTab({super.key});

  @override
  State<LeaguesTab> createState() => _LeaguesTabState();
}

class _LeaguesTabState extends State<LeaguesTab> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _getLeagueId(String leagueName) {
    switch (leagueName) {
      case 'Premier League':
        return 39;
      case 'La Liga':
        return 140;
      case 'Bundesliga':
        return 78;
      case 'Serie A':
        return 135;
      case 'Ligue 1':
        return 61;
      case 'Champions League':
        return 2;
      default:
        return 39; // Default to Premier League
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of top leagues
    final topLeagues = [
      {
        'name': 'Premier League',
        'country': 'England',
        'logo': 'https://media.api-sports.io/football/leagues/39.png'
      },
      {
        'name': 'La Liga',
        'country': 'Spain',
        'logo': 'https://media.api-sports.io/football/leagues/140.png'
      },
      {
        'name': 'Bundesliga',
        'country': 'Germany',
        'logo': 'https://media.api-sports.io/football/leagues/78.png'
      },
      {
        'name': 'Serie A',
        'country': 'Italy',
        'logo': 'https://media.api-sports.io/football/leagues/135.png'
      },
      {
        'name': 'Ligue 1',
        'country': 'France',
        'logo': 'https://media.api-sports.io/football/leagues/61.png'
      },
      {
        'name': 'Champions League',
        'country': 'Europe',
        'logo': 'https://media.api-sports.io/football/leagues/2.png'
      },
    ];

    // List of other leagues
    final otherLeagues = [
      {
        'name': 'Eredivisie',
        'country': 'Netherlands',
        'logo': 'https://media.api-sports.io/football/leagues/88.png'
      },
      {
        'name': 'Primeira Liga',
        'country': 'Portugal',
        'logo': 'https://media.api-sports.io/football/leagues/94.png'
      },
      {
        'name': 'MLS',
        'country': 'USA',
        'logo': 'https://media.api-sports.io/football/leagues/253.png'
      },
      {
        'name': 'Brasileirão',
        'country': 'Brazil',
        'logo': 'https://media.api-sports.io/football/leagues/71.png'
      },
    ];

    return Column(
      children: [
        // Tab bar
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: 'Top Leagues'),
            Tab(text: 'All Leagues'),
          ],
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Top Leagues tab
              _buildLeaguesList(context, topLeagues),

              // All Leagues tab (top + other leagues)
              _buildLeaguesList(context, [...topLeagues, ...otherLeagues]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaguesList(
      BuildContext context, List<Map<String, String>> leagues) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        final league = leagues[index];
        return LeagueCard(
          name: league['name']!,
          country: league['country']!,
          logoUrl: league['logo'],
          onTap: () {
            // Navigate to league standings
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => di.sl<StandingsBloc>(),
                  child: StandingsPage(
                    leagueId: _getLeagueId(league['name']!),
                    season:
                        2025, // Current season based on context date (May 22, 2025)
                    leagueName: league['name']!,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class LeagueCard extends StatelessWidget {
  final String name;
  final String country;
  final String? logoUrl;
  final VoidCallback onTap;

  const LeagueCard({
    super.key,
    required this.name,
    required this.country,
    this.logoUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // League logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: logoUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          logoUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.sports_soccer, size: 25),
                        ),
                      )
                    : const Icon(Icons.sports_soccer, size: 25),
              ),
              const SizedBox(width: 16),

              // League info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      country,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Navigation indicator
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLeaguesTab(BuildContext context) {
  // List of top leagues
  final topLeagues = [
    {
      'name': 'Premier League',
      'country': 'England',
      'logo': 'https://media.api-sports.io/football/leagues/39.png'
    },
    {
      'name': 'La Liga',
      'country': 'Spain',
      'logo': 'https://media.api-sports.io/football/leagues/140.png'
    },
    {
      'name': 'Bundesliga',
      'country': 'Germany',
      'logo': 'https://media.api-sports.io/football/leagues/78.png'
    },
    {
      'name': 'Serie A',
      'country': 'Italy',
      'logo': 'https://media.api-sports.io/football/leagues/135.png'
    },
    {
      'name': 'Ligue 1',
      'country': 'France',
      'logo': 'https://media.api-sports.io/football/leagues/61.png'
    },
  ];

  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search box
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search leagues...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Popular Competitions section
        Text(
          'Popular Competitions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),

        // Horizontal scrolling top leagues
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topLeagues.length,
            itemBuilder: (context, index) {
              final league = topLeagues[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StandingsPage(
                          leagueId: league['name'] == 'Premier League'
                              ? 39
                              : league['name'] == 'La Liga'
                                  ? 140
                                  : league['name'] == 'Bundesliga'
                                      ? 78
                                      : league['name'] == 'Serie A'
                                          ? 135
                                          : league['name'] == 'Ligue 1'
                                              ? 61
                                              : 39, // Default to Premier League
                          // Assuming the current season is 2025
                          season:
                              2025, // Using 2025 season as 2024 might not have complete data yet
                          leagueName: league['name'] as String,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.network(
                          league['logo']!,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.emoji_events, size: 40),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        league['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        league['country']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // All Leagues section
        Text(
          'All Leagues',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),

        // Leagues by country
        Expanded(
          child: ListView(
            children: [
              _buildLeaguesByCountry(context, 'England', [
                'Premier League',
                'Championship',
                'League One',
                'FA Cup',
              ]),
              _buildLeaguesByCountry(context, 'Spain', [
                'La Liga',
                'La Liga 2',
                'Copa del Rey',
              ]),
              _buildLeaguesByCountry(context, 'International', [
                'UEFA Champions League',
                'UEFA Europa League',
                'FIFA World Cup',
                'UEFA European Championship',
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLeaguesByCountry(
    BuildContext context, String country, List<String> leagues) {
  return ExpansionTile(
    title: Text(
      country,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    children: leagues
        .map((league) => ListTile(
              title: Text(league),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to league details page
              },
            ))
        .toList(),
  );
}

//   Widget _buildLeaguesTab(BuildContext context) {
