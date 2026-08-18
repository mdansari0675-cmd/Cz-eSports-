# AxiovaX - Gaming Tournament Management App

## 📱 Overview

AxiovaX is a comprehensive Flutter-based mobile application for managing competitive gaming tournaments with real money prizes, player wallets, and admin controls. The app supports multiple games including BGMI, Free Fire, and Ludo.

## 🎯 Key Features

### For Players
- **Tournament Discovery**: Browse live, upcoming, and completed tournaments
- **Tournament Registration**: Easy registration with automatic entry fee deduction
- **Wallet System**: Secure wallet for adding/withdrawing money
- **Real-Time Updates**: Live tournament status and results
- **Result Submission**: Upload proof of victory for prize verification
- **Prize Distribution**: Automatic prize transfer to wallet
- **KYC Verification**: Identity verification for secure transactions
- **Transaction History**: Detailed records of all transactions

### For Admins
- **Tournament Management**: Create, edit, and manage tournaments
- **Player Management**: View and manage registered players
- **Withdrawal Processing**: Approve/reject player withdrawal requests
- **Dispute Resolution**: Handle player disputes and complaints
- **Dashboard Analytics**: Real-time statistics and revenue tracking
- **Audit Logs**: Track all admin actions

### Security Features
- **Device ID Tracking**: Prevent multiple account creation from same device
- **Firebase Authentication**: Secure phone/email authentication
- **Secure Storage**: Encrypted local storage for sensitive data
- **KYC Verification**: Identity verification before withdrawals
- **Payment Security**: Razorpay integration for secure payments

## 🏗️ Architecture

The app follows **Clean Architecture** with BLoC pattern for state management:

```
Presentation Layer (UI)
    ↓
Domain Layer (Business Logic)
    ↓
Data Layer (Repositories & Data Sources)
    ↓
Core Layer (Utils, Constants, Common Widgets)
```

## 🛠️ Tech Stack

- **Frontend**: Flutter 3.0+
- **State Management**: BLoC
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Payment Gateway**: Razorpay
- **Local Storage**: SharedPreferences, Secure Storage
- **Code Generation**: Freezed, JSON Serializable

## 📁 Project Structure

See `PROJECT_STRUCTURE.md` for detailed folder organization.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Firebase Project Setup
- Razorpay Account

### Installation

```bash
# Clone the repository
git clone https://github.com/mdansari0675-cmd/Cz-eSports-.git

# Navigate to project directory
cd axiova_x

# Get dependencies
flutter pub get

# Run build runners (for code generation)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Add Android and iOS apps
3. Download and place `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Update Firebase configuration in `lib/firebase_options.dart`

### Environment Configuration

Create a `.env` file in project root:

```
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_APP_ID=your_app_id
RAZORPAY_KEY_ID=your_razorpay_key
RAZORPAY_KEY_SECRET=your_razorpay_secret
API_BASE_URL=https://your-api.com
```

## 📋 Firebase Firestore Collections

### Users Collection
- `userId` (string) - Unique user identifier
- `email` (string) - User email
- `phone` (string) - User phone
- `displayName` (string) - Display name
- `walletBalance` (number) - Current wallet balance
- `deviceIds` (array) - Linked device IDs
- `kycStatus` (string) - KYC verification status
- `isAdmin` (boolean) - Admin flag

### Tournaments Collection
- `tournamentId` (string) - Unique tournament identifier
- `name` (string) - Tournament name
- `gameType` (string) - Game type (bgmi, freefire, ludo)
- `status` (string) - Tournament status (upcoming, live, completed)
- `entryFee` (number) - Entry fee amount
- `prizePool` (map) - Prize distribution
- `registeredPlayers` (number) - Number of registered players
- `totalSlots` (number) - Total available slots
- `registeredPlayersList` (array) - List of player IDs

### Wallets Collection
- `userId` (string) - User ID
- `balance` (number) - Current balance
- `totalDeposited` (number) - Total amount deposited
- `totalWithdrawn` (number) - Total amount withdrawn
- `totalWon` (number) - Total prize won

See `firestore.rules` for complete security rules.

## 🔐 Security & Compliance

- **GDPR Compliant**: User data is securely stored and encrypted
- **PCI DSS Compliant**: Payment data handled through Razorpay
- **Device Tracking**: Prevent fraud by tracking device IDs
- **KYC Verification**: Identity verification before withdrawals
- **Secure Communication**: All API calls use HTTPS

## 📦 APK Build

### Debug APK
```bash
flutter build apk --debug
```

### Release APK
```bash
flutter build apk --release
```

### App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

## 📚 API Documentation

API endpoints are documented in the backend repository. Each endpoint requires authentication via Firebase tokens.

## 🤝 Contributing

1. Create a feature branch: `git checkout -b feature/feature-name`
2. Commit changes: `git commit -am 'Add new feature'`
3. Push to branch: `git push origin feature/feature-name`
4. Submit a pull request

## 📝 Code Style

- Follow Dart [Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable names
- Write comments for complex logic
- Run `dart analyze` before committing

## 🐛 Known Issues

None currently. Report issues on GitHub.

## 📞 Support

For support, email: support@axiova-x.com

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👥 Team

- **Lead Developer**: mdansari0675-cmd
- **Contributors**: Coming soon

---

**Last Updated**: August 18, 2026
**Version**: 1.0.0
