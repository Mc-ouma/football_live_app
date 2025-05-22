import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:football_live_app/core/utils/logger.dart';

/// Helper class to check Google Play Services availability
class GoogleServicesHelper {
  final LoggerService _logger;

  GoogleServicesHelper({required LoggerService logger}) : _logger = logger;

  /// Checks if Google Sign-In is available on the current platform
  Future<bool> isGoogleSignInAvailable() async {
    if (kIsWeb) {
      _logger.info('Running on Web, Google Sign-In should be available');
      return true;
    }

    if (!Platform.isAndroid && !Platform.isIOS) {
      _logger.info(
          'Platform is not Android or iOS, assuming Google Sign-In is not available');
      return false;
    }

    try {
      // Try to initialize the GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // On Android, this will check for Google Play Services availability
      final isAvailable = await googleSignIn.canAccessScopes([]);

      _logger.info('Google Sign-In availability check result: $isAvailable');
      return isAvailable;
    } catch (e) {
      _logger.error('Error checking Google Sign-In availability', error: e);
      return false;
    }
  }

  /// Handles any Google Sign-In error and returns a user-friendly message
  String handleGoogleSignInError(dynamic error) {
    // Extract the error code if it's a platform exception
    final errorMessage = error.toString();

    if (errorMessage.contains('ApiException: 10')) {
      return 'Google Play Services are not available or need to be updated on your device.';
    } else if (errorMessage.contains('network_error')) {
      return 'Network error. Please check your internet connection and try again.';
    } else if (errorMessage.contains('sign_in_canceled') ||
        errorMessage.contains('sign_in_failed')) {
      return 'Sign-in was cancelled or failed. Please try again.';
    } else if (errorMessage.contains('PlatformException')) {
      return 'There was a problem signing in with Google. Please try again later.';
    }

    return 'Failed to sign in with Google. Please try again later.';
  }
}
