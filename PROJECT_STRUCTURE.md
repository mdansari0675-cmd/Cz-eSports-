# AxiovaX Project Structure

## Directory Explanation

### `/presentation`
**Purpose**: User Interface Layer

- **pages/**: Screen implementations
  - `home/`: Main home screen for players
  - `admin/`: Admin dashboard screens
  - `auth/`: Authentication screens (login, OTP, KYC)
  - `wallet/`: Wallet management screens
  - `tournament/`: Tournament detail and participation screens

- **bloc/**: State management with BLoC pattern
  - `auth/`: Authentication state management
  - `tournament/`: Tournament data state management
  - `wallet/`: Wallet and transaction state management

- **widgets/**: Reusable UI components
  - Common buttons, cards, dialogs
  - Custom widgets used across screens

### `/domain`
**Purpose**: Business Logic Layer (Interfaces)

- **repositories/**: Abstract repository interfaces
  - Define contracts that data layer must implement
  - Example: `AuthRepository`, `TournamentRepository`

- **usecases/**: Business logic orchestration
  - Handle specific business operations
  - Example: `LoginUseCase`, `JoinTournamentUseCase`
  - Implement dependency on repositories

### `/data`
**Purpose**: Data Access Layer (Implementation)

- **services/**: External service integration
  - `firebase_service.dart`: Firebase initialization
  - `payment_service.dart`: Razorpay integration
  - `api_service.dart`: REST API calls

- **datasources/**: Data fetching implementation
  - `remote_datasource.dart`: Firebase/API data
  - `local_datasource.dart`: SharedPreferences/SQLite data

- **repositories/**: Concrete repository implementations
  - Implement domain repository interfaces
  - Combine remote + local datasources
  - Example: `AuthRepositoryImpl`, `TournamentRepositoryImpl`

- **models/**: Data models with serialization
  - Freezed models for immutability
  - JSON serialization with `json_serializable`
  - Firestore conversion methods

### `/core`
**Purpose**: Shared Utilities & Constants

- **constants/**: App-wide constants
  - `app_constants.dart`: API URLs, timeouts
  - `app_theme.dart`: Color scheme, typography
  - `app_strings.dart`: UI text strings

- **utils/**: Helper functions
  - `validators.dart`: Form validation
  - `logger.dart`: Logging utility
  - `device_utils.dart`: Device-specific utilities
  - `date_utils.dart`: Date formatting

- **error/**: Error handling
  - `exceptions.dart`: Custom exceptions
  - `failures.dart`: Error response objects

- **widgets/**: Global reusable widgets
  - Common app bars
  - Loading indicators
  - Error dialogs

---

## File Organization Example

### Adding a New Feature (Search Tournaments)

1. **Domain Layer** (`domain/`)
   ```
   domain/
   ├── repositories/
   │   └── search_repository.dart (interface)
   └── usecases/
       └── search_tournaments_usecase.dart
   ```

2. **Data Layer** (`data/`)
   ```
   data/
   ├── datasources/
   │   └── search_datasource.dart (implementation)
   ├── repositories/
   │   └── search_repository_impl.dart
   └── models/
       └── search_result_model.dart
   ```

3. **Presentation Layer** (`presentation/`)
   ```
   presentation/
   ├── pages/
   │   └── search/
   │       └── search_tournament_screen.dart
   ├── bloc/
   │   └── search/
   │       ├── search_event.dart
   │       ├── search_state.dart
   │       └── search_bloc.dart
   └── widgets/
       └── search_tournament_card.dart
   ```

---

## Naming Conventions

### Files
- Use `snake_case` for file names
- Example: `user_repository.dart`, `home_screen.dart`

### Classes
- Use `PascalCase` for class names
- Example: `UserRepository`, `HomeScreen`, `AuthBloc`

### Variables & Functions
- Use `camelCase` for variables and functions
- Example: `userEmail`, `getTournamentList()`, `isValid`

### Constants
- Use `UPPER_SNAKE_CASE` for constants
- Example: `MAX_ENTRY_FEE = 5000`, `API_TIMEOUT = 30`

### Event/State Classes
- Name with action verb + noun
- Example: `LoginWithGoogle`, `FetchTournamentsSuccess`, `WithdrawalApproved`

---

## Dependency Flow

```
Presentation (BLoC)
    ↓
 Domain (UseCase)
    ↓
 Data (Repository Implementation)
    ↓
 Services/DataSources
    ↓
 Firebase/API/Local Storage
```

**Important**: Never import from layer below domain into upper layer directly.
- Presentation → uses → Domain (interfaces only)
- Domain → uses → abstractions only
- Data → implements → Domain interfaces

---

## Adding New Pages

1. Create folder in `presentation/pages/`
2. Create corresponding BLoC in `presentation/bloc/`
3. Create models in `data/models/` if needed
4. Create repository in `domain/repositories/`
5. Implement repository in `data/repositories/`
6. Add route in `main.dart`

---

## Configuration Files

- `.env`: Environment variables (not in git)
- `pubspec.yaml`: Dependencies and project config
- `firebase_options.dart`: Firebase project configuration
- `analysis_options.yaml`: Dart linter rules
- `.github/workflows/`: CI/CD configurations

---

**Last Updated**: August 18, 2026
