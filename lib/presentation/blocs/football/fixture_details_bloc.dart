import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/usecases/football/get_match_details.dart';
import 'package:football_live_app/domain/usecases/football/get_head_to_head_fixtures.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';

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
    print(
        '🔄 FixtureDetailsBloc: Starting to load fixture details for ID: ${event.fixtureId}');
    emit(FixtureDetailsLoading());
    await _fetchFixtureDetails(event.fixtureId, emit);
  }

  Future<void> _onRefreshFixtureDetails(
    RefreshFixtureDetails event,
    Emitter<FixtureDetailsState> emit,
  ) async {
    print(
        '🔄 FixtureDetailsBloc: Refreshing fixture details for ID: ${event.fixtureId}');
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
    print(
        '📡 FixtureDetailsBloc: Calling repository.getMatchDetails() for ID: $fixtureId');
    final result = await getMatchDetails(Params(matchId: fixtureId));

    result.fold(
      (failure) {
        print(
            '❌ FixtureDetailsBloc: Failed to fetch fixture details for ID $fixtureId: ${failure.message}');
        emit(FixtureDetailsError(failure.message));
      },
      (fixtures) {
        print(
            '✅ FixtureDetailsBloc: Successfully received ${fixtures.length} fixtures for ID $fixtureId');
        if (fixtures.isNotEmpty) {
          final fixture = fixtures.first;
          print(
              '📊 FixtureDetailsBloc: Fixture data analysis for ID $fixtureId:');
          print('   - Events: ${fixture.getEvents().length} events found');
          print('   - Lineups: ${fixture.getLineups().length} lineups found');
          print(
              '   - Statistics: ${fixture.getStatistics() != null ? 'Available' : 'Not available'}');
          print(
              '   - Match status: ${fixture.fixture.status.short} (${fixture.fixture.status.long})');

          // Check for detailed data
          if (fixture.hasDetailedData) {
            print('   - ✅ Detailed data is available');
          } else {
            print('   - ⚠️  Detailed data is NOT available');
          }
        }
        emit(FixtureDetailsLoaded(fixtures));
      },
    );
  }
}
