import 'package:flutter/material.dart';
import 'package:football_live_app/domain/entities/prediction.dart';

class PredictionIndicator extends StatelessWidget {
  final Prediction prediction;
  final bool miniVersion;

  const PredictionIndicator({
    super.key,
    required this.prediction,
    this.miniVersion = false,
  });

  @override
  Widget build(BuildContext context) {
    if (miniVersion) {
      return _buildMiniPredictor(context);
    } else {
      return _buildFullPredictor(context);
    }
  }

  Widget _buildMiniPredictor(BuildContext context) {
    final winner = prediction.getPredictedWinner();
    Color indicatorColor;
    IconData indicatorIcon;
    String winnerText;

    switch (winner) {
      case WinnerType.home:
        indicatorColor = Colors.blue;
        indicatorIcon = Icons.home;
        winnerText = "H";
        break;
      case WinnerType.away:
        indicatorColor = Colors.red;
        indicatorIcon = Icons.airplanemode_active;
        winnerText = "A";
        break;
      case WinnerType.draw:
        indicatorColor = Colors.amber;
        indicatorIcon = Icons.compare_arrows;
        winnerText = "D";
        break;
      default:
        indicatorColor = Colors.grey;
        indicatorIcon = Icons.help_outline;
        winnerText = "?";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: indicatorColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: indicatorColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            indicatorIcon,
            size: 16,
            color: indicatorColor,
          ),
          const SizedBox(width: 4),
          Text(
            winnerText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: indicatorColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullPredictor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Match Prediction',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Main prediction card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Winner
              if (prediction.winnerTeamName != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Predicted Winner:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      prediction.winnerTeamName!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getWinnerColor(prediction.getPredictedWinner()),
                      ),
                    ),
                  ],
                ),
                if (prediction.winnerComment != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    prediction.winnerComment!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],

              const SizedBox(height: 12),

              // Win probabilities
              Text(
                'Win Probabilities',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: (prediction.getHomeWinProbability() * 100).round(),
                    child: Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (prediction.getDrawProbability() * 100).round(),
                    child: Container(
                      height: 8,
                      color: Colors.amber,
                    ),
                  ),
                  Expanded(
                    flex: (prediction.getAwayWinProbability() * 100).round(),
                    child: Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home: ${prediction.winPercentages['home']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Draw: ${prediction.winPercentages['draw']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    'Away: ${prediction.winPercentages['away']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Additional predictions
        if (prediction.underOver != null || prediction.advice != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (prediction.underOver != null) ...[
                  Text(
                    'Goals Over/Under: ${prediction.underOver}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (prediction.advice != null) ...[
                  if (prediction.underOver != null) const SizedBox(height: 8),
                  Text(
                    prediction.advice!,
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
        ],

        // Prediction confidence
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'AI Confidence: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Expanded(
              child: LinearProgressIndicator(
                value: prediction.getConfidenceScore(),
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                color: _getConfidenceColor(prediction.getConfidenceScore()),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(prediction.getConfidenceScore() * 100).round()}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _getConfidenceColor(prediction.getConfidenceScore()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getWinnerColor(WinnerType winner) {
    switch (winner) {
      case WinnerType.home:
        return Colors.blue;
      case WinnerType.away:
        return Colors.red;
      case WinnerType.draw:
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.7) {
      return Colors.green;
    } else if (confidence >= 0.5) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }
}
