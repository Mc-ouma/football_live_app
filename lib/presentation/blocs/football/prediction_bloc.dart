import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/domain/usecases/football/get_match_prediction.dart';
import 'package:football_live_app/domain/usecases/football/get_match_predictions.dart';

part 'prediction_event.dart';
part 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  final GetMatchPrediction getMatchPrediction;
  final GetMatchPredictions getMatchPredictions;
  final LoggerService logger;

  PredictionBloc({
    required this.getMatchPrediction,
    required this.getMatchPredictions,
    required this.logger,
  }) : super(PredictionInitial()) {
    on<FetchMatchPredictionEvent>(_onFetchMatchPrediction);
    on<FetchMultipleMatchPredictionsEvent>(_onFetchMultipleMatchPredictions);
  }

  void _onFetchMatchPrediction(
    FetchMatchPredictionEvent event,
    Emitter<PredictionState> emit,
  ) async {
    emit(PredictionLoading());
    try {
      final result = await getMatchPrediction.call(event.matchId);

      result.fold(
        (failure) {
          logger.error('Failure fetching match prediction', error: failure);
          emit(PredictionError(
              message: 'Failed to load prediction: ${failure.message}'));
        },
        (prediction) {
          if (prediction == null) {
            emit(const PredictionEmpty(
                message: 'No prediction available for this match'));
          } else {
            emit(PredictionLoaded(prediction: prediction));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching match prediction',
          error: e, stackTrace: stackTrace);
      emit(PredictionError(
          message: 'Failed to load prediction: ${e.toString()}'));
    }
  }

  void _onFetchMultipleMatchPredictions(
    FetchMultipleMatchPredictionsEvent event,
    Emitter<PredictionState> emit,
  ) async {
    emit(PredictionLoading());
    try {
      final params = GetMatchPredictionsParams(matchIds: event.matchIds);
      final result = await getMatchPredictions.call(params);

      result.fold(
        (failure) {
          logger.error('Failure fetching multiple match predictions',
              error: failure);
          emit(PredictionError(
              message: 'Failed to load predictions: ${failure.message}'));
        },
        (predictions) {
          if (predictions.isEmpty) {
            emit(const PredictionEmpty(
                message: 'No predictions available for these matches'));
          } else {
            // Since Prediction no longer has a matchId, we need to create the map using the event.matchIds
            // Assuming predictions are returned in the same order as the requested matchIds
            final predictionMap = <int, Prediction>{};
            for (int i = 0;
                i < predictions.length && i < event.matchIds.length;
                i++) {
              predictionMap[event.matchIds[i]] = predictions[i];
            }

            emit(MultiPredictionLoaded(
              predictions: predictions,
              predictionMap: predictionMap,
            ));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching multiple match predictions',
          error: e, stackTrace: stackTrace);
      emit(PredictionError(
          message: 'Failed to load predictions: ${e.toString()}'));
    }
  }
}
