# Firebase Setup Guide for SmartSpend

Complete step-by-step guide to configure Firebase for the SmartSpend Flutter app.

## 📋 Prerequisites

- Google Account
- SmartSpend Flutter app cloned locally
- Text editor (VS Code, Android Studio, etc.)

---

## 🔧 Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Create a project"** or **"Add project"**
3. Enter project name: **smartspend** (or your preferred name)
4. Accept terms and click **"Continue"**
5. Enable Google Analytics (optional) → **"Create project"**
6. Wait for project creation (1-2 minutes)
7. Click **"Continue"** when done

---

## 📱 Step 2: Add Android App

1. In Firebase Console, click the **Android icon** (⟨ / ⟩)
2. Fill in the form:
   - **Android package name**: `com.smartspend.app` (or your custom name)
   - **App nickname**: SmartSpend (optional)
   - **Debug SHA-1**: Skip for now (needed later for production)
3. Click **"Register app"**
4. Click **"Download google-services.json"**
5. Place the file at: `flutter_app/android/app/google-services.json`
6. Click **"Next"** twice, then **"Continue to console"**

---

## 🔐 Step 3: Get Firebase Credentials

1. In Firebase Console, go to **Project Settings** (gear icon)
2. Click the **"Android"** tab
3. Scroll down and find the credentials:
   - **API Key**
   - **App ID**
   - **Sender ID** (Messaging Sender ID)
   - **Project ID** (visible in Project Settings > General)
   - **Storage Bucket** (visible in Project Settings > General)

4. Copy these values to your clipboard

---

## 📝 Step 4: Update Firebase Configuration

1. Open `flutter_app/lib/config/firebase_options.dart`
2. Replace the placeholder values with your credentials:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyD_YOUR_ANDROID_API_KEY_HERE',  // Replace this
  appId: '1:000000000000:android:abc1234567890def',  // Replace this
  messagingSenderId: '000000000000',  // Replace this
  projectId: 'your-smartspend-project',  // Replace this
  storageBucket: 'your-smartspend-project.appspot.com',  // Replace this
  databaseURL: 'https://your-smartspend-project.firebaseio.com',  // Optional
);
```

**Example of filled credentials:**
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyD_k2J9_vP0nK8m3xL5qR9tU2wV7yZ1aB',
  appId: '1:123456789012:android:abcdef1234567890ghij',
  messagingSenderId: '123456789012',
  projectId: 'smartspend-project-123',
  storageBucket: 'smartspend-project-123.appspot.com',
  databaseURL: 'https://smartspend-project-123.firebaseio.com',
);
```

---

## 🔑 Step 5: Enable Authentication

1. In Firebase Console, go to **Authentication** (left sidebar)
2. Click **"Get started"** or **"Sign-in method"**
3. Click **"Google"** provider
4. Toggle **"Enable"** to ON
5. Add project name and support email
6. Click **"Save"**

---

## 🗄️ Step 6: Set Up Firestore Database

1. In Firebase Console, go to **Firestore Database** (left sidebar)
2. Click **"Create database"**
3. Select **"Start in production mode"**
4. Choose your database location (closest to you)
5. Click **"Create"**

### Set Security Rules (Important!)

Replace default rules with:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
      
      match /{document=**} {
        allow read, write: if request.auth.uid == uid;
      }
    }
  }
}
```

---

## 🤖 Step 7: Get Gemini API Key

1. Go to [Google AI Studio](https://ai.google.dev/)
2. Click **"Get API Key"**
3. Click **"Create API key in new project"**
4. Copy the generated API key
5. Open `flutter_app/lib/config/firebase_options.dart`
6. Replace:
```dart
const String GEMINI_API_KEY = 'YOUR_GEMINI_API_KEY_HERE';
```
with:
```dart
const String GEMINI_API_KEY = 'AIzaSyD_YOUR_ACTUAL_KEY_HERE';
```

**⚠️ Important:** Never commit your real API key to GitHub. Use environment variables in production.

---

## 🔧 Step 8: Update App Package Name (Optional)

If you want a custom package name:

1. Open `flutter_app/android/app/build.gradle`
2. Find `applicationId` and change it:
```gradle
android {
    defaultConfig {
        applicationId = "com.yourcompany.smartspend"  // Change this
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

3. Also update `flutter_app/android/app/src/main/AndroidManifest.xml`:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.yourcompany.smartspend">  <!-- Change this -->
```

---

## ✅ Verification Checklist

- [ ] Firebase project created
- [ ] Android app registered
- [ ] `google-services.json` downloaded and placed in `android/app/`
- [ ] Firebase credentials updated in `firebase_options.dart`
- [ ] Authentication (Google) enabled
- [ ] Firestore Database created
- [ ] Firestore security rules updated
- [ ] Gemini API key obtained and configured
- [ ] App package name updated (optional)

---

## 🚀 Build and Test

Once all configuration is done:

```bash
cd flutter_app
flutter pub get
flutter run  # For emulator/connected device
flutter build apk --release  # For APK
```

---

## 🐛 Troubleshooting

### "FirebaseException: No Firebase App '[DEFAULT]' has been created"
**Solution:** Check that `firebase_options.dart` has correct credentials

### "Authentication failed" when signing in
**Solution:** 
- Make sure Google Sign-In is enabled in Firebase
- Check app package name matches Firebase registration
- Verify `google-services.json` is in correct location

### "Firestore permission denied"
**Solution:** Update Firestore security rules as shown in Step 6

### "Gemini API key invalid"
**Solution:** 
- Generate new key from Google AI Studio
- Make sure key starts with `AIzaSyD_`
- Verify it's not expired

---

## 📚 Additional Resources

- [Firebase Flutter Documentation](https://firebase.google.com/docs/flutter/setup)
- [Google Gemini API Guide](https://ai.google.dev/docs)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/start)
- [Firebase Authentication](https://firebase.google.com/docs/auth)

---

## 🔒 Security Best Practices

1. **Never commit API keys** to GitHub
2. Use `.gitignore` for sensitive files:
```
google-services.json
lib/config/firebase_options.dart
```

3. Keep API keys in environment variables (production)
4. Rotate API keys periodically
5. Use strong Firestore security rules
6. Monitor Firebase usage in console

---

**You're all set!** Your SmartSpend app is now connected to Firebase and ready to build.
