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

    // Fetch fixture details
    context.read<FixtureDetailsBloc>().add(
          LoadFixtureDetails(widget.fixture.fixture.id),
        );

    // Fetch predictions
    context.read<PredictionBloc>().add(
          FetchMatchPredictionEvent(matchId: widget.fixture.fixture.id),
        );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FixtureDetailsBloc>(),
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
          final prediction = state.prediction;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Winner prediction
                if (prediction.winner != null)
                  _buildPredictionCard(
                    'Match Winner',
                    prediction.winner!.name ?? 'Unknown',
                    Icons.emoji_events,
                    Colors.amber,
                  ),

                SizedBox(height: 16),

                // Win or draw prediction
                if (prediction.winOrDraw != null)
                  _buildPredictionCard(
                    'Win or Draw',
                    prediction.winOrDraw!
                        ? 'Win or Draw likely'
                        : 'Decisive result likely',
                    Icons.balance,
                    Colors.blue,
                  ),

                SizedBox(height: 16),

                // Goals prediction
                if (prediction.goals.isNotEmpty)
                  _buildPredictionCard(
                    'Total Goals',
                    '${prediction.goals['home'] ?? '0'} - ${prediction.goals['away'] ?? '0'}',
                    Icons.sports_soccer,
                    Colors.green,
                  ),

                SizedBox(height: 16),

                // Advice
                if (prediction.advice != null)
                  _buildPredictionCard(
                    'Advice',
                    prediction.advice!,
                    Icons.lightbulb,
                    Colors.orange,
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

  Widget _buildPredictionCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
