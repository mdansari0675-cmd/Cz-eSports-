# AxiovaX Gaming Tournament Management App - Complete Project Structure

## 📁 Project Architecture

```
axiova_x/
├── android/                          # Android native code
│   ├── app/
│   │   ├── build.gradle
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   ├── kotlin/
│   │   │   │   └── com/axiova/x/MainActivity.kt
│   │   │   └── res/
│   │   │       ├── drawable/
│   │   │       ├── mipmap/
│   │   │       └── values/
│   │   └── google-services.json       # Firebase config
│   ├── gradle/
│   ├── build.gradle
│   └── local.properties
│
├── ios/                              # iOS native code
│   ├── Runner/
│   ├── Pods/
│   ├── Podfile
│   └─�� GoogleService-Info.plist      # Firebase config
│
├── lib/                              # Main Dart/Flutter code
│   ├── main.dart
│   ├── config/
│   │   ├── app_config.dart           # App constants
│   │   ├── firebase_options.dart     # Firebase setup
│   │   └── routes.dart               # Route definitions
│   │
│   ├── core/                         # Core functionality
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── colors.dart
│   │   │   ├── fonts.dart
│   │   │   ├── images.dart
│   │   │   └── strings.dart
│   │   │
│   │   ├── errors/
│   │   │   ├── exceptions.dart
│   │   │   ├── failure.dart
│   │   │   └── error_handler.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── device_utils.dart
│   │   │   ├── validators.dart
│   │   │   ├── formatters.dart
│   │   │   ├── logger.dart
│   │   │   └── secure_storage.dart
│   │   │
│   │   └── widgets/
│   │       ├── app_button.dart
│   │       ├── app_text_field.dart
│   │       ├── loading_indicator.dart
│   │       ├── error_widget.dart
│   │       ├── empty_state.dart
│   │       └── common_appbar.dart
│   │
│   ├── data/                         # Data layer (Models, Repos, Data Sources)
│   │   ├── datasources/
│   │   │   ├── remote/
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   ├── tournament_remote_datasource.dart
│   │   │   │   ├── wallet_remote_datasource.dart
│   │   │   │   ├── payment_remote_datasource.dart
│   │   │   │   └── admin_remote_datasource.dart
│   │   │   └── local/
│   │   │       ├── auth_local_datasource.dart
│   │   │       └── cache_datasource.dart
│   │   │
│   │   ├── models/
│   │   │   ├── user/
│   │   │   │   ├── user_model.dart
│   │   │   │   ├── user_profile_model.dart
│   │   │   │   └── kyc_model.dart
│   │   │   ├── tournament/
│   │   │   │   ├── tournament_model.dart
│   │   │   │   ├── tournament_registration_model.dart
│   │   │   │   ├── room_details_model.dart
│   │   │   │   └── result_model.dart
│   │   │   ├── wallet/
│   │   │   │   ├── wallet_model.dart
│   │   │   │   └── transaction_model.dart
│   │   │   ├── payment/
│   │   │   │   ├── payment_model.dart
│   │   │   │   ├── razorpay_order_model.dart
│   │   │   │   └── withdrawal_request_model.dart
│   │   │   └── admin/
│   │   │       ├── admin_dashboard_model.dart
│   │   │       ├── dispute_model.dart
│   │   │       └── audit_log_model.dart
│   │   │
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   ├── tournament_repository.dart
│   │   │   ├── wallet_repository.dart
│   │   │   ├── payment_repository.dart
│   │   │   └── admin_repository.dart
│   │   │
│   │   └── services/
│   │       ├── firebase_service.dart
│   │       ├── payment_service.dart
│   │       └── notification_service.dart
│   │
│   ├── domain/                       # Domain layer (Entities, UseCases)
│   │   ├── entities/
│   │   │   ├── user_entity.dart
│   │   │   ├── tournament_entity.dart
│   │   │   ├── wallet_entity.dart
│   │   │   └── payment_entity.dart
│   │   │
│   │   └── usecases/
│   │       ├── auth/
│   │       │   ├── login_usecase.dart
│   │       │   ├── register_usecase.dart
│   │       │   ├── logout_usecase.dart
│   │       │   └── verify_device_usecase.dart
│   │       ├── tournament/
│   │       │   ├── get_tournaments_usecase.dart
│   │       │   ├── join_tournament_usecase.dart
│   │       │   ├── get_room_details_usecase.dart
│   │       │   └── submit_result_usecase.dart
│   │       ├── wallet/
│   │       │   ├── get_wallet_usecase.dart
│   │       │   ├── add_money_usecase.dart
│   │       │   └── request_withdrawal_usecase.dart
│   │       └── admin/
│   │           ├── create_tournament_usecase.dart
│   │           ├── manage_withdrawals_usecase.dart
│   │           └── resolve_dispute_usecase.dart
│   │
│   ├── presentation/                 # Presentation layer (UI)
│   │   ├── bloc/                     # State Management
│   │   │   ├── auth/
│   │   │   │   ├── auth_bloc.dart
│   │   │   │   ├── auth_event.dart
│   │   │   │   └── auth_state.dart
│   │   │   ├── tournament/
│   │   │   │   ├── tournament_bloc.dart
│   │   │   │   ├── tournament_event.dart
│   │   │   │   └── tournament_state.dart
│   │   │   ├── wallet/
│   │   │   │   ├── wallet_bloc.dart
│   │   │   │   ├── wallet_event.dart
│   │   │   │   └── wallet_state.dart
│   │   │   ├── payment/
│   │   │   │   ├── payment_bloc.dart
│   │   │   │   ├── payment_event.dart
│   │   │   │   └── payment_state.dart
│   │   │   └── admin/
│   │   │       ├── admin_bloc.dart
│   │   │       ├── admin_event.dart
│   │   │       └── admin_state.dart
│   │   │
│   │   ├── pages/
│   │   │   ├── auth/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── register_screen.dart
│   │   │   │   ├── otp_verification_screen.dart
│   │   │   │   └── phone_input_screen.dart
│   │   │   │
│   │   │   ├── home/
│   │   │   │   ├── home_screen.dart
│   │   │   │   ├── live_tournaments_tab.dart
│   │   │   │   ├── upcoming_tournaments_tab.dart
│   │   │   │   └── completed_tournaments_tab.dart
│   │   │   │
│   │   │   ├── tournament/
│   │   │   │   ├── tournament_detail_screen.dart
│   │   │   │   ├── tournament_list_screen.dart
│   │   │   │   ├── room_details_screen.dart
│   │   │   │   ├── result_submission_screen.dart
│   │   │   │   └── my_tournaments_screen.dart
│   │   │   │
│   │   │   ├── wallet/
│   │   │   │   ├── wallet_screen.dart
│   │   │   │   ├── add_cash_screen.dart
│   │   │   │   ├── withdraw_screen.dart
│   │   │   │   ├── transaction_history_screen.dart
│   │   │   │   └── payment_gateway_screen.dart
│   │   │   │
│   │   │   ├── profile/
│   │   │   │   ├── profile_screen.dart
│   │   │   │   ├── edit_profile_screen.dart
│   │   │   │   ├── kyc_screen.dart
│   │   │   │   ├── bank_details_screen.dart
│   │   │   │   └── settings_screen.dart
│   │   │   │
│   │   │   ├── admin/
│   │   │   │   ├── admin_home_screen.dart
│   │   │   │   ├── create_tournament_screen.dart
│   │   │   │   ├── manage_tournaments_screen.dart
│   │   │   │   ├── manage_withdrawals_screen.dart
│   │   │   │   ├── dispute_resolution_screen.dart
│   │   │   │   └── user_management_screen.dart
│   │   │   │
│   │   │   ├── splash/
│   │   │   │   └── splash_screen.dart
│   │   │   │
│   │   │   └── error/
│   │   │       └── error_screen.dart
│   │   │
│   │   └── widgets/
│   │       ├── tournament_card.dart
│   │       ├── wallet_card.dart
│   │       ├── user_profile_card.dart
│   │       ├── price_breakdown_widget.dart
│   │       ├── filter_widget.dart
│   │       ├── payment_method_selector.dart
│   │       └── custom_dialogs.dart
│   │
│   └── injection_container.dart      # Dependency Injection setup
│
├── test/                             # Unit & Widget tests
│   ├── unit/
│   │   ├── repositories/
│   │   ├── usecases/
│   │   └── blocs/
│   └── widget/
│       └── screens/
│
├── assets/                           # App assets
│   ├── images/
│   │   ├── logos/
│   │   ├── icons/
│   │   ├── illustrations/
│   │   └── game_banners/
│   ├── fonts/
│   │   └── poppins/
│   │       ├── Poppins-Regular.ttf
│   │       ├── Poppins-Bold.ttf
│   │       └── Poppins-SemiBold.ttf
│   └── animations/
│       └── lottie_files/
│
├── pubspec.yaml                      # Flutter dependencies
├── pubspec.lock
├── analysis_options.yaml              # Dart analysis config
├── README.md
├── CONTRIBUTING.md
├── firebase.json
├── .env.example
├── .gitignore
└── build_scripts/
    ├── build_apk.sh                  # APK build script
    ├── build_aab.sh                  # AAB (Play Store) build script
    ├── sign_apk.sh                   # APK signing script
    └── config.gradle                 # Build configuration
```

