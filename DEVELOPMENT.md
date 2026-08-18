# AxiovaX Development Guide

## Project Overview

AxiovaX is a comprehensive gaming tournament management platform built with Flutter. It enables users to participate in competitive gaming tournaments across multiple games (BGMI, Free Fire, Ludo) with secure payment integration, wallet management, and admin controls.

---

## 🏗️ Architecture Overview

### Design Pattern: Clean Architecture + BLoC

The project is organized into distinct layers:

```
┌─────────────────────────────────────┐
│   Presentation Layer (UI)           │
│   - Screens, Widgets, BLoC          │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Domain Layer (Business Logic)     │
│   - UseCases, Repositories (I)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Data Layer (Implementation)       │
│   - Repositories, DataSources       │
│   - Firebase, API, Local Storage    │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Core Layer (Utilities)            │
│   - Constants, Utils, Common Widgets│
└─────────────────────────────────────┘
```

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── firebase_options.dart              # Firebase configuration
│
├── presentation/                      # UI Layer
│   ├── pages/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   ├── admin/
│   │   │   ├── admin_home_screen.dart
│   │   │   ├── tournament_management_screen.dart
│   │   │   ├── withdrawal_approval_screen.dart
│   │   │   └── dispute_resolution_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── phone_verification_screen.dart
│   │   │   └── kyc_screen.dart
│   │   └── wallet/
│   │       ├── wallet_screen.dart
│   │       ├── add_money_screen.dart
│   │       └── transaction_history_screen.dart
│   │
│   ├── bloc/
│   │   ├── auth/
│   │   │   ├── auth_event.dart
│   │   │   ├── auth_state.dart
│   │   │   └── auth_bloc.dart
│   │   ├── tournament/
│   │   │   ├── tournament_event.dart
│   │   │   ├── tournament_state.dart
│   │   │   └── tournament_bloc.dart
│   │   └── wallet/
│   │       ├── wallet_event.dart
│   │       ├── wallet_state.dart
│   │       └── wallet_bloc.dart
│   │
│   └── widgets/
│       ├── common_app_bar.dart
│       ├── error_widget.dart
│       ├── loading_widget.dart
│       └── custom_button.dart
│
├── domain/                            # Domain Layer (Business Logic)
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── tournament_repository.dart
│   │   └── wallet_repository.dart
│   │
│   └── usecases/
│       ├── auth/
│       ├── tournament/
│       └── wallet/
│
├── data/                              # Data Layer
│   ├── services/
│   │   ├── firebase_service.dart
│   │   ├── payment_service.dart
│   │   └── api_service.dart
│   │
│   ├── datasources/
│   │   ├── remote_datasource.dart
│   │   └── local_datasource.dart
│   │
│   ├── repositories/
│   │   ├── auth_repository_impl.dart
│   │   ├── tournament_repository_impl.dart
│   │   └── wallet_repository_impl.dart
│   │
│   └── models/
│       ├── user/
│       │   └── user_model.dart
│       ├── tournament/
│       │   ├── tournament_model.dart
│       │   └── tournament_registration_model.dart
│       ├── wallet/
│       │   ├── wallet_model.dart
│       │   ├── transaction_model.dart
│       │   └── withdrawal_request_model.dart
│       └── payment/
│           ├─��� razorpay_order_model.dart
│           └── payment_response_model.dart
│
└── core/                              # Core Layer
    ├── constants/
    │   ├── app_constants.dart
    │   ├── app_theme.dart
    │   └── app_strings.dart
    │
    ├── utils/
    │   ├── validators.dart
    │   ├── logger.dart
    │   └── device_utils.dart
    │
    └── error/
        ├── exceptions.dart
        └── failures.dart
```

---

## 🔐 Firestore Security Rules

The app uses the `firestore.rules` file which includes:

### User Collection Rules
- Users can only read/update their own profile
- Admins can read all profiles
- Only backend can create users

### Tournament Collection Rules
- Everyone can read tournaments
- Only admins can create/update/delete
- Users can register for tournaments (create registrations)

### Wallet Collection Rules
- Users can only read their own wallet
- Only backend can create/update (via Cloud Functions)
- Never allow delete

### Withdrawal Requests Collection Rules
- Users can read their own requests
- Only admins can approve/reject
- Only backend can create

### Disputes Collection Rules
- Users can read their own disputes
- Only admins can update status/resolution

---

## 🔄 BLoC State Management

### Event-Driven Architecture

Each BLoC follows this pattern:

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        loginWithGoogle: () => _onLoginWithGoogle(emit),
        // ... other event handlers
      );
    });
  }
  
  Future<void> _onStarted(Emitter<AuthState> emit) async {
    // Implement handler logic
  }
}
```

### State Transitions

```
Initial → Loading → Authenticated/Error
                 ↓
              Unauthenticated
```

---

## 💳 Payment Integration (Razorpay)

### Setup

1. Add Razorpay credentials to `lib/data/services/payment_service.dart`
2. Set `RAZORPAY_KEY_ID` in environment variables

### Flow

