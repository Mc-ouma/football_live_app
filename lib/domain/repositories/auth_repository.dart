import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/user.dart';

abstract class AuthRepository {
  /// Get the current authenticated user
  Future<Either<Failure, User>> getCurrentUser();

  /// Sign in with email and password
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Create a new account with email and password
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in with Google
  Future<Either<Failure, User>> signInWithGoogle();

  /// Sign out the current user
  Future<Either<Failure, void>> signOut();

  /// Reset password for an email
  Future<Either<Failure, void>> resetPassword(String email);

  /// Update user profile information
  Future<Either<Failure, User>> updateUserProfile({
    String? displayName,
    String? photoUrl,
  });

  /// Save API key
  Future<Either<Failure, void>> saveApiKey(ApiKey apiKey);

  /// Get the saved API key
  Future<Either<Failure, ApiKey?>> getApiKey();

  /// Delete the API key
  Future<Either<Failure, void>> deleteApiKey();

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
