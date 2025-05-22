import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/usecases/auth/get_current_user.dart';
import 'package:football_live_app/domain/usecases/auth/sign_in_with_email.dart';
import 'package:football_live_app/domain/usecases/auth/sign_in_with_google.dart';
import 'package:football_live_app/domain/usecases/auth/sign_out.dart';

// Import auth_bloc.dart for access to the part files (AuthEvent and AuthState)
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';

class AuthBlocFixed extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final LoggerService logger;

  AuthBlocFixed({
    required this.signInWithEmail,
    required this.signInWithGoogle,
    required this.signOut,
    required this.getCurrentUser,
    required this.logger,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
  }

  void _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await getCurrentUser.call();

      result.fold((failure) {
        logger.error('Authentication failure', error: failure);
        emit(AuthUnauthenticated());
      }, (user) {
        if (user.isAuthenticated) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } catch (e, stackTrace) {
      logger.error('Error checking auth status',
          error: e, stackTrace: stackTrace);
      emit(AuthError(message: 'Failed to authenticate: ${e.toString()}'));
    }
  }

  void _onSignInWithEmail(
    SignInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await signInWithEmail.call(
        SignInEmailParams(email: event.email, password: event.password),
      );

      result.fold((failure) {
        logger.error('Email sign-in failure', error: failure);
        emit(AuthError(message: 'Failed to sign in: ${failure.message}'));
      }, (user) {
        emit(AuthAuthenticated(user: user));
      });
    } catch (e, stackTrace) {
      logger.error('Error during email sign in',
          error: e, stackTrace: stackTrace);
      emit(AuthError(message: 'Failed to sign in: ${e.toString()}'));
    }
  }

  void _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await signInWithGoogle.call();

      result.fold((failure) {
        logger.error('Google sign-in failure', error: failure);
        emit(AuthError(
            message: 'Failed to sign in with Google: ${failure.message}'));
      }, (user) {
        emit(AuthAuthenticated(user: user));
      });
    } catch (e, stackTrace) {
      logger.error('Error during Google sign in',
          error: e, stackTrace: stackTrace);
      emit(
          AuthError(message: 'Failed to sign in with Google: ${e.toString()}'));
    }
  }

  void _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await signOut.call();

      result.fold((failure) {
        logger.error('Sign-out failure', error: failure);
        emit(AuthError(message: 'Failed to sign out: ${failure.message}'));
      }, (_) {
        emit(AuthUnauthenticated());
      });
    } catch (e, stackTrace) {
      logger.error('Error during sign out', error: e, stackTrace: stackTrace);
      emit(AuthError(message: 'Failed to sign out: ${e.toString()}'));
    }
  }
}
