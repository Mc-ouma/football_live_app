import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';

class EventsTab extends StatelessWidget {
  final FixtureData fixture;

  const EventsTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        List<Event> events = [];

        // Try to get events from detailed fixture data using our extension
        if (state is FixtureDetailsLoaded && state.hasFixtures) {
          final loadedFixture = state.fixture;
          if (loadedFixture != null) {
            // Use our extension method to safely get events
            events = loadedFixture.getEvents();
          }
        }

        // Fallback to original fixture if we haven't found any events yet
        if (events.isEmpty) {
          // Use our extension method on the original fixture
          events = fixture.getEvents();
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
