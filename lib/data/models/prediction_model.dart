import 'package:football_live_app/domain/entities/prediction.dart';

class PredictionModel {
  final PredictionWinnerModel? winner;
  final Map<String, String> percent;
  final Map<String, String> goals;
  final String? advice;
  final Map<String, double> comparison;
  final bool? winOrDraw;
  final String? underOver;

  PredictionModel({
    this.winner,
    required this.percent,
    required this.goals,
    this.advice,
    required this.comparison,
    this.winOrDraw,
    this.underOver,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    final predictions = json['predictions'] as Map<String, dynamic>;
    final winnerData = predictions['winner'] as Map<String, dynamic>?;
    final percentData = (predictions['percent'] as Map<String, dynamic>?) ?? {};
    final comparisonData = json['comparison'] as Map<String, dynamic>? ?? {};

    // Create winner model if data exists
    PredictionWinnerModel? winnerModel;
    if (winnerData != null) {
      winnerModel = PredictionWinnerModel(
        id: winnerData['id']?.toString(),
        name: winnerData['name'],
        comment: winnerData['comment'],
      );
    }

    return PredictionModel(
      winner: winnerModel,
      percent: Map<String, String>.from(percentData),
      goals: Map<String, String>.from(predictions['goals'] as Map),
      advice: predictions['advice'] as String?,
      comparison: Map<String, double>.from(
        comparisonData.map((key, value) => MapEntry(
            key,
            value is Map
                ? ((value['home'] as String?)?.replaceAll('%', ''))
                        ?.let((it) => double.parse(it) / 100) ??
                    0.0
                : 0.0)),
      ),
      winOrDraw: predictions['win_or_draw'] as bool?,
      underOver: predictions['under_over'] as String?,
    );
  }

  Prediction toEntity() {
    return Prediction(
      winner: winner?.toEntity(),
      percent: percent,
      goals: goals,
      advice: advice,
      comparison: comparison,
      winOrDraw: winOrDraw,
      underOver: underOver,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictions': {
        'winner': winner?.toJson(),
        'win_or_draw': winOrDraw,
        'under_over': underOver,
        'goals': goals,
        'advice': advice,
        'percent': percent,
      },
      'comparison': comparison,
    };
  }
}

class PredictionWinnerModel {
  final String? id;
  final String? name;
  final String? comment;

  PredictionWinnerModel({
    this.id,
    this.name,
    this.comment,
  });

  PredictionWinner toEntity() {
    return PredictionWinner(
      id: id,
      name: name,
      comment: comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'comment': comment,
    };
  }
}

extension on String {
  T let<T>(T Function(String) block) => block(this);
}
