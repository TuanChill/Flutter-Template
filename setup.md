# Flutter Template Installation Guide

## Prerequisites

### FVM (Flutter Version Management)
Install FVM to manage Flutter versions.

- **macOS**:
  ```bash
  brew install fvm
  ```

- **Windows**:
  Download the latest release from [FVM GitHub](https://github.com/leoafarias/fvm/releases) and add to PATH, or use:
  ```bash
  dart pub global activate fvm
  ```

- **Linux**:
  ```bash
  snap install fvm
  ```
  Or:
  ```bash
  dart pub global activate fvm
  ```

### Flutter SDK
Install Flutter using FVM (works on all platforms):
```bash
fvm install 3.35.4
```

### Android Studio
Download and install from [official site](https://developer.android.com/studio). Ensure Android SDK is set up. (Available for Windows, macOS, Linux)

### Xcode
For iOS development on macOS only: Install from App Store. Ensure command line tools are installed:
```bash
xcode-select --install
```

### Other Tools
- Git
- Optionally, Visual Studio Code with Flutter extensions (available for all platforms)

## Project Setup

1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd Flutter_Template
   ```

2. Use FVM to set the Flutter version:
   ```bash
   fvm use
   ```

3. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

4. For iOS development:
   ```bash
   cd ios
   pod install
   cd ..
   ```

## Running the Application

This project supports multiple environments: development, staging, and production.

- **Development**:
  ```bash
  flutter run --flavor development --target lib/main_development.dart
  ```

- **Staging**:
  ```bash
  flutter run --flavor staging --target lib/main_staging.dart
  ```

- **Production**:
  ```bash
  flutter run --flavor production --target lib/main_production.dart
  ```

## Additional Notes

- Ensure devices are connected or emulators/simulators are running.
- For Android, accept licenses: `flutter doctor --android-licenses`
- Check your setup: `flutter doctor`
- The project uses flavors for different environments, with separate entry points and configurations.