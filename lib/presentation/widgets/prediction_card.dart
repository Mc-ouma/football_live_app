import 'package:flutter/material.dart';
import 'package:football_live_app/domain/entities/prediction.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;

  const PredictionCard({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPredictionSummary(),
            const Divider(),
            _buildPredictionDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionSummary() {
    // Get the winner if available
    final hasWinner = prediction.winner != null;
    final winnerName = prediction.winner?.name ?? 'Not available';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          hasWinner
              ? 'Predicted Winner: $winnerName'
              : 'No prediction available',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        if (prediction.winner?.comment != null)
          Text(
            prediction.winner!.comment ?? '',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
      ],
    );
  }

  Widget _buildPredictionDetails() {
    // Get probability percentages
    final homeProb = prediction.percent['home'] ?? '0%';
    final awayProb = prediction.percent['away'] ?? '0%';
    final drawProb = prediction.percent['draw'] ?? '0%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Win Probabilities:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text('Home win: $homeProb'),
        Text('Draw: $drawProb'),
        Text('Away win: $awayProb'),
        const SizedBox(height: 8),
        if (prediction.advice != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Advice: ${prediction.advice}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        if (prediction.underOver != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text('Goals: ${prediction.underOver}'),
          ),
      ],
    );
  }
}
