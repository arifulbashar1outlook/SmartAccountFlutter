import 'config/firebase_options.dart' as config;

/// Simple re-export so existing `import 'firebase_options.dart'` works
export 'config/firebase_options.dart' show DefaultFirebaseOptions, GEMINI_API_KEY, GeminiConfig;

/// Backwards-compatible reference
class DefaultFirebaseOptionsWrapper {
  static get currentPlatform => config.DefaultFirebaseOptions.currentPlatform;
}
