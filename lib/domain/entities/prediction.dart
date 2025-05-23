import 'package:equatable/equatable.dart';

enum WinnerType { home, away, draw, none }

class Prediction extends Equatable {
  final PredictionWinner? winner;
  final Map<String, String> percent;
  final Map<String, String> goals;
  final String? advice;
  final Map<String, double> comparison;
  final bool? winOrDraw;
  final String? underOver;

  const Prediction({
    this.winner,
    required this.percent,
    required this.goals,
    this.advice,
    required this.comparison,
    this.winOrDraw,
    this.underOver,
  });

  double getHomeWinProbability() {
    final homePercentStr = percent['home'] ?? '0%';
    return double.parse(homePercentStr.replaceAll('%', '')) / 100;
  }

  double getAwayWinProbability() {
    final awayPercentStr = percent['away'] ?? '0%';
    return double.parse(awayPercentStr.replaceAll('%', '')) / 100;
  }

  double getDrawProbability() {
    final drawPercentStr = percent['draw'] ?? '0%';
    return double.parse(drawPercentStr.replaceAll('%', '')) / 100;
  }

  WinnerType getPredictedWinner() {
    if (winner == null) return WinnerType.none;

    final homeProb = getHomeWinProbability();
    final awayProb = getAwayWinProbability();
    final drawProb = getDrawProbability();

    if (drawProb > homeProb && drawProb > awayProb) {
      return WinnerType.draw;
    } else if (homeProb > awayProb) {
      return WinnerType.home;
    } else {
      return WinnerType.away;
    }
  }

  double getConfidenceScore() {
    final winnerType = getPredictedWinner();
    switch (winnerType) {
      case WinnerType.home:
        return getHomeWinProbability();
      case WinnerType.away:
        return getAwayWinProbability();
      case WinnerType.draw:
        return getDrawProbability();
      default:
        return 0.0;
    }
  }

  String getPredictedScore() {
    final homeGoals = goals['home'] ?? '0';
    final awayGoals = goals['away'] ?? '0';
    return '$homeGoals - $awayGoals';
  }

  String? get winnerTeamName => winner?.name;
  String? get winnerComment => winner?.comment;
  Map<String, String> get winPercentages => percent;

  @override
  List<Object?> get props => [
        winner,
        percent,
        goals,
        advice,
        comparison,
        winOrDraw,
        underOver,
      ];
}

class PredictionWinner extends Equatable {
  final String? id;
  final String? name;
  final String? comment;

  const PredictionWinner({
    this.id,
    this.name,
    this.comment,
  });

  @override
  List<Object?> get props => [id, name, comment];
}

class TeamPrediction extends Equatable {
  final int teamId;
  final String? teamName;
  final double winProbability;
  final int? predictedGoals;

  const TeamPrediction({
    required this.teamId,
    this.teamName,
    required this.winProbability,
    this.predictedGoals,
  });

  @override
  List<Object?> get props => [teamId, teamName, winProbability, predictedGoals];
}
