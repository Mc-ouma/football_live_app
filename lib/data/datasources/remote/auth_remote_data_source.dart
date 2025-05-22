// filepath: /home/luizzy/Flutter Projects/football_live_app/lib/data/datasources/remote/auth_remote_data_source.dart
import 'package:football_live_app/data/models/user_model.dart';

/// Abstract interface for authentication remote data source
/// This is implemented by concrete classes for different platforms
abstract class AuthRemoteDataSource {
  /// Get the current user
  Future<UserModel> getCurrentUser();

  /// Sign in with email and password
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign in with Google
  Future<UserModel> signInWithGoogle();

  /// Sign out
  Future<void> signOut();

  /// Stream of authentication state changes
  Stream<UserModel?> get authStateChanges;
}
