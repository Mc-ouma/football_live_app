import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/match.dart';
import 'package:football_live_app/domain/usecases/football/get_team_information.dart';

part 'team_info_event.dart';
part 'team_info_state.dart';

class TeamInfoBloc extends Bloc<TeamInfoEvent, TeamInfoState> {
  final GetTeamInformation getTeamInformation;
  final LoggerService logger;

  TeamInfoBloc({
    required this.getTeamInformation,
    required this.logger,
  }) : super(TeamInfoInitial()) {
    on<FetchTeamInfoEvent>(_onFetchTeamInfo);
  }

  void _onFetchTeamInfo(
    FetchTeamInfoEvent event,
    Emitter<TeamInfoState> emit,
  ) async {
    emit(TeamInfoLoading());
    try {
      final result =
          await getTeamInformation.call(TeamParams(teamId: event.teamId));

      result.fold(
        (failure) {
          logger.error('Failure fetching team information', error: failure);
          emit(TeamInfoError(
              message: 'Failed to load team info: ${failure.message}'));
        },
        (team) {
          emit(TeamInfoLoaded(team: team));
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching team information',
          error: e, stackTrace: stackTrace);
      emit(TeamInfoError(message: 'Failed to load team info: ${e.toString()}'));
    }
  }
}
