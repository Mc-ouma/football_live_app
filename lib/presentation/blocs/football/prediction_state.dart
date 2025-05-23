part of 'prediction_bloc.dart';

abstract class PredictionState extends Equatable {
  const PredictionState();

  @override
  List<Object?> get props => [];
}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionLoaded extends PredictionState {
  final Prediction prediction;

  const PredictionLoaded({required this.prediction});

  @override
  List<Object?> get props => [prediction];
}

class MultiPredictionLoaded extends PredictionState {
  final List<Prediction> predictions;
  final Map<int, Prediction> predictionMap; // Match ID to Prediction mapping

  // We no longer can construct the map directly since Prediction doesn't have matchId
  // Instead, we'll need to pass in the map or construct it elsewhere
  const MultiPredictionLoaded(
      {required this.predictions, required this.predictionMap});

  @override
  List<Object?> get props => [predictions, predictionMap];

  // Helper to get prediction for a specific match
  Prediction? getPredictionForMatch(int matchId) => predictionMap[matchId];
}

class PredictionEmpty extends PredictionState {
  final String message;

  const PredictionEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}

class PredictionError extends PredictionState {
  final String message;

  const PredictionError({required this.message});

  @override
  List<Object?> get props => [message];
}
