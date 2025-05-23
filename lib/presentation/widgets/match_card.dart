import 'package:flutter/material.dart';
import 'package:football_live_app/data/models/fixture_model.dart';

class MatchCard extends StatelessWidget {
  final FixtureData match;
  final VoidCallback onTap;

  const MatchCard({
    super.key,
    required this.match,
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
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // League name and match time/status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // League info
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.network(
                            match.league.logo,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.sports_soccer, size: 20),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            match.league.name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Match time/status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: match.fixture.status.short == 'LIVE'
                          ? Colors.red
                          : Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      match.fixture.status.short == 'LIVE'
                          ? '${match.fixture.status.elapsed ?? 0}\''
                          : match.fixture.status.long,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: match.fixture.status.short == 'LIVE'
                            ? Colors.white
                            : Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Team names and scores
              Row(
                children: [
                  // Home team
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            match.teams.home.logo,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.shield, size: 30),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          match.teams.home.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Score
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${match.goals.home ?? 0} - ${match.goals.away ?? 0}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: match.fixture.status.short == 'LIVE'
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),

                  // Away team
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            match.teams.away.logo,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.shield, size: 30),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          match.teams.away.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Match events/stats summary
              _buildMatchEvents(context),
            ],
          ),
        ),
      ),
    );
  }  /// Builds match events section if available based on the fixture type
  Widget _buildMatchEvents(BuildContext context) {
    // Handle different match types
    if (match is _FixtureDataDetailed) {
      final detailedMatch = match as _FixtureDataDetailed;
      final events = detailedMatch.events;
      
      if (events != null && events.isNotEmpty) {
        return _buildEventsList(context, events);
      }
    } 
    else if (match is _FixtureDataLive) {
      final liveMatch = match as _FixtureDataLive;
      final events = liveMatch.events;
      
      if (events.isNotEmpty) {
        return _buildEventsList(context, events);
      }
    }
    
    return const SizedBox.shrink();
  }
  
  /// Helper method to build the events list UI
  Widget _buildEventsList(BuildContext context, List<Event> events) {
    return Column(
      children: [
        const Divider(height: 24),
        SizedBox(
          height: 24,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: events.length > 3 ? 3 : events.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('•', style: TextStyle(color: Colors.grey)),
            ),
            itemBuilder: (context, index) {
              final event = events[index];
              IconData icon;

              switch (event.type) {
                case 'Goal':
                  icon = Icons.sports_soccer;
                  break;
                case 'Card':
                  icon = Icons.credit_card;
                  break;
                case 'Subst':
                  icon = Icons.swap_horiz;
                  break;
                default:
                  icon = Icons.sports;
              }

              return Row(
                children: [
                  Icon(icon,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 4),
                  Text(
                    '${event.time.elapsed}\' ${event.player.name}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
  }
}
