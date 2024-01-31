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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwEK9w1Hf4kn4a_ULKy4z5mi2Iiu58Omg',
    appId: '1:866772947249:android:37daec20416832fd30a010',
    messagingSenderId: '866772947249',
    projectId: 'todo-app-4e49b',
    storageBucket: 'todo-app-4e49b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_WZbjX3s5S01n3ILhT8brS46osDd0i3Y',
    appId: '1:866772947249:ios:8b11f9dcf6e2112230a010',
    messagingSenderId: '866772947249',
    projectId: 'todo-app-4e49b',
    storageBucket: 'todo-app-4e49b.appspot.com',
    iosBundleId: 'com.khma.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_WZbjX3s5S01n3ILhT8brS46osDd0i3Y',
    appId: '1:866772947249:ios:43c5f4231a0159e530a010',
    messagingSenderId: '866772947249',
    projectId: 'todo-app-4e49b',
    storageBucket: 'todo-app-4e49b.appspot.com',
    iosBundleId: 'com.khma.todoApp.RunnerTests',
  );
}