import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/models/prediction_odds_item.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/prediction_widgets.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class PredictionsTabEnhanced extends StatelessWidget {
  final int fixtureId;
  final FixtureData? fixture;

  const PredictionsTabEnhanced({
    Key? key,
    required this.fixtureId,
    this.fixture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        if (state is PredictionLoading) {
          return const LoadingWidget(message: 'Loading match predictions...');
        } else if (state is PredictionError) {
          return ErrorDisplayWidget(
            message: 'Failed to load predictions: ${state.message}',
            onRetry: () {
              // Retry loading predictions
              context.read<PredictionBloc>().add(
                    FetchMatchPredictionEvent(matchId: fixtureId),
                  );
            },
          );
        } else if (state is PredictionLoaded) {
          return _buildPredictionsContent(context, state);
        }

        // If no state or initial state, try to load predictions
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.read<PredictionBloc>().add(
                  FetchMatchPredictionEvent(matchId: fixtureId),
                );
          }
        });

        return const LoadingWidget(message: 'Loading predictions...');
      },
    );
  }

  Widget _buildPredictionsContent(
      BuildContext context, PredictionLoaded state) {
    final isLive = fixture != null && FixtureDataProvider.isMatchLive(fixture!);

    // If match is live or finished, show different content
    if (isLive) {
      return _buildLiveMatchContent(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Match prediction header
          _buildPredictionHeader(context),

          const SizedBox(height: 24),

          // Match confidence indicator
          _buildConfidenceIndicator(context),

          const SizedBox(height: 24),

          // Match Winner Section
          buildPredictionSection(
            context,
            title: "Match Winner",
            icon: Icons.emoji_events,
            children: [
              buildOddsRow(
                context,
                items: [
                  PredictionOddsItem(
                    label: fixture?.teams.home.name ?? "Home",
                    odd: "2.57",
                    percentage: "41%",
                    isSelected: false,
                  ),
                  PredictionOddsItem(
                    label: "Draw",
                    odd: "3.2",
                    percentage: "26%",
                    isSelected: false,
                  ),
                  PredictionOddsItem(
                    label: fixture?.teams.away.name ?? "Away",
                    odd: "2.6",
                    percentage: "33%",
                    isSelected: true,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Goals predictions
          _buildGoalsPredictions(context),

          const SizedBox(height: 24),

          // Both teams to score
          buildPredictionSection(
            context,
            title: "Both Teams to Score",
            icon: Icons.sports_soccer,
            children: [
              buildOddsRow(
                context,
                items: [
                  PredictionOddsItem(
                    label: "Yes",
                    odd: "1.85",
                    percentage: "65%",
                    isSelected: true,
                    showHighlight: true,
                    highlightColor: Colors.green,
                  ),
                  PredictionOddsItem(
                    label: "No",
                    odd: "1.95",
                    percentage: "35%",
                    isSelected: false,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Double Chance Section
          buildPredictionSection(
            context,
            title: "Double Chance",
            icon: Icons.casino,
            children: [
              buildOddsRow(
                context,
                items: [
                  PredictionOddsItem(
                    label: "1X",
                    odd: "1.46",
                    percentage: "67%",
                    isSelected: false,
                  ),
                  PredictionOddsItem(
                    label: "12",
                    odd: "1.32",
                    percentage: "74%",
                    isSelected: true,
                    showHighlight: true,
                    highlightColor: Colors.green,
                  ),
                  PredictionOddsItem(
                    label: "2X",
                    odd: "1.47",
                    percentage: "59%",
                    isSelected: false,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Match insights
          _buildMatchInsights(context),

          const SizedBox(height: 24),

          // Disclaimer
          _buildDisclaimer(context),
        ],
      ),
    );
  }

  Widget _buildPredictionHeader(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).primaryColor.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.psychology,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Predictions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on team performance, head-to-head records, and current form',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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

  Widget _buildConfidenceIndicator(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: Colors.green[600]),
                const SizedBox(width: 8),
                const Text(
                  'Prediction Confidence',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.78,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green[600]!),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '78%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'High confidence prediction based on recent form and statistics',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsPredictions(BuildContext context) {
    return buildPredictionSection(
      context,
      title: "Total Goals",
      icon: Icons.sports_soccer,
      children: [
        buildOddsRow(
          context,
          items: [
            PredictionOddsItem(
              label: "Under 2.5",
              odd: "2.1",
              percentage: "42%",
              isSelected: false,
            ),
            PredictionOddsItem(
              label: "Over 2.5",
              odd: "1.75",
              percentage: "58%",
              isSelected: true,
              showHighlight: true,
              highlightColor: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 12),
        buildOddsRow(
          context,
          items: [
            PredictionOddsItem(
              label: "Under 1.5",
              odd: "4.2",
              percentage: "18%",
              isSelected: false,
            ),
            PredictionOddsItem(
              label: "Over 1.5",
              odd: "1.2",
              percentage: "82%",
              isSelected: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMatchInsights(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber[600]),
                const SizedBox(width: 8),
                const Text(
                  'Match Insights',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
              Icons.trending_up,
              'Recent Form',
              '${fixture?.teams.away.name ?? "Away team"} has won 4 of their last 5 matches',
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              Icons.sports_soccer,
              'Goals Average',
              'Both teams average 2.3 goals per match in recent games',
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              Icons.history,
              'Head-to-Head',
              'Last 5 meetings: 2 wins each, 1 draw',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(
      IconData icon, String title, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiveMatchContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.live_tv,
              size: 48,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Match is Live!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Predictions are not available for live matches.\nCheck the other tabs for live match data.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Live updates available in Events tab',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.grey[600], size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Predictions are for entertainment purposes only. Please gamble responsibly.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