```
1. User taps "Add Money"
2. WalletBloc emits addMoney event
3. PaymentService creates Razorpay order
4. User completes payment
5. PaymentService handles success/failure
6. WalletBloc updates wallet balance
7. Transaction record created in Firestore
```

---

## 🎮 Tournament Lifecycle

### Tournament States

```
Upcoming → Live → Completed
   ↓        ↓         ↓
   │    Registration Closed    Prize Distribution
   │        ↓                        ↓
   │    Match Starts            Dispute Period
   │        ↓                        ↓
   │    Room Revealed           Completed
   │
   └─────→ Cancelled (at any stage)
```

### Player Registration Flow

```
1. Player views tournament details
2. Player taps "Register/Join Now"
3. Entry fee deducted from wallet
4. Tournament registration document created
5. Transaction record created
6. Player added to registeredPlayersList
7. Real-time updates pushed to all participants
```

---

## 🛡️ Security Considerations

### Authentication
- Firebase Phone Authentication for primary auth
- Firebase Google Authentication as secondary
- Secure token storage using flutter_secure_storage

### Device Tracking
- Get device ID using `device_info_plus`
- Store in `users/deviceIds` array
- Prevent multiple account creation from same device
- Flag suspicious activities for admin review

### KYC Verification
- Collect identity documents before withdrawal
- Store encrypted in Firestore
- Admin review required
- Only after KYC approval can users withdraw

### Payment Security
- All payments through Razorpay (PCI DSS compliant)
- Never store raw card data
- Use tokenization for saved cards
- Implement 3D Secure for high-value transactions

---

## 📱 Mobile-Specific Considerations

### Permissions Required

```yaml
# Android (AndroidManifest.xml)
- READ_EXTERNAL_STORAGE
- WRITE_EXTERNAL_STORAGE
- INTERNET
- ACCESS_NETWORK_STATE
- CAMERA (for QR code scanning)

# iOS (Info.plist)
- NSCameraUsageDescription
- NSPhotoLibraryUsageDescription
- NSPhotoLibraryAddUsageDescription
```

### Performance Optimization
- Use `const` constructors where possible
- Implement `shouldRebuild` in Providers
- Lazy load screens in navigation
- Implement pagination for lists

### Offline Support
- Cache tournament data locally
- Queue transactions when offline
- Sync when connection restored

---

## 🧪 Testing Strategy

### Unit Tests

```dart
test('AuthBloc emits [Loading, Authenticated] when login succeeds', () async {
  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Authenticated] when login succeeds',
    build: () => authBloc,
    act: (bloc) => bloc.add(const AuthEvent.loginWithGoogle()),
    expect: () => [
      const AuthState.loading(),
      const AuthState.authenticated('userId'),
    ],
  );
});
```

### Widget Tests
```dart
testWidgets('HomeScreen displays tournaments', (WidgetTester tester) async {
  await tester.pumpWidget(const AxiovaXApp());
  expect(find.byType(HomeScreen), findsOneWidget);
  expect(find.byType(ListView), findsOneWidget);
});
```

---

## 🚀 Deployment Process

### Pre-Deployment Checklist

- [ ] Update version in `pubspec.yaml`
- [ ] Run all tests: `flutter test`
- [ ] Run code analysis: `dart analyze`
- [ ] Build APK: `flutter build apk --release`
- [ ] Test on real devices
- [ ] Update Firebase security rules
- [ ] Update Firebase configuration
- [ ] Test payment flow with test cards
- [ ] Verify KYC flow
- [ ] Test admin panel

### Firebase Deployment

```bash
# Deploy Firestore security rules
firebase deploy --only firestore:rules

# Deploy Cloud Functions
cd functions
npm install
firebase deploy --only functions
```

### Play Store Deployment

```bash
# Build App Bundle
flutter build appbundle --release

# Upload to Play Console
# Navigate to: Play Console → Your App → Release → Production
# Upload the .aab file
```

---

## 🐛 Debugging Tips

### Enable Logging

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

### Firebase Emulator Suite

```bash
# Start Firebase emulator
firebase emulators:start

# Connect Flutter app to emulator
# In firebase_service.dart:
// FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
```

### Bloc Observer

```dart
class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }
}

// In main.dart:
Bloc.observer = MyBlocObserver();
```

---

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [Razorpay Documentation](https://razorpay.com/docs/)
- [Clean Architecture Guide](https://medium.com/flutter-community/clean-architecture-using-mvvm-pattern-in-flutter-2d6b26f1f725)

---

## 🤝 Code Review Checklist

Before submitting a PR:

- [ ] Code follows Dart style guide
- [ ] All tests pass
- [ ] No console warnings
- [ ] Code is documented
- [ ] Error handling implemented
- [ ] Security rules updated (if applicable)
- [ ] Performance impact considered
- [ ] Accessibility considered

---

## 📞 Contact & Support

For issues or questions:
- Create GitHub Issue
- Email: support@axiova-x.com
- Slack: #axiova-dev

---

**Last Updated**: August 18, 2026  
**Version**: 1.0.0  
**Maintainer**: mdansari0675-cmd
