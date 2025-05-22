import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/user.dart';
import 'package:football_live_app/domain/repositories/auth_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class SignInWithEmail implements UseCase<User, SignInEmailParams> {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInEmailParams params) async {
    return await repository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInEmailParams extends Equatable {
  final String email;
  final String password;

  const SignInEmailParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
