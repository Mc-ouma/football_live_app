import 'package:flutter/material.dart';
import 'package:football_live_app/data/models/fixture_model.dart';

class MatchScoreHeader extends StatelessWidget {
  final FixtureData fixture;

  const MatchScoreHeader({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Match status and time
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(fixture.fixture.status.short),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  fixture.fixture.status.long,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Teams and score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home team
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(fixture.teams.home.logo),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          fixture.teams.home.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Score
                  Column(
                    children: [
                      Text(
                        '${fixture.goals.home ?? 0} - ${fixture.goals.away ?? 0}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (fixture.fixture.status.elapsed != null)
                        Text(
                          "${fixture.fixture.status.elapsed}'",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),

                  // Away team
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(fixture.teams.away.logo),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          fixture.teams.away.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Venue info
              if (fixture.fixture.venue.name != null)
                Text(
                  '${fixture.fixture.venue.name}${fixture.fixture.venue.city != null ? ', ${fixture.fixture.venue.city}' : ''}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'LIVE':
      case '1H':
      case '2H':
      case 'HT':
        return Colors.red;
      case 'FT':
        return Colors.grey;
      case 'NS':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
