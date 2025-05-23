import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/domain/entities/user.dart';
import 'package:football_live_app/domain/usecases/auth/get_current_user.dart';
import 'package:football_live_app/domain/usecases/auth/sign_in_with_email.dart';
import 'package:football_live_app/domain/usecases/auth/sign_in_with_google.dart';
import 'package:football_live_app/domain/usecases/auth/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final LoggerService logger;

  AuthBloc({
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
      logger.error('Error signing in with email',
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

        // Provide a more user-friendly error message for common Google Sign-In issues
        String errorMessage = failure.message;
        if (errorMessage.contains('ApiException: 10') ||
            errorMessage.contains('PlatformException(sign_in_failed')) {
          errorMessage =
              'Google Play Services are not available or need to be updated on your device.';
        } else if (errorMessage.contains('network_error')) {
          errorMessage =
              'Network error. Please check your internet connection and try again.';
        } else if (errorMessage.contains('sign_in_canceled')) {
          errorMessage = 'Sign-in was cancelled. Please try again.';
        }

        emit(AuthError(message: errorMessage));
      }, (user) {
        emit(AuthAuthenticated(user: user));
      });
    } catch (e, stackTrace) {
      logger.error('Error during Google sign in',
          error: e, stackTrace: stackTrace);

      // Provide a friendlier error message
      String errorMessage =
          'Failed to sign in with Google. Please try again later.';
      emit(AuthError(message: errorMessage));
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
      logger.error('Error signing out', error: e, stackTrace: stackTrace);
      emit(AuthError(message: 'Failed to sign out: ${e.toString()}'));
    }
  }
}
