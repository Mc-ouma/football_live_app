import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class EventsTab extends StatelessWidget {
  final FixtureData fixture;

  const EventsTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return const LoadingWidget(message: 'Loading match events...');
        }

        // Show error state with retry button
        if (state is FixtureDetailsError) {
          return ErrorDisplayWidget(
            message: 'Failed to load events: ${state.message}',
            onRetry: () {
              // Retry loading fixture details using our provider
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            },
          );
        }

        // Get the most complete fixture data available using our utility
        final fixtureToUse =
            FixtureDataProvider.getBestFixtureData(context, fixture);

        // Get events sorted by time
        List<Event> events = FixtureDataProvider.getSortedEvents(fixtureToUse);

        // If we don't have events data and we're not already loading, request it
        if (events.isEmpty && state is! FixtureDetailsLoading) {
          print('No events data available, requesting from API...');
          // Use post-frame callback to avoid calling during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            }
          });
        }

        if (events.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer_outlined,
                    size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text(
                  'No events available for this match',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Events will appear as they occur during the match',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
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
