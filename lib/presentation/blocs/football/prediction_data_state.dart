part of 'prediction_data_bloc.dart';

abstract class PredictionDataState extends Equatable {
  const PredictionDataState();

  @override
  List<Object?> get props => [];
}

class PredictionDataInitial extends PredictionDataState {}

class PredictionDataLoading extends PredictionDataState {}

class PredictionDataLoaded extends PredictionDataState {
  final PredictionData predictionData;

  const PredictionDataLoaded({required this.predictionData});

  @override
  List<Object?> get props => [predictionData];
}

class MultiPredictionDataLoaded extends PredictionDataState {
  final List<PredictionData> predictionsData;
  final Map<int, PredictionData>
      predictionDataMap; // Match ID to PredictionData mapping

  const MultiPredictionDataLoaded({
    required this.predictionsData,
    required this.predictionDataMap,
  });

  @override
  List<Object?> get props => [predictionsData, predictionDataMap];

  // Helper to get prediction for a specific match
  PredictionData? getPredictionForMatch(int matchId) =>
      predictionDataMap[matchId];
}

class PredictionDataEmpty extends PredictionDataState {
  final String message;

  const PredictionDataEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}

class PredictionDataError extends PredictionDataState {
  final String message;

  const PredictionDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
