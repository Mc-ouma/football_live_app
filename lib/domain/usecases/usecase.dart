import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';

/// Abstract class for implementing use cases with parameters
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Abstract class for implementing use cases without parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

/// Class representing no parameters for use cases that don't require any
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
