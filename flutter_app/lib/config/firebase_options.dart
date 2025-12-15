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
/// ⚠️ IMPORTANT: NEVER hardcode your Gemini API key!
/// Use environment variables or a secure backend instead.
/// 
/// For development: Use flutter run --dart-define=GEMINI_API_KEY=your_key
/// For production: Use GitHub Secrets or CI/CD environment variables
///
/// Option 1: Environment Variable (RECOMMENDED for production)
/// Run: flutter run --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY
///
/// Option 2: Create a .env file (for local development only)
/// Add to .gitignore: .env
/// Then use: flutter_dotenv package
/// 
/// Option 3: Secure Backend (BEST for production)
/// Call your backend API to get a temporary token instead

const String GEMINI_API_KEY = String.fromEnvironment(
  'GEMINI_API_KEY',
  defaultValue: '', // Empty in production without the env var
);

/// Gemini Configuration
class GeminiConfig {
  static const String apiKey = GEMINI_API_KEY;
  static const String model = 'gemini-pro';
  static const double temperature = 0.7;
  static const int maxTokens = 1000;

  /// Validate API key is set
  static bool get isConfigured => apiKey.isNotEmpty;
  
  /// Check before making API calls
  static void validateConfig() {
    if (!isConfigured) {
      throw Exception(
        'Gemini API key not configured. '
        'Run: flutter run --dart-define=GEMINI_API_KEY=your_key'
      );
    }
  }
}

