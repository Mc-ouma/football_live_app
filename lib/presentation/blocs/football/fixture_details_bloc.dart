import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/usecases/football/get_match_details.dart';
import 'package:football_live_app/domain/usecases/football/get_head_to_head_fixtures.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';

class FixtureDetailsBloc
    extends Bloc<FixtureDetailsEvent, FixtureDetailsState> {
  final GetMatchDetails getMatchDetails;
  final GetHeadToHeadFixtures getHeadToHeadFixtures;

  FixtureDetailsBloc({
    required this.getMatchDetails,
    required this.getHeadToHeadFixtures,
  }) : super(FixtureDetailsInitial()) {
    on<LoadFixtureDetails>(_onLoadFixtureDetails);
    on<RefreshFixtureDetails>(_onRefreshFixtureDetails);
    on<LoadHeadToHeadFixtures>(_onLoadHeadToHeadFixtures);
  }

  Future<void> _onLoadFixtureDetails(
    LoadFixtureDetails event,
    Emitter<FixtureDetailsState> emit,
  ) async {
    emit(FixtureDetailsLoading());
    await _fetchFixtureDetails(event.fixtureId, emit);
  }

  Future<void> _onRefreshFixtureDetails(
    RefreshFixtureDetails event,
    Emitter<FixtureDetailsState> emit,
  ) async {
    await _fetchFixtureDetails(event.fixtureId, emit);
  }

  Future<void> _onLoadHeadToHeadFixtures(
    LoadHeadToHeadFixtures event,
    Emitter<FixtureDetailsState> emit,
  ) async {
    // Don't emit loading if we already have fixture data
    final currentState = state;
    if (currentState is! FixtureDetailsLoaded) {
      emit(FixtureDetailsLoading());
    }

    final result = await getHeadToHeadFixtures(HeadToHeadParams(
      team1Id: event.team1Id,
      team2Id: event.team2Id,
      limit: event.limit,
    ));

    result.fold(
      (failure) => emit(FixtureDetailsError(failure.message)),
      (h2hFixtures) {
        if (currentState is FixtureDetailsLoaded) {
          // Preserve existing fixture data and add H2H data
          emit(currentState.copyWith(headToHeadFixtures: h2hFixtures));
        } else {
          // If no existing fixture data, create new state with H2H data only
          emit(FixtureDetailsLoaded([], headToHeadFixtures: h2hFixtures));
        }
      },
    );
  }

  Future<void> _fetchFixtureDetails(
    int fixtureId,
    Emitter<FixtureDetailsState> emit,
  ) async {
    final result = await getMatchDetails(Params(matchId: fixtureId));

    result.fold(
      (failure) => emit(FixtureDetailsError(failure.message)),
      (fixtures) => emit(FixtureDetailsLoaded(fixtures)),
    );
  }
}
