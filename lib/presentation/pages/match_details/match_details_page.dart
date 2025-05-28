import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';

class MatchDetailsPage extends StatefulWidget {
  final FixtureData fixture;

  const MatchDetailsPage({Key? key, required this.fixture}) : super(key: key);

  @override
  _MatchDetailsPageState createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<FixtureDetailsBloc>()
            ..add(LoadFixtureDetails(widget.fixture.fixture.id)),
        ),
        BlocProvider(
          create: (_) => getIt<PredictionBloc>()
            ..add(
                FetchMatchPredictionEvent(matchId: widget.fixture.fixture.id)),
        ),
      ],
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
                    builder: (context, state) {
                      if (state is FixtureDetailsLoaded) {
                        return _MatchScoreHeader(fixture: state.fixture);
                      }
                      return _MatchScoreHeader(fixture: widget.fixture);
                    },
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Summary'),
                    Tab(text: 'Events'),
                    Tab(text: 'Predictions'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _SummaryTab(fixture: widget.fixture),
              _EventsTab(fixture: widget.fixture),
              _PredictionsTab(fixtureId: widget.fixture.fixture.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchScoreHeader extends StatelessWidget {
  final FixtureData fixture;

  const _MatchScoreHeader({Key? key, required this.fixture}) : super(key: key);

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

class _SummaryTab extends StatelessWidget {
  final FixtureData fixture;

  const _SummaryTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Match Information',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),

          _buildInfoRow('League', fixture.league.name),
          _buildInfoRow(
              'Date', DateTime.parse(fixture.fixture.date).toString()),
          if (fixture.fixture.referee != null)
            _buildInfoRow('Referee', fixture.fixture.referee!),

          SizedBox(height: 24),

          // Team comparison
          Text(
            'Team Comparison',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
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
                      backgroundImage: NetworkImage(fixture.teams.home.logo),
                    ),
                    SizedBox(height: 8),
                    Text(
                      fixture.teams.home.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Text(
                'VS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(fixture.teams.away.logo),
                    ),
                    SizedBox(height: 8),
                    Text(
                      fixture.teams.away.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class _EventsTab extends StatelessWidget {
  final FixtureData fixture;

  const _EventsTab({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
      builder: (context, state) {
        List<Event> events = [];

        // Try to get events from detailed fixture data
        if (state is FixtureDetailsLoaded) {
          // Check if the loaded fixture has events (when it's a detailed fixture)
          final loadedFixture = state.fixture;
          // Check if this fixture has events by using the when method
          events = loadedFixture.when(
            detailed: (fixture, league, teams, goals, score, events, lineups,
                    statistics, players) =>
                events ?? [],
            live: (fixture, league, teams, goals, score, events) => events,
            (fixture, league, teams, goals, score) => <Event>[],
          );
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

class _PredictionsTab extends StatelessWidget {
  final int fixtureId;

  const _PredictionsTab({Key? key, required this.fixtureId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        if (state is PredictionLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PredictionLoaded) {
          // Use the prediction data from the state for dynamic content if needed
          // final prediction = state.prediction;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Match Winner Section
                _buildPredictionSection(
                  context,
                  title: "Match Winner",
                  icon: Icons.help_outline,
                  children: [
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "1",
                          odd: "2.57",
                          percentage: "41%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "X",
                          odd: "3.2",
                          percentage: "26%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "2",
                          odd: "2.6",
                          percentage: "33%",
                          isSelected: true,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Double Chance Section
                _buildPredictionSection(
                  context,
                  title: "Double Chance",
                  icon: Icons.help_outline,
                  children: [
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "1X",
                          odd: "1.46",
                          percentage: "40%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "12",
                          odd: "1.32",
                          percentage: "79%",
                          isSelected: true,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "2X",
                          odd: "1.47",
                          percentage: "84%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Both Teams Score Section
                _buildPredictionSection(
                  context,
                  title: "Both Teams Score",
                  icon: Icons.help_outline,
                  children: [
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "YES",
                          odd: "1.87",
                          percentage: "38%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "NO",
                          odd: "1.84",
                          percentage: "62%",
                          isSelected: true,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Goals Over/Under Section
                _buildPredictionSection(
                  context,
                  title: "Goals Over/Under",
                  icon: Icons.help_outline,
                  children: [
                    // First Row
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Over 0.5",
                          odd: "1.05",
                          percentage: "91%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "Under 0.5",
                          odd: "7.95",
                          percentage: "9%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Over 1.5",
                          odd: "1.37",
                          percentage: "71%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Second Row
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Under 1.5",
                          odd: "2.85",
                          percentage: "29%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Over 2.5",
                          odd: "2.15",
                          percentage: "45%",
                          isSelected: true,
                        ),
                        PredictionOddsItem(
                          label: "Under 2.5",
                          odd: "1.64",
                          percentage: "55%",
                          isSelected: false,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Third Row
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Over 3.5",
                          odd: "3.94",
                          percentage: "24%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Under 3.5",
                          odd: "1.21",
                          percentage: "76%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "Over 4.5",
                          odd: "8.09",
                          percentage: "11%",
                          isSelected: false,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Fourth Row
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Under 4.5",
                          odd: "1.05",
                          percentage: "89%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "Over 5.5",
                          odd: "15.81",
                          percentage: "4%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Under 5.5",
                          odd: "1.02",
                          percentage: "96%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Fifth Row
                    _buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Over 6.5",
                          odd: "41",
                          percentage: "2%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Under 6.5",
                          odd: "1",
                          percentage: "98%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                      ],
                      itemCount: 2,
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Legend Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(context,
                          color: Colors.purple.shade300,
                          text: "The match is not finished yet"),
                      SizedBox(height: 12),
                      _buildLegendItem(context,
                          color: Colors.purple, text: "Optimal"),
                      SizedBox(height: 12),
                      _buildLegendItem(context,
                          color: Colors.green,
                          text:
                              "The match is over and the prediction was correct"),
                      SizedBox(height: 12),
                      _buildLegendItem(context,
                          color: Colors.red.shade400,
                          text:
                              "The match is over and the prediction was wrong"),
                      SizedBox(height: 24),
                      _buildLegendRowItem(context,
                          label: "1X", text: "Prediction type"),
                      SizedBox(height: 12),
                      _buildLegendRowItem(context,
                          label: "85%", text: "Probability according to AI"),
                      SizedBox(height: 12),
                      _buildLegendRowItem(context,
                          label: "1.34", text: "Average odd"),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is PredictionError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text('Error loading predictions: ${state.message}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PredictionBloc>().add(
                          FetchMatchPredictionEvent(matchId: fixtureId),
                        );
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Center(child: Text('No predictions available'));
      },
    );
  }

  Widget _buildPredictionSection(BuildContext context,
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(width: 8),
              Icon(icon, color: Colors.grey, size: 20),
            ],
          ),
        ),
        SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildOddsRow(
    BuildContext context, {
    required List<PredictionOddsItem> items,
    int itemCount = 3,
  }) {
    return Row(
      children: [
        for (int i = 0; i < items.length; i++)
          Expanded(
            flex: 1,
            child: _buildOddItem(context, items[i]),
          ),

        // Add empty boxes to fill the row if items.length < itemCount
        if (items.length < itemCount)
          for (int i = 0; i < itemCount - items.length; i++)
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
      ],
    );
  }

  Widget _buildOddItem(BuildContext context, PredictionOddsItem item) {
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor =
        item.isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent;
    final borderRadius = BorderRadius.circular(8);
    final borderColor = item.isSelected ? primaryColor : Colors.grey.shade300;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                item.label,
                style: TextStyle(
                  color: item.isSelected ? primaryColor : Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(7)),
            ),
            child: Column(
              children: [
                Text(
                  item.odd,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.showHighlight)
                      Icon(
                        Icons.bolt,
                        color: item.highlightColor,
                        size: 14,
                      ),
                    SizedBox(width: item.showHighlight ? 4 : 0),
                    Text(
                      item.percentage,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context,
      {required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendRowItem(BuildContext context,
      {required String label, required String text}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to determine text color based on item state
  Color _getTextColor(BuildContext context, PredictionOddsItem item) {
    switch (item.validationStatus) {
      case ValidationStatus.correct:
        return Colors.green.shade800;
      case ValidationStatus.incorrect:
        return Colors.red.shade800;
      default:
        if (item.isApiSuggestedPick) {
          return Colors.purple.shade800;
        }
        return item.isSelected ? Theme.of(context).primaryColor : Colors.black87;
    }
  }

  // Helper method to create the appropriate status icon
  Widget _buildStatusIcon(PredictionOddsItem item) {
    // First handle validation status icons
    switch (item.validationStatus) {
      case ValidationStatus.correct:
        return Icon(Icons.check_circle, color: Colors.green, size: 14);
      case ValidationStatus.incorrect:
        return Icon(Icons.cancel, color: Colors.red, size: 14);
      case ValidationStatus.pending:
      case ValidationStatus.unknown:
      default:
        // Then handle highlighting and API recommendations
        if (item.showHighlight) {
          return Icon(Icons.bolt, color: item.highlightColor, size: 14);
        } else if (item.isApiSuggestedPick) {
          return Icon(Icons.smart_toy, color: Colors.purple, size: 14);
        }
        return SizedBox(width: 0); // No icon
    }
  }
}

// A class to represent prediction odds item with its properties
class PredictionOddsItem {
  final String label;
  final String odd;
  final String percentage;
  final bool isSelected;
  final bool showHighlight;
  final Color highlightColor;
  
  // New fields for prediction validation
  final bool isApiSuggestedPick; // Whether this is suggested by the API
  final ValidationStatus validationStatus; // Status of prediction validation
  final DateTime? predictionTimestamp; // When the prediction was made

  PredictionOddsItem({
    required this.label,
    required this.odd,
    required this.percentage,
    this.isSelected = false,
    this.showHighlight = false,
    this.highlightColor = Colors.green,
    this.isApiSuggestedPick = false,
    this.validationStatus = ValidationStatus.pending,
    this.predictionTimestamp,
  });
}

// Enum to represent the validation status of a prediction
enum ValidationStatus {
  pending, // Match not yet completed
  correct, // Prediction was correct
  incorrect, // Prediction was incorrect
  unknown // Unable to validate (e.g. API error, insufficient data)
}