---

## 🏗️ Architecture Pattern: Clean Architecture + BLoC

### Layer Responsibilities:

1. **Presentation Layer** (`/presentation`)
   - UI Screens & Widgets
   - BLoC for State Management
   - User interactions

2. **Domain Layer** (`/domain`)
   - Business Logic (Use Cases)
   - Entity definitions
   - Repository interfaces (contracts)

3. **Data Layer** (`/data`)
   - Repository implementations
   - Data sources (Remote, Local)
   - Models (DTO mappings)

4. **Core Layer** (`/core`)
   - Constants
   - Utils
   - Common Widgets
   - Error Handling

---

## 📦 Key Dependencies

```yaml
# State Management & BLoC
flutter_bloc: ^8.1.0
bloc: ^8.1.0

# Firebase
firebase_core: ^2.24.0
firebase_auth: ^4.14.0
firebase_firestore: ^4.14.0
cloud_firestore: ^4.14.0
firebase_storage: ^11.5.0
firebase_messaging: ^14.6.0

# API & HTTP
http: ^1.1.0
dio: ^5.3.0

# Payment Gateway
razorpay_flutter: ^1.3.0

# Phone Authentication
firebase_phone_auth_handler: ^1.1.0

# Storage & Security
flutter_secure_storage: ^9.0.0
shared_preferences: ^2.2.0

# Image & Media
image_picker: ^1.0.0
video_player: ^2.7.0

# Networking & Connectivity
connectivity_plus: ^5.0.0

# GetIt for Dependency Injection
get_it: ^7.6.0

# Freezed for models
freezed_annotation: ^2.4.0
json_annotation: ^4.8.0

# API client generation
retrofit: ^4.1.0

# Localization
easy_localization: ^3.0.0

# Date/Time
intl: ^0.19.0

# Charts (for stats)
fl_chart: ^0.63.0

# Animation
lottie: ^2.4.0

# Device Info
device_info_plus: ^10.0.0

# Permission handling
permission_handler: ^11.0.0

# QR Code Scanner
qr_code_scanner: ^1.0.0

# PDF export
pdf: ^3.10.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  retrofit_generator: ^7.0.0
  mockito: ^5.4.0
  bloc_test: ^9.1.0
```

