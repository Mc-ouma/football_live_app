import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/widgets/prediction_badge.dart';

class MatchDetailsPage extends StatefulWidget {
  final int matchId;

  const MatchDetailsPage({
    super.key,
    required this.matchId,
  });

  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Fetch prediction for this match when the page loads
    context
        .read<PredictionBloc>()
        .add(FetchMatchPredictionEvent(matchId: widget.matchId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 240,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Match Details',
                  style: TextStyle(
                    color: innerBoxIsScrolled
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: _MatchScoreHeader(),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Add to favorites
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorites')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Share match
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Share functionality to be implemented')),
                    );
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'SUMMARY'),
                  Tab(text: 'STATS'),
                  Tab(text: 'LINEUPS'),
                  Tab(text: 'H2H'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _SummaryTab(matchId: widget.matchId),
            _StatsTab(matchId: widget.matchId),
            _LineupsTab(matchId: widget.matchId),
            _HeadToHeadTab(matchId: widget.matchId),
          ],
        ),
      ),
    );
  }
}

class _MatchScoreHeader extends StatelessWidget {
  const _MatchScoreHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // League and stadium info
          Text(
            'Premier League - Matchday 10',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Emirates Stadium',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),

          // Teams and score
          Row(
            children: [
              // Home team
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                      child: Icon(Icons.shield, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Arsenal',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

              // Score
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      '2 - 0',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'LIVE 75\'',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Away team
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                      child: Icon(Icons.shield, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Chelsea',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
}

class _SummaryTab extends StatelessWidget {
  final int matchId;

  const _SummaryTab({required this.matchId});

  @override
  Widget build(BuildContext context) {
    // Placeholder for match timeline/events
    final events = [
      {
        'type': 'Goal',
        'minute': 23,
        'team': 'home',
        'playerName': 'Saka',
        'detail': 'Right-footed shot from inside the box'
      },
      {
        'type': 'YellowCard',
        'minute': 37,
        'team': 'away',
        'playerName': 'Silva',
        'detail': 'Foul on Martinelli'
      },
      {
        'type': 'Goal',
        'minute': 54,
        'team': 'home',
        'playerName': 'Ødegaard',
        'detail': 'Penalty kick, bottom left corner'
      },
      {
        'type': 'Substitution',
        'minute': 67,
        'team': 'away',
        'playerName': 'Palmer',
        'detail': 'Replaces Mount'
      },
    ];

    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, predictionState) {
        // Trigger prediction fetch if not already done
        if (predictionState is PredictionInitial) {
          context
              .read<PredictionBloc>()
              .add(FetchMatchPredictionEvent(matchId: matchId));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Match prediction section - show for upcoming matches
            if (predictionState is PredictionLoaded) ...[
              _buildPredictionCard(context, predictionState.prediction),
              const SizedBox(height: 20),
            ] else if (predictionState is PredictionLoading) ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],

            // Match timeline
            ...events.map((event) => _buildEventItem(context, event)).toList(),

            const SizedBox(height: 20),

            // Match commentary
            Text(
              'Commentary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Arsenal in complete control as we pass the 75-minute mark. Chelsea struggling to create any meaningful chances in the second half.',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPredictionCard(BuildContext context, Prediction prediction) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side:
            BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Match Prediction',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                PredictionBadge(prediction: prediction),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Team Win Probabilities',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Team probabilities
            _buildTeamProbabilityBar(
              context: context,
              teamName: 'Home Team',
              probability: prediction.getHomeWinProbability(),
              isHome: true,
            ),
            const SizedBox(height: 8),
            _buildTeamProbabilityBar(
              context: context,
              teamName: 'Away Team',
              probability: prediction.getAwayWinProbability(),
              isHome: false,
            ),
            const SizedBox(height: 8),
            _buildTeamProbabilityBar(
              context: context,
              teamName: 'Draw',
              probability: prediction.getDrawProbability(),
              isDraw: true,
            ),

            const SizedBox(height: 16),
            if (prediction.goals['home'] != null &&
                prediction.goals['away'] != null) ...[
              Text(
                'Predicted Score',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  prediction.getPredictedScore(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Confidence: ${(prediction.getConfidenceScore() * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // We no longer have updatedAt in the Prediction entity
            // Instead, show advice if available
            if (prediction.advice != null) ...[
              const SizedBox(height: 12),
              Text(
                'Advice: ${prediction.advice}',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTeamProbabilityBar({
    required BuildContext context,
    required String teamName,
    required double probability,
    bool isHome = false,
    bool isDraw = false,
  }) {
    Color barColor;
    if (isDraw) {
      barColor = Colors.amber;
    } else if (isHome) {
      barColor = Theme.of(context).colorScheme.primary;
    } else {
      barColor = Theme.of(context).colorScheme.secondary;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: probability,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                  minHeight: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(probability * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: barColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventItem(BuildContext context, Map<String, dynamic> event) {
    IconData getEventIcon() {
      switch (event['type']) {
        case 'Goal':
          return Icons.sports_soccer;
        case 'YellowCard':
          return Icons.square;
        case 'RedCard':
          return Icons.square;
        case 'Substitution':
          return Icons.swap_horiz;
        default:
          return Icons.circle;
      }
    }

    Color getEventColor() {
      switch (event['type']) {
        case 'Goal':
          return Colors.green;
        case 'YellowCard':
          return Colors.amber;
        case 'RedCard':
          return Colors.red;
        case 'Substitution':
          return Colors.blue;
        default:
          return Colors.grey;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 40,
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${event['minute']}\'',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Event details
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: getEventColor().withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getEventIcon(),
                      color: getEventColor(),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['playerName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['detail'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsTab extends StatelessWidget {
  final int matchId;

  const _StatsTab({required this.matchId});

  @override
  Widget build(BuildContext context) {
    // Placeholder for match statistics
    final stats = [
      {'name': 'Possession', 'home': 65, 'away': 35},
      {'name': 'Shots', 'home': 15, 'away': 6},
      {'name': 'Shots on Target', 'home': 7, 'away': 2},
      {'name': 'Corners', 'home': 8, 'away': 3},
      {'name': 'Fouls', 'home': 9, 'away': 12},
      {'name': 'Yellow Cards', 'home': 1, 'away': 3},
      {'name': 'Offsides', 'home': 2, 'away': 1},
      {'name': 'Passes', 'home': 547, 'away': 328},
      {'name': 'Pass Accuracy', 'home': 89, 'away': 76},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...stats.map((stat) => _buildStatItem(context, stat)).toList(),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, Map<String, dynamic> stat) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat['home'].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                stat['name'],
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 13,
                ),
              ),
              Text(
                stat['away'].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: stat['home'] is int
                        ? stat['home']
                        : (stat['home'] * 100).toInt(),
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    flex: stat['away'] is int
                        ? stat['away']
                        : (stat['away'] * 100).toInt(),
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineupsTab extends StatelessWidget {
  final int matchId;

  const _LineupsTab({required this.matchId});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Lineups tab - to be implemented'),
    );
  }
}

class _HeadToHeadTab extends StatelessWidget {
  final int matchId;

  const _HeadToHeadTab({required this.matchId});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Head to Head tab - to be implemented'),
    );
  }
}
