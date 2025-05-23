part of 'prediction_data_bloc.dart';

abstract class PredictionDataEvent extends Equatable {
  const PredictionDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchMatchPredictionDataEvent extends PredictionDataEvent {
  final int matchId;

  const FetchMatchPredictionDataEvent({required this.matchId});

  @override
  List<Object?> get props => [matchId];
}

class FetchMultipleMatchPredictionsDataEvent extends PredictionDataEvent {
  final List<int> matchIds;

  const FetchMultipleMatchPredictionsDataEvent({required this.matchIds});

  @override
  List<Object?> get props => [matchIds];
}
