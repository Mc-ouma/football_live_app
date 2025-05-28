import 'package:flutter/material.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:intl/intl.dart';

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
    // Check if the match is in the past but still shows "NS" status
    final fixtureDateTime = DateTime.fromMillisecondsSinceEpoch(
      match.fixture.timestamp * 1000,
    );
    final now = DateTime.now();
    final bool shouldHaveStarted =
        fixtureDateTime.isBefore(now.subtract(const Duration(minutes: 15)));

    // Fix for showing proper status for past fixtures that incorrectly show "NS"
    String displayStatus = match.fixture.status.short;
    String displayLong = match.fixture.status.long;

    if (shouldHaveStarted && displayStatus == "NS") {
      // If the match should have started but shows NS, display "Check" instead
      displayStatus = "TBD";
      displayLong = "Check status";
    }

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
          child: Column(children: [
            // Store the result of the condition in a local variable
            Builder(builder: (context) {
              final bool isLive = displayStatus == '1H' ||
                  displayStatus == '2H' ||
                  displayStatus == 'HT';
              return Column(
                children: [
                  // League name and match time/status
                  /* Row(
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

              const SizedBox(height: 16), */

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

                      // Match time/status/ score
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  match.fixture.timestamp * 1000,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isLive
                                    ? Colors.red
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isLive
                                    ? '${match.fixture.status.elapsed ?? 0}\''
                                    : displayLong,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isLive
                                      ? Colors.white
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${(match.goals.home ?? 0).toInt()} - ${(match.goals.away ?? 0).toInt()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isLive
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
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
                ],
              );
            }),
          ]),
        ),
      ),
    );
  }
}
