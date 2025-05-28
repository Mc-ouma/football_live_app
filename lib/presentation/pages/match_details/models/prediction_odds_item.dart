import 'package:flutter/material.dart';

enum ValidationStatus {
  pending, // Match not yet completed
  correct, // Prediction was correct
  incorrect, // Prediction was incorrect
  unknown // Unable to validate (e.g. API error, insufficient data)
}

class PredictionOddsItem {
  final String label;
  final String odd;
  final String percentage;
  final bool isSelected;
  final bool showHighlight;
  final Color highlightColor;

  // New fields for prediction validation
  final bool isApiSuggestedPick; // Whether this is suggested by the API
  final ValidationStatus validationStatus; // Status of prediction validation
  final DateTime? predictionTimestamp; // When the prediction was made

  PredictionOddsItem({
    required this.label,
    required this.odd,
    required this.percentage,
    this.isSelected = false,
    this.showHighlight = false,
    this.highlightColor = Colors.green,
    this.isApiSuggestedPick = false,
    this.validationStatus = ValidationStatus.pending,
    this.predictionTimestamp,
  });
}
