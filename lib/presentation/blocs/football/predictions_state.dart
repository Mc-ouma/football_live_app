part of 'predictions_bloc.dart';

abstract class PredictionsState extends Equatable {
  const PredictionsState();

  @override
  List<Object> get props => [];
}

class PredictionsInitial extends PredictionsState {}

class PredictionsLoading extends PredictionsState {}

class PredictionsLoadingMore extends PredictionsState {
  final List<Prediction> predictions;

  const PredictionsLoadingMore({required this.predictions});

  @override
  List<Object> get props => [predictions];
}

class PredictionsLoaded extends PredictionsState {
  final List<Prediction> predictions;

  const PredictionsLoaded({required this.predictions});

  @override
  List<Object> get props => [predictions];
}

class PredictionsEmpty extends PredictionsState {
  final String message;

  const PredictionsEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class PredictionsError extends PredictionsState {
  final String message;

  const PredictionsError({required this.message});

  @override
  List<Object> get props => [message];
}
