import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/shared_models.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

class SummaryTab extends StatelessWidget {
  final FixtureData fixture;

  const SummaryTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        // Show loading state
        if (state is FixtureDetailsLoading) {
          return LoadingWidget(message: 'Loading match summary...');
        }

        // Get the fixture with the most complete data using our utility
        FixtureData fixtureToUse =
            FixtureDataProvider.getBestFixtureData(context, fixture);

        // Format date properly
        String formattedDate;
        try {
          final dateTime = DateTime.parse(fixtureToUse.fixture.date);
          formattedDate =
              DateFormat('EEEE, MMM d, yyyy • HH:mm').format(dateTime);
        } catch (e) {
          formattedDate = fixtureToUse.fixture.date;
        }

        // Get events to show in summary
        final events = fixtureToUse.getEvents();
        final homeTeamEvents = events
            .where((e) => e.team.id == fixtureToUse.teams.home.id)
            .toList();
        final awayTeamEvents = events
            .where((e) => e.team.id == fixtureToUse.teams.away.id)
            .toList();

        return SingleChildScrollView(
          padding: ResponsiveHelper.getPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match Information Card
              Card(
                elevation: 2,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Match Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow(
                          Icons.calendar_today, 'Date', formattedDate),
                      SizedBox(height: 12),
                      _buildInfoRow(Icons.place, 'Venue',
                          fixtureToUse.fixture.venue.name ?? 'Unknown Stadium'),
                      SizedBox(height: 12),
                      _buildInfoRow(Icons.public, 'League',
                          '${fixtureToUse.league.name} (${fixtureToUse.league.country})'),
                      SizedBox(height: 12),
                      _buildInfoRow(Icons.sports, 'Status',
                          fixtureToUse.fixture.status.long),
                      SizedBox(height: 12),
                      if (fixtureToUse.fixture.referee != null)
                        _buildInfoRow(Icons.person, 'Referee',
                            fixtureToUse.fixture.referee!),
                    ],
                  ),
                ),
              ),

              // Team comparison card
              Card(
                elevation: 2,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team Comparison',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      fixtureToUse.teams.home.logo),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  fixtureToUse.teams.home.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color:
                                        fixtureToUse.teams.home.winner == true
                                            ? Colors.green[100]
                                            : fixtureToUse.teams.home.winner ==
                                                    false
                                                ? Colors.red[100]
                                                : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    fixtureToUse.teams.home.winner == true
                                        ? 'Winner'
                                        : fixtureToUse.teams.home.winner ==
                                                false
                                            ? 'Lost'
                                            : fixtureToUse
                                                        .fixture.status.short ==
                                                    'FT'
                                                ? 'Draw'
                                                : 'TBD',
                                    style: TextStyle(
                                      color: fixtureToUse.teams.home.winner ==
                                              true
                                          ? Colors.green[800]
                                          : fixtureToUse.teams.home.winner ==
                                                  false
                                              ? Colors.red[800]
                                              : Colors.grey[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${fixtureToUse.goals.home ?? 0} - ${fixtureToUse.goals.away ?? 0}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      fixtureToUse.teams.away.logo),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  fixtureToUse.teams.away.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color:
                                        fixtureToUse.teams.away.winner == true
                                            ? Colors.green[100]
                                            : fixtureToUse.teams.away.winner ==
                                                    false
                                                ? Colors.red[100]
                                                : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    fixtureToUse.teams.away.winner == true
                                        ? 'Winner'
                                        : fixtureToUse.teams.away.winner ==
                                                false
                                            ? 'Lost'
                                            : fixtureToUse
                                                        .fixture.status.short ==
                                                    'FT'
                                                ? 'Draw'
                                                : 'TBD',
                                    style: TextStyle(
                                      color: fixtureToUse.teams.away.winner ==
                                              true
                                          ? Colors.green[800]
                                          : fixtureToUse.teams.away.winner ==
                                                  false
                                              ? Colors.red[800]
                                              : Colors.grey[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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

              // Key Events card (if available)
              if (events.isNotEmpty)
                Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Events',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Timeline of important events (goals, cards, etc)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Home team events
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: homeTeamEvents.isEmpty
                                    ? [
                                        Text(
                                          'No events',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ]
                                    : homeTeamEvents
                                        .map((e) => _buildEventItem(
                                              e,
                                              isHomeTeam: true,
                                              team: fixtureToUse.teams.home,
                                            ))
                                        .toList(),
                              ),
                            ),

                            // Timeline indicator
                            Container(
                              width: 2,
                              height: 200, // Adjust based on content
                              color: Colors.grey[300],
                              margin: EdgeInsets.symmetric(horizontal: 16),
                            ),

                            // Away team events
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: awayTeamEvents.isEmpty
                                    ? [
                                        Text(
                                          'No events',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ]
                                    : awayTeamEvents
                                        .map((e) => _buildEventItem(
                                              e,
                                              isHomeTeam: false,
                                              team: fixtureToUse.teams.away,
                                            ))
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventItem(Event event,
      {required bool isHomeTeam, required Team team}) {
    IconData icon;
    Color color;

    // Determine icon and color based on event type
    switch (event.type.toLowerCase()) {
      case 'goal':
        icon = Icons.sports_soccer;
        color = Colors.green;
        break;
      case 'card':
        icon = Icons.credit_card;
        color = event.detail.toLowerCase().contains('yellow')
            ? Colors.amber
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

    // Format the text for the event
    String eventText;
    if (event.type.toLowerCase() == 'goal') {
      eventText = '${event.player.name} (${event.detail})';
    } else if (event.type.toLowerCase() == 'card') {
      eventText = '${event.player.name} (${event.detail})';
    } else if (event.type.toLowerCase() == 'subst') {
      // For substitutions, display the player coming in and the player going out
      final assistName = event.assist != null ? event.assist!.name : "Out";
      eventText = '${event.player.name} for $assistName';
    } else {
      eventText = event.detail;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isHomeTeam ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isHomeTeam) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  eventText,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "${event.time.elapsed}'",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 14,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, size: 16, color: color),
            ),
          ] else ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, size: 16, color: color),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventText,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "${event.time.elapsed}'",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
