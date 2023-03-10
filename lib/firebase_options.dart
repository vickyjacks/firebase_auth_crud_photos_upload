// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBO2aT1TZ0owHZeIIffJgu1R0tDRJueHCU',
    appId: '1:9118913692:web:9680413238c4546671c959',
    messagingSenderId: '9118913692',
    projectId: 'myapp-6c66f',
    authDomain: 'myapp-6c66f.firebaseapp.com',
    storageBucket: 'myapp-6c66f.appspot.com',
    measurementId: 'G-E7NVVBBPGJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8OEj6AsWmgVhUwZbfTgD2JQm6kJK1gS0',
    appId: '1:9118913692:android:40c20eda0a2ffbad71c959',
    messagingSenderId: '9118913692',
    projectId: 'myapp-6c66f',
    storageBucket: 'myapp-6c66f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-8M8L_uJX94AWMxnmpt27vgSAJUj_A-8',
    appId: '1:9118913692:ios:06eae5f37202400e71c959',
    messagingSenderId: '9118913692',
    projectId: 'myapp-6c66f',
    storageBucket: 'myapp-6c66f.appspot.com',
    iosClientId: '9118913692-9dk4qdl6oiruje166tpa7h7i0sp67coa.apps.googleusercontent.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-8M8L_uJX94AWMxnmpt27vgSAJUj_A-8',
    appId: '1:9118913692:ios:06eae5f37202400e71c959',
    messagingSenderId: '9118913692',
    projectId: 'myapp-6c66f',
    storageBucket: 'myapp-6c66f.appspot.com',
    iosClientId: '9118913692-9dk4qdl6oiruje166tpa7h7i0sp67coa.apps.googleusercontent.com',
    iosBundleId: 'com.example.myapp',
  );
}
