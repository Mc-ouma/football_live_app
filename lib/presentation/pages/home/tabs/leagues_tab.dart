import 'package:flutter/material.dart';

class LeaguesTab extends StatefulWidget {
  const LeaguesTab({super.key});

  @override
  State<LeaguesTab> createState() => _LeaguesTabState();
}

class _LeaguesTabState extends State<LeaguesTab> {
  // Track expanded/collapsed state for each league category
  final Map<String, bool> _expandedCategories = {
    'Popular Leagues': true,
    'International': false,
    'Europe': false,
    'Americas': false,
    'Asia': false,
    'Africa': false,
  };

  // League categories
  final Map<String, List<LeagueInfo>> _leagueCategories = {};

  @override
  void initState() {
    super.initState();
    _initLeagues();
  }

  void _initLeagues() {
    // Popular leagues
    _leagueCategories['Popular Leagues'] = [
      LeagueInfo(
        id: 39,
        name: 'Premier League',
        country: 'England',
        logo: 'https://media.api-sports.io/football/leagues/39.png',
      ),
      LeagueInfo(
        id: 140,
        name: 'La Liga',
        country: 'Spain',
        logo: 'https://media.api-sports.io/football/leagues/140.png',
      ),
      LeagueInfo(
        id: 78,
        name: 'Bundesliga',
        country: 'Germany',
        logo: 'https://media.api-sports.io/football/leagues/78.png',
      ),
      LeagueInfo(
        id: 135,
        name: 'Serie A',
        country: 'Italy',
        logo: 'https://media.api-sports.io/football/leagues/135.png',
      ),
      LeagueInfo(
        id: 61,
        name: 'Ligue 1',
        country: 'France',
        logo: 'https://media.api-sports.io/football/leagues/61.png',
      ),
    ];

    // International competitions
    _leagueCategories['International'] = [
      LeagueInfo(
        id: 1,
        name: 'World Cup',
        country: 'World',
        logo: 'https://media.api-sports.io/football/leagues/1.png',
      ),
      LeagueInfo(
        id: 2,
        name: 'UEFA Champions League',
        country: 'Europe',
        logo: 'https://media.api-sports.io/football/leagues/2.png',
      ),
      LeagueInfo(
        id: 3,
        name: 'UEFA Europa League',
        country: 'Europe',
        logo: 'https://media.api-sports.io/football/leagues/3.png',
      ),
    ];

    // European leagues
    _leagueCategories['Europe'] = [
      LeagueInfo(
        id: 48,
        name: 'Primeira Liga',
        country: 'Portugal',
        logo: 'https://media.api-sports.io/football/leagues/48.png',
      ),
      LeagueInfo(
        id: 88,
        name: 'Eredivisie',
        country: 'Netherlands',
        logo: 'https://media.api-sports.io/football/leagues/88.png',
      ),
    ];

    // Placeholder for other categories
    _leagueCategories['Americas'] = [];
    _leagueCategories['Asia'] = [];
    _leagueCategories['Africa'] = [];
  }

  // Toggle category expansion
  void _toggleCategory(String category) {
    setState(() {
      _expandedCategories[category] = !_expandedCategories[category]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh functionality
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: _buildCategoriesWidgets(),
        ),
      ),
    );
  }

  List<Widget> _buildCategoriesWidgets() {
    List<Widget> widgets = [];

    _leagueCategories.forEach((category, leagues) {
      widgets.add(
        _buildCategoryHeader(category),
      );

      // Add leagues if category is expanded with animation
      if (_expandedCategories[category]!) {
        if (leagues.isNotEmpty) {
          widgets.add(
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children:
                    leagues.map((league) => _buildLeagueCard(league)).toList(),
              ),
            ),
          );
        } else {
          widgets.add(
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding:
                  const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
              child: Card(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 8),
                      Text('No leagues available in this category'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }

      widgets.add(const SizedBox(height: 16));
    });

    return widgets;
  }

  Widget _buildCategoryHeader(String category) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => _toggleCategory(category),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              // Badge to show number of leagues if expanded
              if (_leagueCategories[category]!.isNotEmpty &&
                  _expandedCategories[category]!)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_leagueCategories[category]!.length}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              AnimatedRotation(
                turns: _expandedCategories[category]! ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueCard(LeagueInfo league) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // TODO: Navigate to league details when standings model is implemented
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.info, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('${league.name} details coming soon!'),
                ],
              ),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(league.logo),
                  backgroundColor: Colors.grey[200],
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      league.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          league.country,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Simple model for league information
class LeagueInfo {
  final int id;
  final String name;
  final String country;
  final String logo;

  LeagueInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
  });
}
