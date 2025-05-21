import 'package:firebase_core/firebase_core.dart' ;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbz1jXReKjrbBH1oqjHz83zSJatwhMNFY',
    appId: '1:73129024028:android:168eb4f777b6a969611dd9',
    messagingSenderId: '73129024028',
    projectId: 'gp23-f51c6',
    storageBucket: 'gp23-f51c6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhzoNKHetFINlqybz6kxWyAqa2vvp3jnQ',
    appId: '1:73129024028:ios:76e6b22dc41c187b611dd9',
    messagingSenderId: '73129024028',
    projectId: 'gp23-f51c6',
    storageBucket: 'gp23-f51c6.firebasestorage.app',
    iosBundleId: 'com.example.gp23',
  );
}