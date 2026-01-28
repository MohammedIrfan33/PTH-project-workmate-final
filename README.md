# PTH Project

A Flutter mobile application for Android and iOS.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or higher)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) (for iOS)
- Git

## Clone Repository

```bash
git clone <repository-url>
cd PTH-project
```

## Installation

```bash
# Install dependencies
flutter pub get

# For iOS, install pods
cd ios && pod install && cd ..
```

## Running the App

```bash
# Check connected devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device_id>
```

## Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## Project Structure

```
lib/
├── ApiLists/       # API endpoints and app data
├── Appcore/        # Core app configuration
├── Bindders/       # GetX bindings
├── controller/     # GetX controllers
├── modles/         # Data models
├── Observers/      # Route observers
├── screens/        # UI screens
├── Utils/          # Utility classes and colors
└── widgets/        # Reusable widgets
```

## Clean Build

```bash
flutter clean
flutter pub get
```
