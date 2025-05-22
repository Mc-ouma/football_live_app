import 'package:flutter/material.dart';
import 'package:football_live_app/presentation/pages/standings/standings_page.dart';

class LeaguesTab extends StatelessWidget {
  const LeaguesTab({super.key});
  
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
    // Placeholder for top leagues
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
                            leagueId: _getLeagueId(league['name'] as String),
                            season: 2023, // Using 2023 season as 2024 might not have complete data yet
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
}
