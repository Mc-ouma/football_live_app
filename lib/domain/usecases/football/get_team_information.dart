import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/fixture.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetTeamInformation implements UseCase<Team, TeamParams> {
  final FootballRepository repository;

  GetTeamInformation(this.repository);

  @override
  Future<Either<Failure, Team>> call(TeamParams params) async {
    return await repository.getTeamInformation(params.teamId);
  }
}

class TeamParams extends Equatable {
  final int teamId;

  const TeamParams({required this.teamId});

  @override
  List<Object> get props => [teamId];
}
