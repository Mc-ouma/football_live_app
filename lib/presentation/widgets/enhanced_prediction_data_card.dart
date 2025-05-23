import 'package:flutter/material.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:intl/intl.dart';

enum WinnerType { home, away, draw, none }

class EnhancedPredictionDataCard extends StatelessWidget {
  final PredictionData predictionData;
  final VoidCallback onTap;

  const EnhancedPredictionDataCard({
    Key? key,
    required this.predictionData,
    required this.onTap,
  }) : super(key: key);

  String _formatMatchDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final matchDate = DateTime(date.year, date.month, date.day);

    if (matchDate == today) {
      return 'Today, ${DateFormat('HH:mm').format(date)}';
    } else if (matchDate == tomorrow) {
      return 'Tomorrow, ${DateFormat('HH:mm').format(date)}';
    } else {
      return DateFormat('EEE, MMM d • HH:mm').format(date);
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.7) {
      return Colors.green.shade700;
    } else if (confidence >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.red.shade400;
    }
  }

  // Get the predicted winner
  WinnerType getPredictedWinner() {
    final winnerStr = predictionData.predictions.winner.toLowerCase();

    if (winnerStr.contains('home')) {
      return WinnerType.home;
    } else if (winnerStr.contains('away')) {
      return WinnerType.away;
    } else if (winnerStr.contains('draw')) {
      return WinnerType.draw;
    } else {
      return WinnerType.none;
    }
  }

  // Get the confidence score from percentages
  double getConfidenceScore() {
    final winnerType = getPredictedWinner();
    final percentages = predictionData.predictions.winnerSide;

    switch (winnerType) {
      case WinnerType.home:
        return _parsePercentage(percentages.home);
      case WinnerType.away:
        return _parsePercentage(percentages.away);
      case WinnerType.draw:
        return _parsePercentage(percentages.draw);
      default:
        return 0.0;
    }
  }

  // Helper to parse percentage strings from the API
  double _parsePercentage(String percentStr) {
    final cleanStr = percentStr.replaceAll('%', '').trim();
    try {
      return double.parse(cleanStr) / 100;
    } catch (e) {
      return 0.0;
    }
  }

  // Helper to get predicted score (if available)
  String getPredictedScore() {
    // If goals prediction is not available, return 'N/A'
    if (!predictionData.predictions.goals) {
      return 'N/A';
    }

    // In the freezed model, we don't have direct access to predicted goals
    // We could attempt to derive this from other prediction fields if available
    return 'Score prediction unavailable';
  }

  Widget _buildPredictionIndicator() {
    final winnerType = getPredictedWinner();
    final confidenceScore = getConfidenceScore();
    final confidenceColor = _getConfidenceColor(confidenceScore);

    String confidenceText;
    if (confidenceScore >= 0.7) {
      confidenceText = 'High Confidence';
    } else if (confidenceScore >= 0.5) {
      confidenceText = 'Medium Confidence';
    } else {
      confidenceText = 'Low Confidence';
    }

    String winnerText;
    switch (winnerType) {
      case WinnerType.home:
        winnerText = predictionData.teams.home.name;
        break;
      case WinnerType.away:
        winnerText = predictionData.teams.away.name;
        break;
      case WinnerType.draw:
        winnerText = 'Draw';
        break;
      default:
        winnerText = 'Undetermined';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prediction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.sports_score, size: 16, color: confidenceColor),
            const SizedBox(width: 4),
            Text(
              winnerText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: confidenceColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(confidenceScore * 100).toInt()}%',
              style: TextStyle(color: confidenceColor, fontSize: 12),
            ),
            const Spacer(),
            Chip(
              label: Text(
                confidenceText,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              backgroundColor: confidenceColor,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 0,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (predictionData.predictions.advice)
          Text(
            'Advice: ${predictionData.predictions.winner}',
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeTeam = predictionData.teams.home;
    final awayTeam = predictionData.teams.away;
    final matchTime = _formatMatchDate(predictionData.fixture.date);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.sports_soccer,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    predictionData.league.name,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    matchTime,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Home team
                  Expanded(
                    child: Column(
                      children: [
                        Image.network(
                          homeTeam.logo,
                          height: 40,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.sports_soccer, size: 40),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          homeTeam.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  // VS
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'VS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // Away team
                  Expanded(
                    child: Column(
                      children: [
                        Image.network(
                          awayTeam.logo,
                          height: 40,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.sports_soccer, size: 40),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          awayTeam.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              _buildPredictionIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
