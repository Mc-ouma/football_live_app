import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/standings_model.dart';
import 'package:football_live_app/domain/usecases/football/get_standings.dart';

part 'standings_event.dart';
part 'standings_state.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  final GetStandings getStandings;
  final LoggerService logger;

  StandingsBloc({
    required this.getStandings,
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
      final standings = await getStandings.call(
        StandingsParams(
          leagueId: event.leagueId,
          season: event.season,
        ),
      );
      
      // GetStandings already handles the Either internally
      if (standings.isEmpty) {
        emit(const StandingsEmpty(
            message: 'No standings available for this league'));
      } else {
        emit(StandingsLoaded(standings: standings));
      }
    } catch (e, stackTrace) {
      logger.error('Error fetching standings',
          error: e, stackTrace: stackTrace);
      emit(
          StandingsError(message: 'Failed to load standings: ${e.toString()}'));
    }
  }
}
