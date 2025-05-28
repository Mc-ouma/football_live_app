import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';

class EventsTab extends StatelessWidget {
  final FixtureData fixture;

  const EventsTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        List<Event> events = [];

        // Try to get events from detailed fixture data
        if (state is FixtureDetailsLoaded && state.hasFixtures) {
          // Check if the loaded fixture has events (when it's a detailed fixture)
          final loadedFixture = state.fixture;
          if (loadedFixture != null) {
            // Check if this fixture has events by using the when method
            events = loadedFixture.when(
              detailed: (fixture, league, teams, goals, score, events, lineups,
                      statistics, players) =>
                  events ?? [],
              live: (fixture, league, teams, goals, score, events) => events,
              (fixture, league, teams, goals, score) => <Event>[],
            );
          }
        }

        // Fallback to original fixture if it has events and we haven't found any yet
        if (events.isEmpty) {
          events = fixture.when(
            detailed: (fixture, league, teams, goals, score, events, lineups,
                    statistics, players) =>
                events ?? [],
            live: (fixture, league, teams, goals, score, events) => events,
            (fixture, league, teams, goals, score) => <Event>[],
          );
        }

        if (events.isEmpty) {
          return Center(
            child: Text('No events available for this match'),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return _buildEventItem(event);
          },
        );
      },
    );
  }

  Widget _buildEventItem(Event event) {
    IconData icon;
    Color color;

    switch (event.type.toLowerCase()) {
      case 'goal':
        icon = Icons.sports_soccer;
        color = Colors.green;
        break;
      case 'card':
        icon = Icons.credit_card;
        color = event.detail.toLowerCase().contains('yellow')
            ? Colors.yellow
            : Colors.red;
        break;
      case 'subst':
        icon = Icons.swap_horiz;
        color = Colors.blue;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }

    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          '${event.time.elapsed}\' - ${event.type}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${event.player.name} (${event.team.name})',
        ),
        trailing: event.detail.isNotEmpty
            ? Text(
                event.detail,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              )
            : null,
      ),
    );
  }
}
