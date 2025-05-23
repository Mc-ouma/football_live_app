// File generated by FlutterFire CLI.
// This file should be included in your git repository for reference.
// Note: Normally this file is generated by the FlutterFire CLI but we're creating it manually for now.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default FirebaseOptions for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Configuration for Web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',  // Replace with actual API key in production
    appId: 'YOUR-APP-ID',   // Replace with actual App ID in production
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    authDomain: 'YOUR-PROJECT-ID.firebaseapp.com',
    storageBucket: 'YOUR-PROJECT-ID.appspot.com',
  );

  // Configuration for Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',  // Replace with actual API key in production
    appId: 'YOUR-APP-ID',   // Replace with actual App ID in production
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    storageBucket: 'YOUR-PROJECT-ID.appspot.com',
  );

  // Configuration for iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',  // Replace with actual API key in production
    appId: 'YOUR-APP-ID',   // Replace with actual App ID in production
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    storageBucket: 'YOUR-PROJECT-ID.appspot.com',
    iosClientId: 'YOUR-IOS-CLIENT-ID',
    iosBundleId: 'com.example.footballLiveApp',
  );
}
