part of 'prediction_bloc.dart';

abstract class PredictionEvent extends Equatable {
  const PredictionEvent();

  @override
  List<Object?> get props => [];
}

class FetchMatchPredictionEvent extends PredictionEvent {
  final int matchId;

  const FetchMatchPredictionEvent({required this.matchId});

  @override
  List<Object?> get props => [matchId];
}

class FetchMultipleMatchPredictionsEvent extends PredictionEvent {
  final List<int> matchIds;

  const FetchMultipleMatchPredictionsEvent({required this.matchIds});

  @override
  List<Object?> get props => [matchIds];
}
