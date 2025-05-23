import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/domain/usecases/football/get_match_prediction_data.dart';
import 'package:football_live_app/domain/usecases/football/get_match_predictions_data.dart';

part 'prediction_data_event.dart';
part 'prediction_data_state.dart';

class PredictionDataBloc
    extends Bloc<PredictionDataEvent, PredictionDataState> {
  final GetMatchPredictionData getMatchPredictionData;
  final GetMatchPredictionsData getMatchPredictionsData;
  final LoggerService logger;

  PredictionDataBloc({
    required this.getMatchPredictionData,
    required this.getMatchPredictionsData,
    required this.logger,
  }) : super(PredictionDataInitial()) {
    on<FetchMatchPredictionDataEvent>(_onFetchMatchPredictionData);
    on<FetchMultipleMatchPredictionsDataEvent>(
        _onFetchMultipleMatchPredictionsData);
  }

  void _onFetchMatchPredictionData(
    FetchMatchPredictionDataEvent event,
    Emitter<PredictionDataState> emit,
  ) async {
    emit(PredictionDataLoading());
    try {
      final result = await getMatchPredictionData.call(event.matchId);

      result.fold(
        (failure) {
          logger.error('Failure fetching match prediction data',
              error: failure);
          emit(PredictionDataError(
              message: 'Failed to load prediction: ${failure.message}'));
        },
        (predictionData) {
          if (predictionData == null) {
            emit(const PredictionDataEmpty(
                message: 'No prediction available for this match'));
          } else {
            emit(PredictionDataLoaded(predictionData: predictionData));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching match prediction data',
          error: e, stackTrace: stackTrace);
      emit(PredictionDataError(
          message: 'Failed to load prediction: ${e.toString()}'));
    }
  }

  void _onFetchMultipleMatchPredictionsData(
    FetchMultipleMatchPredictionsDataEvent event,
    Emitter<PredictionDataState> emit,
  ) async {
    emit(PredictionDataLoading());
    try {
      final params = GetMatchPredictionsDataParams(matchIds: event.matchIds);
      final result = await getMatchPredictionsData.call(params);

      result.fold(
        (failure) {
          logger.error('Failure fetching multiple match predictions data',
              error: failure);
          emit(PredictionDataError(
              message: 'Failed to load predictions: ${failure.message}'));
        },
        (predictionsData) {
          if (predictionsData.isEmpty) {
            emit(const PredictionDataEmpty(
                message: 'No predictions available for these matches'));
          } else {
            // Since PredictionData doesn't have a matchId field directly,
            // we need to map it using the fixture id
            final predictionDataMap = <int, PredictionData>{};
            for (final predictionData in predictionsData) {
              predictionDataMap[predictionData.fixture.id] = predictionData;
            }

            emit(MultiPredictionDataLoaded(
              predictionsData: predictionsData,
              predictionDataMap: predictionDataMap,
            ));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching multiple match predictions data',
          error: e, stackTrace: stackTrace);
      emit(PredictionDataError(
          message: 'Failed to load predictions: ${e.toString()}'));
    }
  }
}
