import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/player.dart';
import 'package:football_live_app/domain/usecases/football/get_player_statistics.dart';

part 'player_stats_event.dart';
part 'player_stats_state.dart';

class PlayerStatsBloc extends Bloc<PlayerStatsEvent, PlayerStatsState> {
  final GetPlayerStatistics getPlayerStatistics;
  final LoggerService logger;

  PlayerStatsBloc({
    required this.getPlayerStatistics,
    required this.logger,
  }) : super(PlayerStatsInitial()) {
    on<FetchPlayerStatsEvent>(_onFetchPlayerStats);
  }

  void _onFetchPlayerStats(
    FetchPlayerStatsEvent event,
    Emitter<PlayerStatsState> emit,
  ) async {
    emit(PlayerStatsLoading());
    try {
      final result = await getPlayerStatistics.call(
        PlayerStatsParams(
          playerId: event.playerId,
          season: event.season,
          leagueId: event.leagueId,
          teamId: event.teamId,
        ),
      );

      result.fold(
        (failure) {
          logger.error('Failure fetching player statistics', error: failure);
          emit(PlayerStatsError(
              message: 'Failed to load player stats: ${failure.message}'));
        },
        (stats) {
          emit(PlayerStatsLoaded(playerStats: stats));
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching player statistics',
          error: e, stackTrace: stackTrace);
      emit(PlayerStatsError(
          message: 'Failed to load player stats: ${e.toString()}'));
    }
  }
}
