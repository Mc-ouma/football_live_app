import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/match.dart';
import 'package:football_live_app/domain/usecases/football/get_live_matches.dart';

part 'live_matches_event.dart';
part 'live_matches_state.dart';

class LiveMatchesBloc extends Bloc<LiveMatchesEvent, LiveMatchesState> {
  final GetLiveMatches getLiveMatches;
  final LoggerService logger;
  Timer? _refreshTimer;

  LiveMatchesBloc({
    required this.getLiveMatches,
    required this.logger,
  }) : super(LiveMatchesInitial()) {
    on<FetchLiveMatchesEvent>(_onFetchLiveMatches);
    on<StartLiveUpdatesEvent>(_onStartLiveUpdates);
    on<StopLiveUpdatesEvent>(_onStopLiveUpdates);
  }

  void _onFetchLiveMatches(
    FetchLiveMatchesEvent event,
    Emitter<LiveMatchesState> emit,
  ) async {
    emit(LiveMatchesLoading());
    try {
      final result = await getLiveMatches.call();

      result.fold(
        (failure) {
          logger.error('Failure fetching live matches', error: failure);
          emit(LiveMatchesError(
              message: 'Failed to load live matches: ${failure.message}'));
        },
        (matches) {
          if (matches.isEmpty) {
            emit(const LiveMatchesEmpty(
                message: 'No live matches at the moment'));
          } else {
            emit(LiveMatchesLoaded(matches: matches));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching live matches',
          error: e, stackTrace: stackTrace);
      emit(LiveMatchesError(
          message: 'Failed to load live matches: ${e.toString()}'));
    }
  }

  void _onStartLiveUpdates(
    StartLiveUpdatesEvent event,
    Emitter<LiveMatchesState> emit,
  ) {
    _stopRefreshTimer();

    // Refresh live matches every minute
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => add(FetchLiveMatchesEvent()),
    );

    // Initial fetch
    add(FetchLiveMatchesEvent());
  }

  void _onStopLiveUpdates(
    StopLiveUpdatesEvent event,
    Emitter<LiveMatchesState> emit,
  ) {
    _stopRefreshTimer();
  }

  void _stopRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  Future<void> close() {
    _stopRefreshTimer();
    return super.close();
  }
}
