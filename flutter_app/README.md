# SmartSpend Flutter App

A comprehensive financial tracking application built with Flutter. This is a conversion from the React/TypeScript version with the same features and functionality.

## Features

- **Transaction Management**: Track income, expenses, and transfers
- **Multiple Accounts**: Manage multiple accounts (Cash, Bank, Mobile Money, etc.)
- **Bazar Tracking**: Special interface for grocery and shopping expenses
- **Lending Manager**: Track loans and repayments
- **Financial Dashboard**: Monthly and yearly overview with statistics
- **AI-Powered Insights**: Integrated with Google Gemini API for financial advice
- **Firebase Integration**: Cloud storage and authentication
- **Dark Mode**: Support for dark theme
- **Offline Support**: Local storage with SharedPreferences
- **Category Management**: Pre-defined and custom categories

## Project Structure

```
flutter_app/
├── lib/
│   ├── config/
│   │   └── firebase_options.dart
│   ├── models/
│   │   └── types.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── theme_provider.dart
│   │   └── transaction_provider.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── input_screen.dart
│   │   ├── bazar_screen.dart
│   │   ├── lending_screen.dart
│   │   ├── history_screen.dart
│   │   └── dashboard_screen.dart
│   ├── services/
│   │   ├── firebase_service.dart
│   │   ├── gemini_service.dart
│   │   ├── storage_service.dart
│   │   └── chart_service.dart
│   ├── widgets/
│   │   ├── transaction_form.dart
│   │   ├── summary_cards.dart
│   │   └── bottom_navigation.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Dart 3.0+
- Firebase project setup
- Google Gemini API key

### Installation

1. Get dependencies:
```bash
flutter pub get
```

2. Configure Firebase:
   - Update `lib/config/firebase_options.dart` with your Firebase credentials
   - Update GEMINI_API_KEY with your Google Gemini API key

3. Run the app:
```bash
flutter run
```

## Key Differences from React Version

### Data Types & Models
- **TypeScript Enums → Dart Classes**: `Category` is now a class with static string constants
- **TransactionType → Enum**: Proper Dart enum implementation
- **Interfaces → Classes**: All types are now concrete Dart classes

### State Management
- **React Hooks → Provider**: Uses Provider for state management instead of React hooks
- **Async Handling**: Simplified with Dart's Future and async/await

### UI Framework
- **React Components → Flutter Widgets**: All UI components rewritten as Flutter widgets
- **Tailwind CSS → Flutter ThemeData**: Styling done through Flutter's theme system
- **Icons**: Uses Material Design icons instead of Lucide React

### Storage
- **localStorage → SharedPreferences**: Local storage using Flutter's SharedPreferences
- **Recharts → FL Chart**: Chart visualization using FL Chart library (optional add-on)

### Services
- **Gemini Service**: Adapted to use `google_generative_ai` package
- **Firebase**: Uses official Firebase plugins for Flutter
- **Google Sign-In**: Uses `google_sign_in` package

## Key Files

### main.dart
Entry point of the application. Sets up Firebase initialization, Provider configuration, and theme.

### Transaction Provider
Main state management class handling:
- Transaction CRUD operations
- Account management
- Financial summary calculations
- Local persistence

### Screens
Five main screens:
1. **Input Screen**: Dashboard with transaction form
2. **Bazar Screen**: Dedicated grocery/shopping tracker
3. **Lending Screen**: Track loans and repayments
4. **History Screen**: View all transactions with filters
5. **Dashboard Screen**: Financial overview and statistics

### Services
- **FirebaseService**: Authentication and Firestore operations
- **StorageService**: Local persistence with SharedPreferences
- **GeminiService**: AI-powered financial advice
- **ChartService**: Data processing for charts

## Configuration

### Firebase Setup
1. Create a Firebase project at https://console.firebase.google.com
2. Enable Authentication (Google Sign-In)
3. Create Firestore database
4. Update `firebase_options.dart` with your project credentials

### Gemini API
1. Get API key from https://ai.google.dev/
2. Update `GEMINI_API_KEY` in `firebase_options.dart`

## Future Enhancements

- [ ] Add chart visualization (FL Chart integration)
- [ ] Export data to PDF/CSV
- [ ] Cloud sync with Firestore
- [ ] Budget planning features
- [ ] Recurring transactions
- [ ] Notifications for spending limits
- [ ] Multi-user support
- [ ] Receipt scanning with OCR

## Migration Notes

This is a complete Flutter conversion of the SmartSpend React app. All core features have been implemented in Flutter with equivalent functionality. The app uses the same data models and business logic, adapted for Flutter's paradigms.

### Breaking Changes from React Version
- No web version (Flutter web can be added if needed)
- Navigation is tab-based instead of menu-based
- Some advanced React features (PWA, service workers) are not needed in Flutter
