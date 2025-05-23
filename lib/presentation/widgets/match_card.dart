import 'package:flutter/material.dart';
import 'package:football_live_app/domain/entities/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;
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
              // League name and match time
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
                          child: match.league.logo != null
                              ? Image.network(
                                  match.league.logo!,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.sports_soccer, size: 20),
                                )
                              : const Icon(Icons.sports_soccer, size: 20),
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
                      color: match.status.short == 'LIVE'
                          ? Colors.red
                          : Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      match.status.short == 'LIVE'
                          ? '${match.status.elapsed ?? 0}\''
                          : match.status.long,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: match.status.short == 'LIVE'
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
                          child: match.homeTeam.logo != null
                              ? Image.network(
                                  match.homeTeam.logo!,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.shield, size: 30),
                                )
                              : const Icon(Icons.shield, size: 30),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          match.homeTeam.name,
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
                        '${match.score?.homeGoals} - ${match.score?.awayGoals}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: match.status.short == 'LIVE'
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
                          child: match.awayTeam.logo != null
                              ? Image.network(
                                  match.awayTeam.logo!,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.shield, size: 30),
                                )
                              : const Icon(Icons.shield, size: 30),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          match.awayTeam.name,
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
              if (match.events.isNotEmpty) ...[
                const Divider(height: 24),
                SizedBox(
                  height: 24,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        match.events.length > 3 ? 3 : match.events.length,
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('•', style: TextStyle(color: Colors.grey)),
                    ),
                    itemBuilder: (context, index) {
                      final event = match.events[index];
                      IconData icon;

                      switch (event.type) {
                        case 'Goal':
                          icon = Icons.sports_soccer;
                          break;
                        case 'Card':
                          icon = Icons.credit_card;
                          break;
                        case 'Substitution':
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
                            '${event.minute}\' ${event.playerName}',
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
            ],
          ),
        ),
      ),
    );
  }
}
