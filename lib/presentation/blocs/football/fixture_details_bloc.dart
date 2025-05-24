import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/usecases/football/get_match_details.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';

class FixtureDetailsBloc
    extends Bloc<FixtureDetailsEvent, FixtureDetailsState> {
  final GetMatchDetails getMatchDetails;

  FixtureDetailsBloc({required this.getMatchDetails})
      : super(FixtureDetailsInitial()) {
    on<LoadFixtureDetails>(_onLoadFixtureDetails);
    on<RefreshFixtureDetails>(_onRefreshFixtureDetails);
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

  Future<void> _fetchFixtureDetails(
    int fixtureId,
    Emitter<FixtureDetailsState> emit,
  ) async {
    final result = await getMatchDetails(Params(matchId: fixtureId));

    result.fold(
      (failure) => emit(FixtureDetailsError(failure.message)),
      (fixture) => emit(FixtureDetailsLoaded(fixture)),
    );
  }
}
