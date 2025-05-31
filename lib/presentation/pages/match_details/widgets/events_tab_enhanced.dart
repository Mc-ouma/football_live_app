import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class EventsTabEnhanced extends StatelessWidget {
  final FixtureData fixture;

  const EventsTabEnhanced({Key? key, required this.fixture}) : super(key: key);

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

        // Log events data for debugging
        print(
            '📊 EventsTabEnhanced: Analyzing events for fixture ID ${fixtureToUse.fixture.id}:');
        print('   - Total events found: ${events.length}');
        print(
            '   - Match status: ${fixtureToUse.fixture.status.short} (${fixtureToUse.fixture.status.long})');
        print('   - Has detailed data: ${fixtureToUse.hasDetailedData}');

        if (events.isNotEmpty) {
          final eventTypes = events.map((e) => e.type).toSet();
          print('   - Event types: ${eventTypes.join(', ')}');
          print(
              '   - First event: ${events.first.type} at ${events.first.time.elapsed}\'');
          print(
              '   - Last event: ${events.last.type} at ${events.last.time.elapsed}\'');
        }

        // Only request more data if we don't have events data and we're not already loading
        if (events.isEmpty && state is! FixtureDetailsLoading) {
          print(
              '⚠️  EventsTabEnhanced: No events data available, requesting from API...');
          // Use post-frame callback to avoid calling during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            }
          });
        }

        return Column(
          children: [
            // Match timeline header
            _buildTimelineHeader(context, fixtureToUse),

            // Events list
            Expanded(
              child: events.isEmpty
                  ? _buildEmptyState(context)
                  : _buildEventsList(context, events, fixtureToUse),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimelineHeader(BuildContext context, FixtureData fixture) {
    final isLive = FixtureDataProvider.isMatchLive(fixture);
    final status = fixture.fixture.status;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Home team
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(fixture.teams.home.logo),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    fixture.teams.home.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Match status and score
          Column(
            children: [
              Text(
                '${fixture.goals.home ?? '-'} : ${fixture.goals.away ?? '-'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLive) ...[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    isLive && status.elapsed != null
                        ? "${status.elapsed}'"
                        : status.short,
                    style: TextStyle(
                      color: isLive ? Colors.red : Colors.grey[600],
                      fontWeight: isLive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Away team
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    fixture.teams.away.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: NetworkImage(fixture.teams.away.logo),
                  radius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_soccer_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No events available',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Events will appear as they occur during the match',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Check for Updates'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(
      BuildContext context, List<Event> events, FixtureData fixture) {
    // Group events by period
    final firstHalfEvents = events.where((e) => e.time.elapsed <= 45).toList();
    final secondHalfEvents = events
        .where((e) => e.time.elapsed > 45 && e.time.elapsed <= 90)
        .toList();
    final extraTimeEvents = events.where((e) => e.time.elapsed > 90).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // First Half
        if (firstHalfEvents.isNotEmpty) ...[
          _buildPeriodHeader('First Half'),
          ...firstHalfEvents.map((event) => _buildEventItem(event, fixture)),
          const SizedBox(height: 16),
        ],

        // Second Half
        if (secondHalfEvents.isNotEmpty) ...[
          _buildPeriodHeader('Second Half'),
          ...secondHalfEvents.map((event) => _buildEventItem(event, fixture)),
          const SizedBox(height: 16),
        ],

        // Extra Time
        if (extraTimeEvents.isNotEmpty) ...[
          _buildPeriodHeader('Extra Time'),
          ...extraTimeEvents.map((event) => _buildEventItem(event, fixture)),
        ],

        // Show all events if no period grouping is possible
        if (firstHalfEvents.isEmpty &&
            secondHalfEvents.isEmpty &&
            extraTimeEvents.isEmpty)
          ...events.map((event) => _buildEventItem(event, fixture)),
      ],
    );
  }

  Widget _buildPeriodHeader(String period) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(thickness: 1, color: Colors.grey[300]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              period,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Divider(thickness: 1, color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(Event event, FixtureData fixture) {
    final isHomeTeam = event.team.id == fixture.teams.home.id;

    IconData icon;
    Color color;
    String eventDescription;

    switch (event.type.toLowerCase()) {
      case 'goal':
        icon = Icons.sports_soccer;
        color = Colors.green;
        eventDescription = _buildGoalDescription(event);
        break;
      case 'card':
        icon = Icons.credit_card;
        color = event.detail.toLowerCase().contains('yellow')
            ? Colors.orange
            : Colors.red;
        eventDescription = '${event.player.name} (${event.detail})';
        break;
      case 'subst':
        icon = Icons.swap_horiz;
        color = Colors.blue;
        eventDescription = _buildSubstitutionDescription(event);
        break;
      case 'var':
        icon = Icons.video_camera_front;
        color = Colors.purple;
        eventDescription = 'VAR: ${event.detail}';
        break;
      default:
        icon = Icons.sports;
        color = Colors.grey;
        eventDescription = event.detail;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${event.time.elapsed}'",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Event details
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isHomeTeam
                    ? Colors.blue.withOpacity(0.05)
                    : Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isHomeTeam
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(event.team.logo),
                        radius: 12,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.team.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    eventDescription,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (event.comments != null && event.comments!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      event.comments!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildGoalDescription(Event event) {
    String description = event.player.name;

    if (event.detail.isNotEmpty) {
      description += ' (${event.detail})';
    }

    if (event.assist != null && event.assist!.name.isNotEmpty) {
      description += '\nAssist: ${event.assist!.name}';
    }

    return description;
  }

  String _buildSubstitutionDescription(Event event) {
    final playerOut = event.assist?.name ?? "Unknown";
    return '${event.player.name} ↔ $playerOut';
  }
}
