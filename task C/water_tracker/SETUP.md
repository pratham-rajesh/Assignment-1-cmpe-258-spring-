# Water Tracker - Setup Guide

## Quick Start

This Flutter app is ready to run! Follow these steps to get started.

### Prerequisites

1. **Flutter SDK** (3.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter doctor`

2. **Development Environment**
   - **For Android**: Android Studio with Android SDK
   - **For iOS**: Xcode (macOS only)

### Installation Steps

1. **Navigate to the project directory**
   ```bash
   cd water_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For Android
   flutter run
   
   # For iOS (macOS only)
   flutter run -d ios
   
   # For specific device
   flutter devices  # List available devices
   flutter run -d <device-id>
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Android App Bundle (for Play Store):**
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**iOS (macOS only):**
```bash
flutter build ios --release
# Then open Xcode to archive and distribute
```

## Project Structure

```
water_tracker/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── models/                      # Freezed data models
│   │   ├── water_entry.dart
│   │   ├── daily_summary.dart
│   │   └── app_settings.dart
│   ├── providers/                   # Riverpod state management
│   │   ├── storage_provider.dart
│   │   ├── settings_provider.dart
│   │   └── water_provider.dart
│   ├── services/                    # Business logic
│   │   ├── storage_service.dart
│   │   └── notification_service.dart
│   ├── screens/                     # UI screens
│   │   ├── home_screen.dart
│   │   ├── tracking_screen.dart
│   │   ├── history_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/                     # Reusable components
│       ├── glass_card.dart
│       ├── glass_button.dart
│       └── progress_ring.dart
├── android/                         # Android configuration
├── ios/                             # iOS configuration
└── pubspec.yaml                     # Dependencies
```

## Features Overview

### 🎯 Tracking Screen
- Animated progress ring showing daily goal completion
- Quick-add buttons (100ml, 250ml, 500ml, 750ml)
- Custom amount input
- Today's log with delete functionality
- Real-time progress updates

### 📊 History Screen
- 7-day bar chart visualization
- Current streak counter (consecutive days meeting goal)
- Daily breakdown list with goal completion status
- Visual indicators for goal achievement

### ⚙️ Settings Screen
- Daily goal customization
- Unit toggle (ml/oz)
- Reminder configuration:
  - Enable/disable reminders
  - Set start and end times
  - Choose interval (1-6 hours)

## Technical Highlights

### State Management
- **Riverpod** for reactive state management
- Providers for settings, water entries, and computed values
- Automatic persistence to local storage

### Data Models
- **Freezed** for immutable data classes
- **json_serializable** for JSON serialization
- Type-safe models with copyWith functionality

### Local Storage
- **shared_preferences** for data persistence
- Versioned storage keys for future migrations
- Automatic save on data changes

### Notifications
- **flutter_local_notifications** for reminders
- Timezone-aware scheduling
- Configurable reminder windows

### UI/UX
- **Glassmorphism** design with frosted glass effects
- **BackdropFilter** for blur effects
- Smooth animations with AnimationController
- Haptic feedback on interactions
- Responsive layout for all screen sizes

## Customization

### Change Default Daily Goal
Edit `lib/models/app_settings.dart`:
```dart
@Default(2000) int dailyGoalMl,  // Change 2000 to your preferred default
```

### Modify Quick-Add Amounts
Edit `lib/screens/tracking_screen.dart`:
```dart
_QuickAddButton(amount: 100, ...),  // Modify these amounts
_QuickAddButton(amount: 250, ...),
_QuickAddButton(amount: 500, ...),
_QuickAddButton(amount: 750, ...),
```

### Adjust Color Scheme
Edit `lib/main.dart` and widget files to customize colors:
- Primary blue: `Color(0xFF4FC3F7)`
- Dark blue: `Color(0xFF0277BD)`
- Background gradient: `Color(0xFFE3F2FD)` to `Color(0xFF90CAF9)`

## Troubleshooting

### "flutter: command not found"
- Ensure Flutter is installed and added to PATH
- Run: `export PATH="$PATH:[PATH_TO_FLUTTER]/flutter/bin"`

### Android build fails
- Run: `flutter clean && flutter pub get`
- Check Android SDK is installed
- Verify `ANDROID_HOME` environment variable

### iOS build fails (macOS)
- Run: `cd ios && pod install && cd ..`
- Open Xcode and accept licenses
- Ensure Xcode Command Line Tools are installed

### Notifications not working
- **Android**: Ensure app has notification permissions
- **iOS**: Check notification permissions in Settings
- Restart app after enabling reminders

## Performance Tips

- The app uses efficient state management with Riverpod
- Data is persisted incrementally (not on every change)
- Charts are optimized for 7-day windows
- Images and assets are minimal for fast load times

## Support

For issues or questions:
1. Check Flutter documentation: https://flutter.dev/docs
2. Review Riverpod docs: https://riverpod.dev
3. Check package documentation in pubspec.yaml

## License

This is a demonstration project created for educational purposes.

---

**Version**: 1.0.0  
**Flutter**: 3.x  
**Dart**: 3.x
