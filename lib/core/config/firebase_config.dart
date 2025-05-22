import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:football_live_app/core/utils/logger.dart';

// Import both the real and stub options
import 'package:football_live_app/firebase_options.dart' as real_options;
import 'package:football_live_app/firebase_options_stub.dart' as stub_options;

class FirebaseConfig {
  static final LoggerService _logger = LoggerService();
  static bool isInitialized = false;
  static bool isUsingStub = false;

  /// Initialize Firebase with appropriate options based on platform
  static Future<void> initialize() async {
    try {
      if (kIsWeb) {
        // For web, use stub options to avoid Firebase initialization issues
        await Firebase.initializeApp(
          options: stub_options.DefaultFirebaseOptionsStub.currentPlatform,
        );
        isUsingStub = true;
        _logger.info('Initialized Firebase with stub configuration for web');
      } else {
        // For mobile platforms, use the real Firebase options
        await Firebase.initializeApp(
          options: real_options.DefaultFirebaseOptions.currentPlatform,
        );
        _logger.info('Initialized Firebase with real configuration');
      }
      isInitialized = true;
    } catch (e, stackTrace) {
      _logger.error('Failed to initialize Firebase',
          error: e, stackTrace: stackTrace);
      // Fall back to stub options if initialization fails
      try {
        await Firebase.initializeApp(
          options: stub_options.DefaultFirebaseOptionsStub.stubOptions,
        );
        isUsingStub = true;
        isInitialized = true;
        _logger.info('Fell back to stub Firebase configuration');
      } catch (e, stackTrace) {
        _logger.error('Failed to initialize Firebase with stub options',
            error: e, stackTrace: stackTrace);
      }
    }
  }

  /// Check if Firebase Authentication is available
  static bool hasAuthSupport() {
    return isInitialized && !isUsingStub;
  }
}
