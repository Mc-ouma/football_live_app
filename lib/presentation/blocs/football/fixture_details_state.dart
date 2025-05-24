import 'package:equatable/equatable.dart';
import 'package:football_live_app/data/models/fixture_model.dart';

abstract class FixtureDetailsState extends Equatable {
  const FixtureDetailsState();

  @override
  List<Object> get props => [];
}

class FixtureDetailsInitial extends FixtureDetailsState {}

class FixtureDetailsLoading extends FixtureDetailsState {}

class FixtureDetailsLoaded extends FixtureDetailsState {
  final FixtureData fixture;

  const FixtureDetailsLoaded(this.fixture);

  @override
  List<Object> get props => [fixture];
}

class FixtureDetailsError extends FixtureDetailsState {
  final String message;

  const FixtureDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
