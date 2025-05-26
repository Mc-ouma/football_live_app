import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/domain/usecases/football/get_match_predictions.dart';

part 'predictions_event.dart';
part 'predictions_state.dart';

class PredictionsBloc extends Bloc<PredictionsEvent, PredictionsState> {
  final GetMatchPredictions getMatchPredictions;
  final LoggerService logger;

  // Keep track of loaded predictions
  final List<Prediction> _loadedPredictions = [];
  // Keep track of fixture IDs we've already loaded predictions for
  final Set<int> _loadedFixtureIds = {};
  // Keep track of current page for pagination
  int _currentPage = 1;
  // Flag to indicate if there's more content to load
  bool _hasMoreContent = true;

  PredictionsBloc({
    required this.getMatchPredictions,
    required this.logger,
  }) : super(PredictionsInitial()) {
    on<FetchUpcomingPredictionsEvent>(_onFetchUpcomingPredictions);
    on<LoadMorePredictionsEvent>(_onLoadMorePredictions);
  }

  void _onFetchUpcomingPredictions(
    FetchUpcomingPredictionsEvent event,
    Emitter<PredictionsState> emit,
  ) async {
    emit(PredictionsLoading());

    try {
      // Reset state
      _loadedPredictions.clear();
      _loadedFixtureIds.clear();
      _currentPage = 1;
      _hasMoreContent = true;

      // Get upcoming fixtures first
      final fixtureIds = await _getUpcomingFixtureIds();

      if (fixtureIds.isEmpty) {
        emit(const PredictionsEmpty(message: 'No upcoming matches available'));
        return;
      }

      // Get predictions for those fixtures
      final result = await getMatchPredictions.call(
        GetMatchPredictionsParams(
          matchIds: fixtureIds,
        ),
      );

      result.fold(
        (failure) {
          logger.error('Failure fetching predictions', error: failure);
          emit(PredictionsError(
              message: 'Failed to load predictions: ${failure.message}'));
        },
        (predictions) {
          _loadedPredictions.addAll(predictions);

          // Add fixture IDs to the loaded set - we can't directly get fixtureId from Prediction
          // entity since it doesn't have this field, so we'll use the matchIds from the request
          _loadedFixtureIds.addAll(fixtureIds);

          if (predictions.isEmpty) {
            emit(const PredictionsEmpty(message: 'No predictions available'));
          } else {
            emit(PredictionsLoaded(predictions: _loadedPredictions));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching predictions',
          error: e, stackTrace: stackTrace);
      emit(PredictionsError(
          message: 'Failed to load predictions: ${e.toString()}'));
    }
  }

  void _onLoadMorePredictions(
    LoadMorePredictionsEvent event,
    Emitter<PredictionsState> emit,
  ) async {
    if (!_hasMoreContent) {
      // No more content to load
      return;
    }

    // Show loading state while keeping the current predictions visible
    emit(PredictionsLoadingMore(predictions: List.of(_loadedPredictions)));

    try {
      _currentPage++;
      final fixtureIds = await _getUpcomingFixtureIds(page: _currentPage);

      // Filter out fixture IDs we've already loaded
      final newFixtureIds =
          fixtureIds.where((id) => !_loadedFixtureIds.contains(id)).toList();

      if (newFixtureIds.isEmpty) {
        _hasMoreContent = false;
        emit(PredictionsLoaded(predictions: _loadedPredictions));
        return;
      }

      final result = await getMatchPredictions.call(
        GetMatchPredictionsParams(
          matchIds: newFixtureIds,
        ),
      );

      result.fold(
        (failure) {
          logger.error('Failure fetching more predictions', error: failure);
          // Keep showing the current predictions despite the error
          emit(PredictionsLoaded(predictions: _loadedPredictions));
        },
        (predictions) {
          if (predictions.isEmpty) {
            _hasMoreContent = false;
          } else {
            _loadedPredictions.addAll(predictions);

            // In a real implementation, we'd need to track fixture IDs differently
            // since Prediction entity doesn't have direct access to fixture.id
            // For now, we'll use fixtures from the previous page request
          }

          emit(PredictionsLoaded(predictions: _loadedPredictions));
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching more predictions',
          error: e, stackTrace: stackTrace);
      // Keep showing the current predictions despite the error
      emit(PredictionsLoaded(predictions: _loadedPredictions));
    }
  }

  // Helper method to get upcoming fixture IDs
  Future<List<int>> _getUpcomingFixtureIds({int page = 1}) async {
    // This would typically come from a repository call
    // For example: repository.getUpcomingFixtures(page: page, limit: 10)
    // For now, we'll just return a dummy list
    // In a real implementation, you would inject the FootballRepository
    return Future.value([]);
  }
}
