import 'package:flutter/material.dart';
import 'package:football_live_app/domain/entities/prediction.dart';

class PredictionBadge extends StatelessWidget {
  final Prediction prediction;

  const PredictionBadge({
    super.key,
    required this.prediction,
  });

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData badgeIcon;
    String predictionText;

    // Determine prediction outcome display
    final winner = prediction.getPredictedWinner();
    switch (winner) {
      case WinnerType.home:
        badgeColor = Colors.blue;
        badgeIcon = Icons.home;
        predictionText = "Home";
        break;
      case WinnerType.away:
        badgeColor = Colors.red;
        badgeIcon = Icons.airplanemode_active;
        predictionText = "Away";
        break;
      case WinnerType.draw:
        badgeColor = Colors.amber;
        badgeIcon = Icons.balance;
        predictionText = "Draw";
        break;
      default:
        badgeColor = Colors.grey;
        badgeIcon = Icons.question_mark;
        predictionText = "Unknown";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 14, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            predictionText,
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
