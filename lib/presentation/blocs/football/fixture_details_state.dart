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
  final List<FixtureData> fixtures;

  const FixtureDetailsLoaded(this.fixtures);

  // Convenience getter to access the first fixture when we expect exactly one
  // Returns null if the list is empty to allow for safer handling
  FixtureData? get fixture => fixtures.isNotEmpty ? fixtures.first : null;

  // Check if the fixture list has any items
  bool get hasFixtures => fixtures.isNotEmpty;

  // For cases where we need to access fixtures by index safely
  FixtureData? getFixtureAt(int index) {
    if (index >= 0 && index < fixtures.length) {
      return fixtures[index];
    }
    return null;
  }

  // Get the count of fixtures
  int get fixtureCount => fixtures.length;

  @override
  List<Object> get props => [fixtures];
}

class FixtureDetailsError extends FixtureDetailsState {
  final String message;

  const FixtureDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
