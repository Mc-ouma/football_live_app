import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/repositories/auth_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class SignOut implements NoParamsUseCase<void> {
  final AuthRepository repository;

  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
