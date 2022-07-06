import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for macos - '
            'you can reconfigure this by running the FlutterFire CLI again.');
      case TargetPlatform.windows:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for windows - '
            'you can reconfigure this by running the FlutterFire CLI again.');
      case TargetPlatform.linux:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for linux - '
            'you can reconfigure this by running the FlutterFire CLI again.');
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: 'AIzaSyARuCBojOv9Mt-w975tChSGcGEgZVumMOo',
      appId: '1:611583846064:web:ded7b38246d62e85cc7d75',
      messagingSenderId: '611583846064',
      projectId: 'smarthears-b46bb',
      authDomain: 'smarthears-b46bb.firebaseapp.com',
      storageBucket: 'smarthears-b46bb.appspot.com',
      measurementId: 'G-7JXFNJT7DC');

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyA72tFQqqJI8C8p8dRbPb3uhfh94lQuI3s',
      appId: '1:611583846064:android:d194662630cd61a7cc7d75',
      messagingSenderId: '611583846064',
      projectId: 'smarthears-b46bb',
      storageBucket: 'smarthears-b46bb.appspot.com');

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyANMeneRzXjjWqPb7nIiaYzZiHayLLK16M',
      appId: '1:611583846064:ios:47a17939ecf1e9d6cc7d75',
      messagingSenderId: '611583846064',
      projectId: 'smarthears-b46bb',
      storageBucket: 'smarthears-b46bb.appspot.com',
      iosClientId: '611583846064-v1qo3654s3bn2qpj6lo0nft7tqnb35j2.apps.googleusercontent.com',
      iosBundleId: 'com.example.smarthearsApp');
}
