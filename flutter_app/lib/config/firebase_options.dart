import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Firebase configuration for SmartSpend app
/// Get your credentials from: https://console.firebase.google.com
/// Follow the setup guide in ../../FIREBASE_SETUP.md

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android; // Using Android as the primary platform
  }

  /// Android Firebase Configuration
  /// Get these from Firebase Console > Project Settings > Android App
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_YOUR_ANDROID_API_KEY_HERE', // Replace with your API Key
    appId: '1:000000000000:android:abc1234567890def', // Replace with your App ID
    messagingSenderId: '000000000000', // Replace with your Sender ID
    projectId: 'your-smartspend-project', // Replace with your Project ID
    storageBucket: 'your-smartspend-project.appspot.com', // Replace with your Storage Bucket
    databaseURL: 'https://your-smartspend-project.firebaseio.com', // Optional
  );

  /// iOS Firebase Configuration (optional)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_YOUR_IOS_API_KEY_HERE',
    appId: '1:000000000000:ios:abc1234567890def',
    messagingSenderId: '000000000000',
    projectId: 'your-smartspend-project',
    storageBucket: 'your-smartspend-project.appspot.com',
    databaseURL: 'https://your-smartspend-project.firebaseio.com',
    iosBundleId: 'com.example.smartspend',
  );

  /// Web Firebase Configuration (optional)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD_YOUR_WEB_API_KEY_HERE',
    appId: '1:000000000000:web:abc1234567890def',
    messagingSenderId: '000000000000',
    projectId: 'your-smartspend-project',
    storageBucket: 'your-smartspend-project.appspot.com',
    databaseURL: 'https://your-smartspend-project.firebaseio.com',
    measurementId: 'G-XXXXXXXXXX',
  );
}

/// Google Gemini AI Configuration
/// Get your API key from: https://ai.google.dev/
/// Steps:
/// 1. Go to https://ai.google.dev/
/// 2. Click "Get API Key"
/// 3. Create a new API key
/// 4. Paste it below
const String GEMINI_API_KEY = 'YOUR_GEMINI_API_KEY_HERE';

/// Gemini Configuration
class GeminiConfig {
  static const String apiKey = GEMINI_API_KEY;
  static const String model = 'gemini-pro';
  static const double temperature = 0.7;
  static const int maxTokens = 1000;
}

