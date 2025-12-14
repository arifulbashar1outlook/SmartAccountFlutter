# SmartSpend - Flutter Version

A comprehensive financial tracking application built with Flutter. Track income, expenses, manage multiple accounts, and get AI-powered financial insights.

## 📱 Features

- **Transaction Management**: Income, expenses, and transfers
- **Multiple Accounts**: Manage Cash, Bank, Mobile Money, and custom accounts
- **Bazar Tracking**: Dedicated grocery and shopping expense tracker
- **Lending Manager**: Track loans, repayments, and who owes you
- **Financial Dashboard**: Monthly and yearly overview with statistics
- **AI Insights**: Google Gemini powered financial advice
- **Dark Mode**: Complete dark theme support
- **Offline First**: Works offline with local storage
- **Cloud Sync**: Optional Firebase integration

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- Firebase project (optional, for cloud features)
- Google Gemini API key (optional, for AI features)

### Installation

1. Navigate to the Flutter app directory:
   ```bash
   cd flutter_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase and Gemini:
   - Update `lib/config/firebase_options.dart` with your Firebase credentials
   - Add your Gemini API key to the configuration

4. Run the app:
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
flutter_app/
├── lib/
│   ├── config/          # Firebase and API configuration
│   ├── models/          # Data models (Transaction, Account, etc.)
│   ├── providers/       # State management with Provider
│   ├── screens/         # Main app screens
│   ├── services/        # Firebase, Gemini, storage services
│   ├── widgets/         # Reusable UI widgets
│   └── main.dart        # App entry point
├── pubspec.yaml         # Dependencies
└── README.md            # Flutter app documentation
```

## 🎯 Main Screens

1. **Home/Input**: Add transactions and view dashboard
2. **Bazar**: Track grocery and shopping expenses
3. **Lending**: Manage loans and repayments
4. **History**: View transaction history with filters
5. **Dashboard**: Financial overview and statistics

## 📦 Build for Different Platforms

### Android
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS
```bash
flutter build ios --release
```

### Web (optional)
npx cap add android

# Sync and run on device/emulator
npx cap run android
```
