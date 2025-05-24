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
