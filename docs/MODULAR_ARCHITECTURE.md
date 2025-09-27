# Modular Architecture - Flutter Template

## Overview

The Flutter Template project has been restructured according to modular architecture with Clean Architecture and SOLID principles. This architecture helps:

- **Clear separation** of concerns
- **Easy testing** and maintenance
- **Scalable** and **maintainable**
- **Reusable** components
- **Centralized dependency injection**

## Directory Structure

```
lib/
├── core/                          # Core utilities and base classes
│   ├── constants/                 # App constants
│   ├── error/                     # Error handling
│   │   ├── failures.dart          # Abstract failure classes
│   │   └── exceptions.dart        # Exception classes
│   │── env/                       # Environment configurations
│   ├── network/                   # HTTP client
│   ├── storage/                   # Local storage
│   ├── theme/                     # App theme
│   ├── utils/                     # Utility functions
│   ├── extensions/                # Dart extensions
│   ├── bloc/                      # Base BLoC classes
│   ├── di/                        # Dependency injection
│   └── router/                    # App routing
├── shared/                        # Shared components
│   ├── widgets/                   # Common widgets
│   └── models/                    # Shared models
├── features/                      # Feature modules
│   ├── authentication/            # Auth feature
│   │   ├── domain/
│   │   │   └── entities/
│   │   └── presentation/
│   │       ├── pages/
│   │       └── cubit/
│   ├── home/                      # Home feature
│   └── profile/                   # Profile feature
├── app/                           # App configuration
├── l10n/                          # Internationalization
└── bootstrap.dart                 # App bootstrap
```

## Core Modules

### 1. Constants (`lib/core/constants/`)
- `app_constants.dart`: Contains all app constants

### 2. Error Handling (`lib/core/error/`)
- `failures.dart`: Abstract failure classes
- `exceptions.dart`: Exception classes

### 3. Network (`lib/core/network/`)
- `api_client.dart`: Dio HTTP client with error handling

### 4. Storage (`lib/core/storage/`)
- `local_storage.dart`: Abstract storage interface
- Implementation with SharedPreferences

### 5. Theme (`lib/core/theme/`)
- `app_theme.dart`: App theme configuration for healthcare

### 6. Utils (`lib/core/utils/`)
- `validators.dart`: Form validation utilities

### 7. Extensions (`lib/core/extensions/`)
- `date_time_extension.dart`: DateTime utilities
- `string_extension.dart`: String utilities

### 8. BLoC Base (`lib/core/bloc/`)
- `base_state.dart`: Base state with status enum
- `base_cubit.dart`: Base cubit with error handling

### 9. Dependency Injection (`lib/core/di/`)
- `injection.dart`: GetIt configuration
- `injection.config.dart`: Generated DI config

### 10. Router (`lib/core/router/`)
- `app_router.dart`: Go Router configuration
- `auth_guard.dart`: Authentication guard for route protection

## Shared Components

### Widgets (`lib/shared/widgets/`)
- `custom_button.dart`: Reusable button component
- `custom_text_field.dart`: Reusable text field
- `loading_widget.dart`: Loading indicators
- `error_widget.dart`: Error display widget

### Models (`lib/shared/models/`)
- `app_error.dart`: Standardized error model

## Features

### Authentication (`lib/features/authentication/`)
- **Domain**: User entity
- **Presentation**: Login/Register pages with AuthCubit

### Home (`lib/features/home/`)
- **Presentation**: Home page with quick actions

### Profile (`lib/features/profile/`)
- **Presentation**: Profile page with user info

## Authentication Flow

The application uses authentication guard to automatically redirect:

1. **Unauthenticated users** → Redirect to `/login`
2. **Authenticated users accessing auth routes** → Redirect to `/home`
3. **Protected routes** require authentication
4. **Login/Register** has mock authentication with credentials:
   - Email: `test@example.com`
   - Password: `password123`

## Used Dependencies

### Core Dependencies
- `get_it`: Dependency injection
- `injectable`: Code generation for DI
- `dio`: HTTP client
- `shared_preferences`: Local storage
- `go_router`: Routing
- `equatable`: Value equality
- `dartz`: Functional programming

### State Management
- `bloc`: Business logic component
- `flutter_bloc`: Flutter integration

### Development
- `injectable_generator`: Code generation
- `build_runner`: Build tools

## Usage

### 1. Adding New Feature

```dart
// 1. Create directory structure
lib/features/new_feature/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── pages/
    ├── widgets/
    └── cubit/

// 2. Register dependencies in injection.dart
// 3. Add routes in app_router.dart
```

### 2. Creating New Widget

```dart
// Extend from shared widgets or create new in feature
class CustomHealthWidget extends StatelessWidget {
  // Implementation
}
```

### 3. Creating New Cubit

```dart
@injectable
class NewFeatureCubit extends BaseCubit<NewFeatureState> {
  NewFeatureCubit() : super(const NewFeatureState());

  // Business logic
}
```

## Testing

This architecture supports good testing with:
- **Unit tests** for business logic
- **Widget tests** for UI components
- **Integration tests** for user flows
- **Mock dependencies** with GetIt

## Best Practices

1. **Separation of Concerns**: Each module has its own responsibility
2. **Dependency Inversion**: Depend on abstractions, not concretions
3. **Single Responsibility**: Each class has a single responsibility
4. **Open/Closed Principle**: Open for extension, closed for modification
5. **Interface Segregation**: Clients do not depend on unused interfaces

## Benefits

- ✅ **Maintainable**: Easy to maintain and extend
- ✅ **Testable**: Easy to write tests
- ✅ **Scalable**: Can scale with team and features
- ✅ **Reusable**: Components can be reused
- ✅ **Clean**: Clean and organized code

