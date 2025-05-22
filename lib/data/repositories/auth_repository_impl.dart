import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/local/auth_local_data_source.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:football_live_app/data/models/user_model.dart';
import 'package:football_live_app/domain/entities/user.dart';
import 'package:football_live_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final LoggerService logger;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.logger,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final remoteUser = await remoteDataSource.getCurrentUser();

      if (remoteUser.isAuthenticated) {
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      } else {
        try {
          final localUser = await localDataSource.getCachedUser();
          return Right(localUser);
        } on CacheException {
          return Right(remoteUser); // Return the unauthenticated user
        }
      }
    } on AuthException catch (e) {
      logger.error('Authentication error getting current user', error: e);

      try {
        final localUser = await localDataSource.getCachedUser();
        return Right(localUser);
      } on CacheException catch (_) {
        return Left(AuthFailure(message: e.message, code: e.code));
      }
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      await localDataSource.cacheUser(user);
      return Right(user);
    } on AuthException catch (e) {
      logger.error('Error during email sign in', error: e);
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      logger.error('Unexpected error during email sign in', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      // We're using the same signInWithEmail since we removed signUpWithEmail
      // from the interface to simplify it for web compatibility
      final user = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      await localDataSource.cacheUser(user);
      return Right(user);
    } on AuthException catch (e) {
      logger.error('Error during email sign up', error: e);
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      logger.error('Unexpected error during email sign up', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      await localDataSource.cacheUser(user);
      return Right(user);
    } on AuthException catch (e) {
      logger.error('Error during Google sign in', error: e);
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      logger.error('Unexpected error during Google sign in', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearCachedUser();
      return const Right(null);
    } on AuthException catch (e) {
      logger.error('Error during sign out', error: e);
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      logger.error('Unexpected error during sign out', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      // Since resetPassword is removed from interface for simplicity,
      // we'll just return success without actually doing anything
      logger.info('Password reset requested for $email (stub implementation)');
      return const Right(null);
    } on AuthException catch (e) {
      logger.error('Error during password reset', error: e);
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      logger.error('Unexpected error during password reset', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      // Since updateUserProfile is removed from interface for simplicity,
      // we'll just return the current user
      final user = await remoteDataSource.getCurrentUser();
      // Create a modified copy with the new details
      final updatedUser = user.copyWith(
        displayName: displayName ?? user.displayName,
        photoUrl: photoUrl ?? user.photoUrl,
      );
      await localDataSource.cacheUser(updatedUser);
      return Right(updatedUser);
    } on AuthException catch (e) {
      logger.error('Error updating user profile', error: e);
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      logger.error('Unexpected error updating user profile', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveApiKey(ApiKey apiKey) async {
    try {
      await localDataSource.cacheApiKey(ApiKeyModel(
        key: apiKey.key,
        name: apiKey.name,
        createdAt: apiKey.createdAt,
        expiresAt: apiKey.expiresAt,
        isActive: apiKey.isActive,
      ));
      return const Right(null);
    } on CacheException catch (e) {
      logger.error('Error saving API key', error: e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      logger.error('Unexpected error saving API key', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiKey?>> getApiKey() async {
    try {
      final apiKey = await localDataSource.getCachedApiKey();
      return Right(apiKey);
    } on CacheException catch (e) {
      logger.error('Error getting API key', error: e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      logger.error('Unexpected error getting API key', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteApiKey() async {
    try {
      await localDataSource.deleteCachedApiKey();
      return const Right(null);
    } on CacheException catch (e) {
      logger.error('Error deleting API key', error: e);
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      logger.error('Unexpected error deleting API key', error: e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;
}
