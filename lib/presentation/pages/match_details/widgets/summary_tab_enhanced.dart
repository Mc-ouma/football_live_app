import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

class SummaryTabEnhanced extends StatelessWidget {
  final FixtureData fixture;

  const SummaryTabEnhanced({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return const LoadingWidget(message: 'Loading match summary...');
        }

        // Show error state with retry button
        if (state is FixtureDetailsError) {
          return ErrorDisplayWidget(
            message: 'Failed to load match summary: ${state.message}',
            onRetry: () {
              // Retry loading fixture details using our provider
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            },
          );
        }

        // Get the fixture with the most complete data using our utility
        FixtureData fixtureToUse =
            FixtureDataProvider.getBestFixtureData(context, fixture);

        // Log data availability for debugging
        print(
            '📊 SummaryTabEnhanced: Analyzing data for fixture ID ${fixtureToUse.fixture.id}:');
        print(
            '   - Events available: ${FixtureDataProvider.hasEventsData(fixtureToUse)} (${fixtureToUse.getEvents().length} events)');
        print(
            '   - Statistics available: ${FixtureDataProvider.hasStatisticsData(fixtureToUse)}');
        print(
            '   - Match status: ${fixtureToUse.fixture.status.short} (${fixtureToUse.fixture.status.long})');
        print('   - Has detailed data: ${fixtureToUse.hasDetailedData}');

        // Only request more data if we don't have basic fixture info or events
        bool shouldRequestData = false;
        if (!FixtureDataProvider.hasEventsData(fixtureToUse) &&
            state is! FixtureDetailsLoading) {
          shouldRequestData = true;
          print(
              '⚠️  SummaryTabEnhanced: No events data found for match ID: ${fixture.fixture.id}, requesting data...');
        }

        // Use post-frame callback to avoid calling during build
        if (shouldRequestData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              FixtureDataProvider.requestFixtureRefresh(
                  context, fixture.fixture.id);
            }
          });
        }

        // Get comprehensive match summary from our provider
        final summary = FixtureDataProvider.getMatchSummary(fixtureToUse);
        final events = FixtureDataProvider.getSortedEvents(fixtureToUse);

        return SingleChildScrollView(
          padding: ResponsiveHelper.getPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Match Status Card
              _buildMatchStatusCard(context, fixtureToUse, summary),

              const SizedBox(height: 16),

              // Match Information Card
              _buildMatchInfoCard(context, fixtureToUse),

              const SizedBox(height: 16),

              // Quick Stats Card (if available)
              if (summary['homeGoals'] != null && summary['awayGoals'] != null)
                _buildQuickStatsCard(context, fixtureToUse, summary),

              const SizedBox(height: 16),

              // Key Events Timeline
              _buildKeyEventsTimeline(context, events, fixtureToUse),

              const SizedBox(height: 16),

              // Team Performance Summary (if stats available)
              if (fixtureToUse.getStatistics() != null)
                _buildTeamPerformanceCard(context, fixtureToUse),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMatchStatusCard(
      BuildContext context, FixtureData fixture, dynamic summary) {
    final isLive = FixtureDataProvider.isMatchLive(fixture);
    final status = fixture.fixture.status;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isLive
              ? LinearGradient(
                  colors: [Colors.red.shade100, Colors.red.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.blue.shade100, Colors.blue.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Live indicator
              if (isLive)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // Teams and Score
              Row(
                children: [
                  // Home Team
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(fixture.teams.home.logo),
                          radius: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          fixture.teams.home.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Score
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${summary['homeGoals'] ?? '-'} : ${summary['awayGoals'] ?? '-'}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          status.long,
                          style: TextStyle(
                            fontSize: 14,
                            color: isLive
                                ? Colors.red.shade700
                                : Colors.grey.shade600,
                            fontWeight:
                                isLive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (isLive && status.elapsed != null)
                          Text(
                            "${status.elapsed}'",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Away Team
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(fixture.teams.away.logo),
                          radius: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          fixture.teams.away.name,
                          style: const TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchInfoCard(BuildContext context, FixtureData fixture) {
    String formattedDate;
    try {
      final dateTime = DateTime.parse(fixture.fixture.date);
      formattedDate = DateFormat('EEEE, MMM d, yyyy • HH:mm').format(dateTime);
    } catch (e) {
      formattedDate = fixture.fixture.date;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Match Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.calendar_today, 'Date', formattedDate),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.place, 'Venue',
                '${fixture.fixture.venue.name}, ${fixture.fixture.venue.city}'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.sports_soccer, 'League',
                '${fixture.league.name} (${fixture.league.country})'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.person, 'Referee',
                fixture.fixture.referee ?? 'Not assigned'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsCard(
      BuildContext context, FixtureData fixture, dynamic summary) {
    final stats = fixture.getStatistics();
    if (stats == null) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Stats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            // Add possession, shots, etc. from stats
            if (stats.home != null && stats.away != null)
              _buildQuickStatRows(stats.home!, stats.away!),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatRows(
      List<TeamStatistics> homeStats, List<TeamStatistics> awayStats) {
    // Find common stats to display
    final commonStats = ['Ball Possession', 'Total Shots', 'Shots on Goal'];

    return Column(
      children: commonStats.map((statName) {
        final homeStat = homeStats.firstWhere(
          (s) => s.type == statName,
          orElse: () => TeamStatistics(type: statName, value: null),
        );
        final awayStat = awayStats.firstWhere(
          (s) => s.type == statName,
          orElse: () => TeamStatistics(type: statName, value: null),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildStatRow(
            statName,
            homeStat.value?.toString() ?? '0',
            awayStat.value?.toString() ?? '0',
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatRow(String label, String homeValue, String awayValue) {
    return Row(
      children: [
        Expanded(
          child: Text(
            homeValue,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            awayValue,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyEventsTimeline(
      BuildContext context, List<Event> events, FixtureData fixture) {
    if (events.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.sports_soccer_outlined,
                  size: 48, color: Colors.grey[400]),
              const SizedBox(height: 8),
              const Text(
                'No events yet',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Events will appear as they occur during the match',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Show only key events (goals, cards, substitutions)
    final keyEvents = events
        .where((event) =>
            ['goal', 'card', 'subst'].contains(event.type.toLowerCase()))
        .take(5)
        .toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Key Events',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ...keyEvents
                .map((event) => _buildEventRow(event, fixture))
                .toList(),
            if (events.length > keyEvents.length)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '... and ${events.length - keyEvents.length} more events',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventRow(Event event, FixtureData fixture) {
    final isHomeTeam = event.team.id == fixture.teams.home.id;

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
            ? Colors.orange
            : Colors.red;
        break;
      case 'subst':
        icon = Icons.swap_horiz;
        color = Colors.blue;
        break;
      default:
        icon = Icons.sports;
        color = Colors.grey;
    }

    String eventText;
    if (event.type.toLowerCase() == 'goal') {
      eventText = '${event.player.name} ${event.detail}';
    } else if (event.type.toLowerCase() == 'card') {
      eventText = '${event.player.name} (${event.detail})';
    } else if (event.type.toLowerCase() == 'subst') {
      final assistName = event.assist?.name ?? "Unknown";
      eventText = '${event.player.name} ↔ $assistName';
    } else {
      eventText = event.detail;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${event.time.elapsed}' • ${isHomeTeam ? fixture.teams.home.name : fixture.teams.away.name}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPerformanceCard(BuildContext context, FixtureData fixture) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Team Performance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap Stats tab for detailed analysis',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
