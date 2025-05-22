// This is a stub file for Firebase options when we need to disable Firebase
import 'package:firebase_core/firebase_core.dart';

/// Stub FirebaseOptions for use without actual Firebase configuration
class DefaultFirebaseOptionsStub {
  static FirebaseOptions get currentPlatform {
    // Return web options for all platforms in development mode
    return stubOptions;
  }

  static const FirebaseOptions stubOptions = FirebaseOptions(
    apiKey: 'stub-api-key',
    appId: 'stub-app-id',
    messagingSenderId: 'stub-sender-id',
    projectId: 'stub-project-id',
    authDomain: 'stub-project-id.firebaseapp.com',
    storageBucket: 'stub-project-id.appspot.com',
  );
}
