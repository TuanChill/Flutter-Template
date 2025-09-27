# Flutter Build and Deployment Guide

This guide covers building and deploying the Flutter application for both Android and iOS platforms, including key generation, signing, and store deployment.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Environment Configuration](#environment-configuration)
- [Android Build and Deployment](#android-build-and-deployment)
- [iOS Build and Deployment](#ios-build-and-deployment)
- [Testing Builds](#testing-builds)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software
- **Flutter SDK**: Latest stable version
- **Android Studio**: For Android development
- **Xcode**: For iOS development (macOS only)
- **CocoaPods**: For iOS dependencies
- **Java Development Kit (JDK)**: Version 8 or higher

### Development Environment Setup
1. Install Flutter SDK from [official website](https://flutter.dev/docs/get-started/install)
2. Set up Android Studio with Flutter plugin
3. Install Xcode (macOS only)
4. Configure iOS development environment:
   ```bash
   sudo gem install cocoapods
   ```

## Environment Configuration

The project supports multiple environments:
- **Development**: `main_development.dart`
- **Staging**: `main_staging.dart`
- **Production**: `main_production.dart`

### Build Flavors
- **Development**: Debug builds with development configurations
- **Staging**: Release builds for testing with staging backend
- **Production**: Release builds for app stores

## Android Build and Deployment

### 1. Generate Signing Key

Create a keystore for signing your APK/AAB:

```bash
# Generate keystore
keytool -genkey -v -keystore android/app/key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias key -keypass your_key_password -storepass your_store_password \
  -dname "CN=Your Name, OU=Your Unit, O=Your Organization, L=Your City, ST=Your State, C=US"
```

### 2. Configure Signing in Gradle

Update `android/app/build.gradle`:

```gradle
android {
    // ... existing config ...

    signingConfigs {
        release {
            keyAlias 'key'
            keyPassword 'your_key_password'
            storeFile file('../key.jks')
            storePassword 'your_store_password'
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

### 3. Update Key Properties

Create/update `android/key.properties`:

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=key
storeFile=key.jks
```

### 4. Build Commands

#### Development Build (APK)
```bash
flutter build apk --debug --flavor development
```

#### Staging Build (APK)
```bash
flutter build apk --release --flavor staging
```

#### Production Build (APK)
```bash
flutter build apk --release --flavor production
```

#### App Bundle (AAB) for Google Play
```bash
flutter build appbundle --release --flavor production
```

### 5. Deploy to Google Play

1. **Create App on Google Play Console**
   - Go to [Google Play Console](https://play.google.com/apps/publish)
   - Create new application
   - Fill in app details

2. **Upload AAB**
   - Go to Release > Production
   - Upload your AAB file
   - Add release notes
   - Submit for review

3. **Internal Testing**
   ```bash
   flutter build appbundle --release --flavor staging
   ```

## iOS Build and Deployment

### 1. Development Team Setup

1. **Create Apple Developer Account**
   - Go to [Apple Developer](https://developer.apple.com)
   - Enroll in Apple Developer Program ($99/year)

2. **Create App ID**
   - Go to Certificates, Identifiers & Profiles
   - Create new App ID with your bundle identifier

3. **Create Development Certificate**
   ```bash
   # Generate Certificate Signing Request (CSR)
   keychain Access -> Certificate Assistant -> Request a Certificate
   ```

4. **Create Provisioning Profile**
   - Go to Profiles section
   - Create Development Provisioning Profile
   - Select your App ID and certificates

### 2. Configure Xcode Project

1. **Update Bundle Identifier**
   - Open `ios/Runner.xcodeproj`
   - Update bundle identifier in General tab

2. **Configure Signing**
   - Go to Signing & Capabilities
   - Select your Development Team
   - Enable automatic signing or manual configuration

3. **Add Capabilities**
   - Push Notifications (if needed)
   - Background Modes (if needed)
   - Keychain Sharing (if needed)

### 3. Build Commands

#### Development Build
```bash
flutter build ios --debug --flavor development
```

#### Staging Build
```bash
flutter build ios --release --flavor staging
```

#### Production Build
```bash
flutter build ios --release --flavor production
```

### 4. Archive and Upload

1. **Archive in Xcode**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select Product > Archive
   - Choose your build configuration

2. **Upload to App Store Connect**
   - In Xcode Organizer, select your archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Follow the distribution process

3. **Submit for Review**
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Select your app
   - Go to TestFlight or App Store tab
   - Submit for review

### 5. TestFlight Deployment

1. **Upload Build to TestFlight**
   ```bash
   # Build and archive
   flutter build ios --release --flavor staging
   # Then archive and upload via Xcode
   ```

2. **Add Testers**
   - In App Store Connect, go to TestFlight
   - Add external testers
   - Provide tester emails

## Testing Builds

### 1. Install on Device

#### Android
```bash
# Connect device and enable USB debugging
flutter install --flavor development
```

#### iOS
```bash
# Connect device
flutter install --flavor development
```

### 2. Firebase App Distribution (Optional)

For easier testing distribution:

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Distribute Android APK
firebase appdistribution:distribute android/app/build/outputs/apk/release/app-release.apk \
  --app YOUR_FIREBASE_APP_ID \
  --groups "testers"

# Distribute iOS IPA
firebase appdistribution:distribute path/to/your.ipa \
  --app YOUR_FIREBASE_APP_ID \
  --groups "testers"
```

## Troubleshooting

### Common Android Issues

1. **Build Failed: Keystore Issues**
   - Ensure `key.jks` is in `android/app/` directory
   - Check `key.properties` file exists and has correct values
   - Verify keystore passwords match

2. **Gradle Sync Failed**
   ```bash
   # Clean and rebuild
   flutter clean
   flutter pub get
   ```

3. **Device Not Recognized**
   - Enable USB debugging in developer options
   - Accept RSA fingerprint on device

### Common iOS Issues

1. **Certificate/Provisioning Profile Issues**
   ```bash
   # Clean build folder
   flutter clean
   # Regenerate certificates if needed
   ```

2. **CocoaPods Issues**
   ```bash
   cd ios
   pod deintegrate
   pod install
   cd ..
   ```

3. **Simulator Issues**
   - Ensure Xcode command line tools are installed
   - Try different simulator device

### Environment-Specific Issues

1. **Flavor Configuration**
   - Check `main_*.dart` files for correct configurations
   - Verify environment-specific constants

2. **Asset Issues**
   - Ensure all assets are properly defined in `pubspec.yaml`
   - Check asset paths and naming conventions

### Performance Optimization

1. **Android**
   - Enable R8/ProGuard for release builds
   - Use APK splits for different architectures
   - Enable resource shrinking

2. **iOS**
   - Use bitcode (if required)
   - Optimize for specific architectures
   - Enable app thinning

## Security Best Practices

1. **Key Management**
   - Store keystores securely
   - Use different keys for different environments
   - Never commit keys to version control

2. **Certificate Management**
   - Regularly renew certificates before expiry
   - Use separate certificates for development and distribution
   - Keep provisioning profiles updated

3. **App Security**
   - Enable app signing
   - Use secure API endpoints
   - Implement certificate pinning for production


## Support and Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Android Developers](https://developer.android.com)
- [Apple Developer Documentation](https://developer.apple.com/documentation)
- [Google Play Console Help](https://support.google.com/googleplay)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)