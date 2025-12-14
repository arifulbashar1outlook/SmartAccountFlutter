# Building APK for SmartSpend Flutter App

## 🚀 Automatic Build (GitHub Actions)

The easiest way to get the APK is through GitHub Actions:

### Steps:
1. Go to your repository: https://github.com/arifulbashar1outlook/SmartAccountFlutter
2. Click on the **Actions** tab
3. Select **Build Flutter APK** workflow
4. Click **Run workflow** → **Run workflow**
5. Wait for the build to complete (5-10 minutes)
6. Download the APK from **Artifacts**:
   - `app-debug` - For testing
   - `app-release` - For production

The workflow automatically triggers on every push to main.

---

## 💻 Manual Build (Local Machine)

### Prerequisites
- Flutter SDK 3.0+ installed
- Android SDK with API level 34+
- Java Development Kit (JDK) 11+

### Installation Steps

1. **Install Flutter** (if not already installed):
   ```bash
   git clone https://github.com/flutter/flutter.git
   export PATH="$PATH:`pwd`/flutter/bin"
   flutter doctor  # Check everything is set up
   ```

2. **Navigate to Flutter app**:
   ```bash
   cd flutter_app
   ```

3. **Get dependencies**:
   ```bash
   flutter pub get
   ```

4. **Build APK (Debug)**:
   ```bash
   flutter build apk --debug
   ```
   Output: `build/app/outputs/flutter-apk/app-debug.apk`

5. **Build APK (Release)**:
   ```bash
   flutter build apk --release
   ```
   Output: `build/app/outputs/flutter-apk/app-release.apk`

### What's the difference?

| Type | Size | Speed | Debug Info | Use Case |
|------|------|-------|-----------|----------|
| Debug | ~50MB | Slower | Full debug info | Development & testing |
| Release | ~20MB | Faster | Optimized | Production & distribution |

---

## 📱 Installing on Android Device

### Option 1: USB Connection
```bash
# Connect Android device via USB with debugging enabled
flutter install

# Or specify the APK directly
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Option 2: Direct APK Install
1. Download the APK file
2. Transfer to your Android device
3. Open with file manager
4. Tap to install

---

## 🔧 Configuration Before Building

### 1. Firebase Setup
Edit `lib/config/firebase_options.dart`:
```dart
class DefaultFirebaseOptions {
  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    appId: "YOUR_APP_ID",
    messagingSenderId: "YOUR_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_BUCKET",
    databaseUrl: "YOUR_DATABASE_URL",
    authDomain: "YOUR_AUTH_DOMAIN",
    measurementId: "YOUR_MEASUREMENT_ID",
  );
}
```

### 2. Gemini API Key
Update in the same file:
```dart
const String GEMINI_API_KEY = "YOUR_GEMINI_API_KEY";
```

### 3. Android App Name & Package
Edit `android/app/build.gradle`:
```gradle
android {
    defaultConfig {
        applicationId = "com.yourcompany.smartspend"  // Change this
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

Edit `android/app/src/main/AndroidManifest.xml`:
```xml
<application
    android:label="SmartSpend"  <!-- Your app name -->
    android:icon="@mipmap/ic_launcher">
```

---

## 🐛 Troubleshooting

### "Android toolchain not found"
```bash
flutter config --android-sdk-path /path/to/android/sdk
```

### "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### "Java version issue"
```bash
flutter config --jdk-dir /path/to/jdk
```

### "Certificate error"
Create a signing key:
```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

Then configure `android/app/build.gradle`:
```gradle
signingConfigs {
    release {
        keyAlias 'key'
        keyPassword 'password'
        storeFile file('/path/to/key.jks')
        storePassword 'password'
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

---

## 📦 Distributing the APK

### Google Play Store
1. Create Google Play Developer account
2. Prepare APK with signing key
3. Create app listing
4. Upload APK
5. Configure permissions and settings
6. Submit for review

### Direct Distribution
1. Upload `app-release.apk` to file hosting
2. Share download link
3. Users enable "Unknown sources" in settings
4. Install from link

---

## 📊 Build Output Locations

```
SmartAccountFlutter/
└── flutter_app/
    └── build/
        └── app/
            └── outputs/
                └── flutter-apk/
                    ├── app-debug.apk
                    ├── app-debug.apk.sha1
                    ├── app-release.apk
                    └── app-release.apk.sha1
```

---

## ✅ Next Steps

1. Configure Firebase credentials
2. Add Gemini API key
3. Customize app name and icon
4. Create signing key for production
5. Build release APK
6. Test on Android device
7. Upload to Play Store or distribute directly

For more help, check:
- [Flutter APK Documentation](https://docs.flutter.dev/deployment/android)
- [Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup)
