import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/standing.dart';
import 'package:football_live_app/domain/usecases/football/get_league_standings.dart';

part 'standings_event.dart';
part 'standings_state.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  final GetLeagueStandings getLeagueStandings;
  final LoggerService logger;

  StandingsBloc({
    required this.getLeagueStandings,
    required this.logger,
  }) : super(StandingsInitial()) {
    on<FetchStandingsEvent>(_onFetchStandings);
  }

  void _onFetchStandings(
    FetchStandingsEvent event,
    Emitter<StandingsState> emit,
  ) async {
    emit(StandingsLoading());
    try {
      final result = await getLeagueStandings.call(
        LeagueStandingsParams(leagueId: event.leagueId, season: event.season),
      );

      result.fold(
        (failure) {
          logger.error('Failure fetching standings', error: failure);
          emit(StandingsError(
              message: 'Failed to load standings: ${failure.message}'));
        },
        (leagueStanding) {
          if (leagueStanding.standings.isEmpty) {
            emit(const StandingsEmpty(message: 'No standings available'));
          } else {
            // Flatten standings list if needed
            final flattenedStandings =
                leagueStanding.standings.expand((list) => list).toList();
            emit(StandingsLoaded(standings: flattenedStandings));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching standings',
          error: e, stackTrace: stackTrace);
      emit(
          StandingsError(message: 'Failed to load standings: ${e.toString()}'));
    }
  }
}
