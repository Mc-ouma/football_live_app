import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:football_live_app/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Implementation for real Firebase authentication
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final LoggerService _logger;

  AuthRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required LoggerService logger,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _logger = logger;

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      return UserModel.fromFirebaseUser(firebaseUser);
    } catch (e) {
      _logger.error('Error getting current user', error: e);
      throw AuthException(message: 'Failed to get current user: $e');
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      _logger.error('Firebase auth error during sign in', error: e);
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          throw AuthException(message: 'Invalid email or password');
        case 'user-disabled':
          throw AuthException(message: 'This account has been disabled');
        default:
          throw AuthException(message: e.message ?? 'Authentication failed');
      }
    } catch (e) {
      _logger.error('Error signing in with email', error: e);
      throw AuthException(message: 'Failed to sign in: $e');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException(message: 'Google sign in aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return UserModel.fromFirebaseUser(userCredential.user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      _logger.error('Firebase auth error during Google sign in', error: e);
      throw AuthException(message: e.message ?? 'Authentication failed');
    } catch (e) {
      _logger.error('Error signing in with Google', error: e);
      throw AuthException(message: 'Failed to sign in with Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      _logger.error('Error signing out', error: e);
      throw AuthException(message: 'Failed to sign out: $e');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return UserModel.fromFirebaseUser(firebaseUser);
    });
  }
}