---

## 🔐 Security Features

1. **Device ID Tracking** - Prevent multiple account creation
2. **Secure Token Storage** - JWT/Firebase tokens in secure storage
3. **Certificate Pinning** - For API communication
4. **Biometric Authentication** - Optional PIN/fingerprint
5. **API Rate Limiting** - Prevent brute force attacks
6. **Input Validation** - All user inputs validated
7. **Error Handling** - Never expose sensitive data in errors

---

## 🚀 Build & Deployment

### APK Build Command:
```bash
flutter clean
flutter pub get
flutter build apk --release --split-per-abi
```

### AAB (Play Store) Build Command:
```bash
flutter build appbundle --release
```

### Signed APK:
```bash
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
  -keystore keystore.jks app-release-unsigned.apk key-alias
```

---

## 📝 Environment Setup

Create `.env` file:
```
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_APP_ID=your_app_id
RAZORPAY_KEY_ID=your_key_id
RAZORPAY_KEY_SECRET=your_key_secret
API_BASE_URL=https://your-api.com
```

---

## ✅ Development Workflow

1. **Feature Branch**: `git checkout -b feature/feature-name`
2. **Unit Tests**: Write tests in `test/`
3. **Widget Tests**: Test UI components
4. **Build Locally**: `flutter run` or `flutter run --release`
5. **Code Review**: PR with 2 approvals
6. **Merge**: Squash and merge to main
7. **Release**: Tag version and build APK/AAB

---
