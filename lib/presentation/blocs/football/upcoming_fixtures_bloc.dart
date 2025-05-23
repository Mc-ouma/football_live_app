import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/domain/usecases/football/get_upcoming_fixtures.dart';

part 'upcoming_fixtures_event.dart';
part 'upcoming_fixtures_state.dart';

class UpcomingFixturesBloc
    extends Bloc<UpcomingFixturesEvent, UpcomingFixturesState> {
  final GetUpcomingFixtures getUpcomingFixtures;
  final LoggerService logger;

  UpcomingFixturesBloc({
    required this.getUpcomingFixtures,
    required this.logger,
  }) : super(UpcomingFixturesInitial()) {
    on<FetchUpcomingFixturesEvent>(_onFetchUpcomingFixtures);
  }

  void _onFetchUpcomingFixtures(
    FetchUpcomingFixturesEvent event,
    Emitter<UpcomingFixturesState> emit,
  ) async {
    emit(UpcomingFixturesLoading());
    try {
      final result = await getUpcomingFixtures.call(
        UpcomingFixturesParams(
          date: event.date,
          teamId: event.teamId,
          leagueId: event.leagueId,
          season: event.season,
          limit: event.limit,
        ),
      );

      result.fold(
        (failure) {
          logger.error('Failure fetching upcoming fixtures', error: failure);
          emit(UpcomingFixturesError(
              message: 'Failed to load fixtures: ${failure.message}'));
        },
        (fixtures) {
          if (fixtures.isEmpty) {
            emit(const UpcomingFixturesEmpty(
                message: 'No upcoming fixtures available'));
          } else {
            emit(UpcomingFixturesLoaded(fixtures: fixtures));
          }
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching upcoming fixtures',
          error: e, stackTrace: stackTrace);
      emit(UpcomingFixturesError(
          message: 'Failed to load fixtures: ${e.toString()}'));
    }
  }
}
