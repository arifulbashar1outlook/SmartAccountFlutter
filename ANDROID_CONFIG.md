# Android App Package Name & Configuration Guide

Complete guide to configure your Android app package name and settings for SmartSpend.

## 📌 What is Package Name?

A **package name** is a unique identifier for your app on Google Play Store. 
- Example: `com.smartspend.app`
- Example: `com.yourcompany.financialtracker`
- **Must be:** unique, lowercase, with dots

---

## 🔄 Step 1: Change Package Name

### 1a. Update build.gradle

**File:** `flutter_app/android/app/build.gradle`

Find this section:
```gradle
android {
    defaultConfig {
        applicationId = "com.example.smartspend"  // CHANGE THIS
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

Replace with your package name:
```gradle
android {
    defaultConfig {
        applicationId = "com.yourcompany.smartspend"  // YOUR CUSTOM PACKAGE NAME
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

**Examples:**
- `com.smartspend.app`
- `com.myname.smartspend`
- `com.finance.tracker`
- `com.apps.expenses`

### 1b. Update AndroidManifest.xml

**File:** `flutter_app/android/app/src/main/AndroidManifest.xml`

Find:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.smartspend">
```

Change to:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.yourcompany.smartspend">
```

---

## 🏷️ Step 2: Update App Label (Display Name)

**File:** `flutter_app/android/app/src/main/AndroidManifest.xml`

Find:
```xml
<application
    android:label="app_name"
    android:icon="@mipmap/ic_launcher"
    android:usesCleartextTraffic="false">
```

The `android:label="app_name"` refers to strings defined in:
**File:** `flutter_app/android/app/src/main/res/values/strings.xml`

Edit that file:
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">SmartSpend</string>
</resources>
```

Change to your preferred app name:
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">My Finance Tracker</string>
</resources>
```

---

## 🎨 Step 3: Update App Icon (Optional)

**File:** `flutter_app/android/app/src/main/res/mipmap-*/ic_launcher.png`

Replace launcher icons at different resolutions:
- `mipmap-ldpi/` - Low DPI
- `mipmap-mdpi/` - Medium DPI
- `mipmap-hdpi/` - High DPI
- `mipmap-xhdpi/` - Extra High DPI
- `mipmap-xxhdpi/` - Extra Extra High DPI
- `mipmap-xxxhdpi/` - Ultra High DPI

**Recommended sizes:**
- mdpi: 48×48
- hdpi: 72×72
- xhdpi: 96×96
- xxhdpi: 144×144
- xxxhdpi: 192×192

---

## 📋 Step 4: Update Version Information

**File:** `flutter_app/android/app/build.gradle`

```gradle
android {
    defaultConfig {
        applicationId = "com.yourcompany.smartspend"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1              // Increment for each release
        versionName "1.0.0"        // User-visible version
    }
}
```

**Version Guidelines:**
- `versionCode`: Integer (1, 2, 3, ...) - increment for each Play Store release
- `versionName`: Semantic versioning (1.0.0, 1.0.1, 1.1.0, 2.0.0, ...)

---

## 🔐 Step 5: Firebase Registration

After changing package name, you must **re-register** your Android app in Firebase:

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Go to **Project Settings** → **Android apps**
3. If your old app is listed, delete it
4. Click **"Add app"** → Select **Android**
5. Enter your **new package name**
6. Download the new `google-services.json`
7. Replace the old one in `flutter_app/android/app/google-services.json`

---

## 🔑 Step 6: Signing Configuration

For Google Play Store, you need to sign your APK.

### Create a Keystore

```bash
keytool -genkey -v \
  -keystore ~/smartspend-key.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias smartspend-key
```

**You'll be asked:**
```
What is your first and last name?
What is your organizational unit name?
What is your organization name?
What is the name of your City or Locality?
What is the name of your State or Province?
What is the two-letter country code for this unit?
...
```

### Configure Signing in build.gradle

**File:** `flutter_app/android/app/build.gradle`

Add before `android {`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ... other config ...
    
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

Create `flutter_app/android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=smartspend-key
storeFile=/path/to/smartspend-key.jks
```

---

## 📊 Configuration Summary

| Setting | File | Change |
|---------|------|--------|
| Package Name | `build.gradle` | `applicationId = "com.yourcompany.smartspend"` |
| App Name | `AndroidManifest.xml` / `strings.xml` | `SmartSpend` → Your name |
| Version Code | `build.gradle` | Increment each release |
| Version Name | `build.gradle` | Follow semantic versioning |
| Min SDK | `build.gradle` | 21 (recommended minimum) |
| Target SDK | `build.gradle` | 34 (latest) |
| Icon | `mipmap-*/ic_launcher.png` | Replace with your icon |
| Firebase Package | Firebase Console | Must match `applicationId` |

---

## ✅ Verification Checklist

- [ ] Package name updated in `build.gradle`
- [ ] Package name updated in `AndroidManifest.xml`
- [ ] App name set in `strings.xml`
- [ ] App icon placed in mipmap folders
- [ ] Version code and name updated
- [ ] Firebase app re-registered with new package name
- [ ] `google-services.json` updated
- [ ] Signing configuration set up (for Play Store)
- [ ] `key.properties` file created (for Play Store)

---

## 🚀 Build Commands

### Build Debug APK
```bash
cd flutter_app
flutter build apk --debug
```

### Build Release APK (with signing)
```bash
flutter build apk --release
```

Output: `flutter_app/build/app/outputs/flutter-apk/app-release.apk`

---

## 📱 Install on Device

```bash
adb install -r flutter_app/build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎯 Google Play Store Submission

1. Build signed release APK
2. Create Google Play Developer account ($25)
3. Create new app
4. Fill in app details
5. Upload APK
6. Add screenshots, description, etc.
7. Submit for review (24-48 hours)

---

## 🐛 Common Issues

### "Package name mismatch"
**Solution:** Ensure `build.gradle` and `AndroidManifest.xml` have same package name

### "APK signature invalid"
**Solution:** Use the same keystore file for all releases

### "App not installing"
**Solution:** 
- Device has old version: `adb uninstall com.yourcompany.smartspend`
- Check Android version (min SDK 21)

### "Firebase initialization failed"
**Solution:** Verify `google-services.json` matches registered package name

---

**Now your app is configured and ready to build!** 🎉
