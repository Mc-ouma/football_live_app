import 'package:equatable/equatable.dart';

abstract class FixtureDetailsEvent extends Equatable {
  const FixtureDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadFixtureDetails extends FixtureDetailsEvent {
  final int fixtureId;

  const LoadFixtureDetails(this.fixtureId);

  @override
  List<Object> get props => [fixtureId];
}

class RefreshFixtureDetails extends FixtureDetailsEvent {
  final int fixtureId;

  const RefreshFixtureDetails(this.fixtureId);

  @override
  List<Object> get props => [fixtureId];
}

class LoadHeadToHeadFixtures extends FixtureDetailsEvent {
  final int team1Id;
  final int team2Id;
  final int limit;

  const LoadHeadToHeadFixtures({
    required this.team1Id,
    required this.team2Id,
    this.limit = 10,
  });

  @override
  List<Object> get props => [team1Id, team2Id, limit];
}
