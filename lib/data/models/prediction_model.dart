import 'package:freezed_annotation/freezed_annotation.dart';
import 'shared_models.dart';

part 'prediction_model.freezed.dart';
part 'prediction_model.g.dart';

/// Root response structure for prediction endpoints
@freezed

class PredictionResponse with _$PredictionResponse {
  const factory PredictionResponse({
    required String get,
    required Map<String, dynamic> parameters,
    required Map<String, dynamic> errors,
    required int results,
    required List<PredictionData> response,
  }) = _PredictionResponse;

  factory PredictionResponse.fromJson(Map<String, dynamic> json) =>
      _$PredictionResponseFromJson(json);
}

/// Main prediction data model containing all prediction information
@freezed
class PredictionData with _$PredictionData {
  const factory PredictionData({
    required Predictions predictions,
    required League league,
    required Fixture fixture,
    required Teams teams,
  }) = _PredictionData;

  factory PredictionData.fromJson(Map<String, dynamic> json) =>
      _$PredictionDataFromJson(json);
}

/// Core predictions information
@freezed
class Predictions with _$Predictions {
  const factory Predictions({
    required String winner,
    required WinnerPercentage winnerSide,
    required bool underOver,
    required bool goals,
    required bool advice,
    required double? percent,
  }) = _Predictions;

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);
}

/// Winner percentage information
@freezed
class WinnerPercentage with _$WinnerPercentage {
  const factory WinnerPercentage({
    required String home,
    required String draw,
    required String away,
  }) = _WinnerPercentage;

  factory WinnerPercentage.fromJson(Map<String, dynamic> json) =>
      _$WinnerPercentageFromJson(json);
}

/// Comparison between teams
@freezed
class Comparison with _$Comparison {
  const factory Comparison({
    required FormComparison form,
    required AttackComparison att,
    required DefenseComparison def,
    required PoissionDistribution poisson_distribution,
    required GoalsComparison goals,
    required TotalComparison total,
  }) = _Comparison;

  factory Comparison.fromJson(Map<String, dynamic> json) =>
      _$ComparisonFromJson(json);
}

/// Form comparison between teams
@freezed
class FormComparison with _$FormComparison {
  const factory FormComparison({
    required String home,
    required String away,
  }) = _FormComparison;

  factory FormComparison.fromJson(Map<String, dynamic> json) =>
      _$FormComparisonFromJson(json);
}

/// Attack comparison between teams
@freezed
class AttackComparison with _$AttackComparison {
  const factory AttackComparison({
    required String home,
    required String away,
  }) = _AttackComparison;

  factory AttackComparison.fromJson(Map<String, dynamic> json) =>
      _$AttackComparisonFromJson(json);
}

/// Defense comparison between teams
@freezed
class DefenseComparison with _$DefenseComparison {
  const factory DefenseComparison({
    required String home,
    required String away,
  }) = _DefenseComparison;

  factory DefenseComparison.fromJson(Map<String, dynamic> json) =>
      _$DefenseComparisonFromJson(json);
}

/// Poisson distribution for match prediction
@freezed
class PoissionDistribution with _$PoissionDistribution {
  const factory PoissionDistribution({
    required String home,
    required String away,
  }) = _PoissionDistribution;

  factory PoissionDistribution.fromJson(Map<String, dynamic> json) =>
      _$PoissionDistributionFromJson(json);
}

/// Goals comparison between teams
@freezed
class GoalsComparison with _$GoalsComparison {
  const factory GoalsComparison({
    required String home,
    required String away,
  }) = _GoalsComparison;

  factory GoalsComparison.fromJson(Map<String, dynamic> json) =>
      _$GoalsComparisonFromJson(json);
}

/// Total comparison summary
@freezed
class TotalComparison with _$TotalComparison {
  const factory TotalComparison({
    required String home,
    required String away,
  }) = _TotalComparison;

  factory TotalComparison.fromJson(Map<String, dynamic> json) =>
      _$TotalComparisonFromJson(json);
}

/// H2H - Head to head matches
@freezed
class H2H with _$H2H {
  const factory H2H({
    required Fixture fixture,
    required League league,
    required Teams teams,
    required Goals goals,
    required Score score,
  }) = _H2H;

  factory H2H.fromJson(Map<String, dynamic> json) => _$H2HFromJson(json);
}
