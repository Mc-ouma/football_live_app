import 'dart:async';

import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:football_live_app/data/models/user_model.dart';

/// Stub implementation for platforms where Firebase Auth isn't available
class AuthRemoteDataSourceStubImpl implements AuthRemoteDataSource {
  final LoggerService _logger;
  final _authController = StreamController<UserModel?>.broadcast();

  AuthRemoteDataSourceStubImpl({
    required LoggerService logger,
  }) : _logger = logger {
    // Initialize stream with a null user (not authenticated)
    _authController.add(null);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    _logger.info('Using stub auth: getCurrentUser');
    return UserModel.empty();
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _logger.info('Using stub auth: signInWithEmail with $email');
    final user = UserModel.empty().copyWith(
      email: email,
      displayName: email.split('@').first,
    );
    _authController.add(user);
    return user;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    _logger.info('Using stub auth: signInWithGoogle');
    final user = UserModel.empty().copyWith(
      displayName: 'Stub Google User',
      email: 'google-stub@example.com',
    );
    _authController.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    _logger.info('Using stub auth: signOut');
    _authController.add(null);
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _authController.stream;
  }
}
