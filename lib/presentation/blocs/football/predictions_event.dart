part of 'predictions_bloc.dart';

abstract class PredictionsEvent extends Equatable {
  const PredictionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchUpcomingPredictionsEvent extends PredictionsEvent {
  const FetchUpcomingPredictionsEvent();
}

class LoadMorePredictionsEvent extends PredictionsEvent {
  const LoadMorePredictionsEvent();
}
