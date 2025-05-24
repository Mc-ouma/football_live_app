import 'package:flutter/material.dart';

class LeaguesTab extends StatefulWidget {
  const LeaguesTab({super.key});

  @override
  State<LeaguesTab> createState() => _LeaguesTabState();
}

class _LeaguesTabState extends State<LeaguesTab> {
  final List<LeagueInfo> _popularLeagues = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh functionality
        },
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              'Popular Leagues',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16),
            ..._popularLeagues.map((league) => _buildLeagueCard(league)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueCard(LeagueInfo league) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(league.logo),
          backgroundColor: Colors.grey[300],
        ),
        title: Text(
          league.name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(league.country),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to league details when standings model is implemented
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('League details coming soon!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
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
