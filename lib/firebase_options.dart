// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCqKJEfw6OgyP_fHUIvMfUzC4iD3PhvHpo',
    appId: '1:22469259197:web:9bef3a67682333188d2cd4',
    messagingSenderId: '22469259197',
    projectId: 'flutter-4661a',
    authDomain: 'flutter-4661a.firebaseapp.com',
    storageBucket: 'flutter-4661a.appspot.com',
    measurementId: 'G-R7LKW0PHP9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-K8upFjb17G7rNCizcFgKXaya82Vet3E',
    appId: '1:22469259197:android:0723eb7d7895922d8d2cd4',
    messagingSenderId: '22469259197',
    projectId: 'flutter-4661a',
    storageBucket: 'flutter-4661a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDi3o94pnHVtDIqpLwDKoqaDOkQ-aQS-WM',
    appId: '1:22469259197:ios:618f318c88a9f5138d2cd4',
    messagingSenderId: '22469259197',
    projectId: 'flutter-4661a',
    storageBucket: 'flutter-4661a.appspot.com',
    androidClientId: '22469259197-socpk0fhujaoe6chj536hp6hbide0avm.apps.googleusercontent.com',
    iosClientId: '22469259197-gmj1piuia8g717hub1ddf3jvu8tuokmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.instaClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDi3o94pnHVtDIqpLwDKoqaDOkQ-aQS-WM',
    appId: '1:22469259197:ios:618f318c88a9f5138d2cd4',
    messagingSenderId: '22469259197',
    projectId: 'flutter-4661a',
    storageBucket: 'flutter-4661a.appspot.com',
    androidClientId: '22469259197-socpk0fhujaoe6chj536hp6hbide0avm.apps.googleusercontent.com',
    iosClientId: '22469259197-gmj1piuia8g717hub1ddf3jvu8tuokmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.instaClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7RxuSjmgENB-_zWHYX1kBbu5lJJL92RI',
    appId: '1:22469259197:web:5fe1e3344cf467898d2cd4',
    messagingSenderId: '22469259197',
    projectId: 'flutter-4661a',
    authDomain: 'flutter-4661a.firebaseapp.com',
    storageBucket: 'flutter-4661a.appspot.com',
    measurementId: 'G-L1DPWJKTLM',
  );

}