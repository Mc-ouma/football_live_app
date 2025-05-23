import 'package:flutter/material.dart';
import 'package:football_live_app/domain/entities/match.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:intl/intl.dart';

class EnhancedPredictionCard extends StatelessWidget {
  final Match match;
  final VoidCallback onTap;

  const EnhancedPredictionCard({
    Key? key,
    required this.match,
    required this.onTap,
  }) : super(key: key);

  String _formatMatchDate(DateTime date) {
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

  Widget _buildPredictionIndicator(Prediction? prediction) {
    if (prediction == null) {
      return const Text('No prediction available',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey));
    }

    final winnerType = prediction.getPredictedWinner();
    final confidenceScore = prediction.getConfidenceScore();
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
        winnerText = match.homeTeam.name;
        break;
      case WinnerType.away:
        winnerText = match.awayTeam.name;
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
        const Text('Prediction',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
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
              style: TextStyle(
                color: confidenceColor,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Chip(
              label: Text(
                confidenceText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              backgroundColor: confidenceColor,
              padding: EdgeInsets.zero,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Predicted Score: ${prediction.getPredictedScore()}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeTeam = match.homeTeam;
    final awayTeam = match.awayTeam;
    final prediction = match.prediction;
    final matchTime = _formatMatchDate(match.date);

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
                    match.league.name,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    matchTime,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
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
                        if (homeTeam.logo != null)
                          Image.network(
                            homeTeam.logo!,
                            height: 40,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.sports_soccer,
                              size: 40,
                            ),
                          )
                        else
                          const Icon(Icons.sports_soccer, size: 40),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                        if (awayTeam.logo != null)
                          Image.network(
                            awayTeam.logo!,
                            height: 40,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.sports_soccer,
                              size: 40,
                            ),
                          )
                        else
                          const Icon(Icons.sports_soccer, size: 40),
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
              _buildPredictionIndicator(prediction),
            ],
          ),
        ),
      ),
    );
  }
}
