import 'package:flutter/material.dart';
import 'package:football_live_app/presentation/pages/standings/standings_page.dart';

class LeaguesPage extends StatelessWidget {
  const LeaguesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // These are hardcoded popular leagues for demonstration
    // In a real app, we would fetch these from the API
    final popularLeagues = [
      _LeagueItem(
          id: 39, name: 'Premier League', country: 'England', season: 2024),
      _LeagueItem(id: 140, name: 'La Liga', country: 'Spain', season: 2024),
      _LeagueItem(id: 135, name: 'Serie A', country: 'Italy', season: 2024),
      _LeagueItem(id: 78, name: 'Bundesliga', country: 'Germany', season: 2024),
      _LeagueItem(id: 61, name: 'Ligue 1', country: 'France', season: 2024),
      _LeagueItem(
          id: 2, name: 'Champions League', country: 'Europe', season: 2024),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Leagues'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: popularLeagues.length,
        itemBuilder: (context, index) {
          final league = popularLeagues[index];
          return ListTile(
            title: Text(league.name),
            subtitle: Text(league.country),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StandingsPage(
                    leagueId: league.id,
                    season: league.season,
                    leagueName: league.name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LeagueItem {
  final int id;
  final String name;
  final String country;
  final int season;

  _LeagueItem({
    required this.id,
    required this.name,
    required this.country,
    required this.season,
  });
}
