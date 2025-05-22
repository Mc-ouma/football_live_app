import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/user.dart';
import 'package:football_live_app/domain/repositories/auth_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetCurrentUser implements NoParamsUseCase<User> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.getCurrentUser();
  }
}
