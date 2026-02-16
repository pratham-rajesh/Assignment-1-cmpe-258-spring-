# Water Tracker

A premium Flutter mobile app for tracking daily water intake with a beautiful glassmorphism UI.

## Features

### 🎯 Core Features
- **Water Intake Tracking**: Log water consumption throughout the day
- **Daily Goals**: Set and track progress toward daily hydration goals
- **Quick Add Buttons**: Quickly log common amounts (100ml, 250ml, 500ml, 750ml)
- **Custom Amounts**: Add custom water amounts
- **Unit Toggle**: Switch between milliliters (ml) and ounces (oz)

### 📊 History & Insights
- **7-Day Chart**: Visual bar chart showing last 7 days of water intake
- **Streak Tracking**: Track consecutive days of meeting your goal
- **Daily Breakdown**: Detailed list of daily totals with goal completion status

### 🔔 Smart Reminders
- **Customizable Schedule**: Set reminder window (start/end time)
- **Flexible Intervals**: Choose reminder frequency (1-6 hours)
- **Easy Toggle**: Enable/disable reminders with one tap

### 🎨 Premium UI/UX
- **Glassmorphism Design**: Frosted glass cards with blur effects
- **Smooth Animations**: Subtle scale and fade animations
- **Haptic Feedback**: Tactile responses for interactions
- **Progress Ring**: Animated circular progress indicator
- **Responsive Design**: Optimized for all phone sizes

## Technical Stack

- **Framework**: Flutter 3.x
- **State Management**: Riverpod
- **Data Models**: Freezed + json_serializable
- **Local Storage**: shared_preferences
- **Charts**: fl_chart
- **Notifications**: flutter_local_notifications
- **Architecture**: Clean architecture with separation of concerns

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models with Freezed
│   ├── water_entry.dart
│   ├── daily_summary.dart
│   └── app_settings.dart
├── providers/                # Riverpod state management
│   ├── storage_provider.dart
│   ├── settings_provider.dart
│   └── water_provider.dart
├── services/                 # Business logic services
│   ├── storage_service.dart
│   └── notification_service.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── tracking_screen.dart
│   ├── history_screen.dart
│   └── settings_screen.dart
└── widgets/                  # Reusable UI components
    ├── glass_card.dart
    ├── glass_button.dart
    └── progress_ring.dart
```

## Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository
2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Configuration

### Android Permissions
The app requires the following permissions (already configured):
- `VIBRATE` - For haptic feedback
- `RECEIVE_BOOT_COMPLETED` - For persistent reminders
- `SCHEDULE_EXACT_ALARM` - For precise reminder timing
- `POST_NOTIFICATIONS` - For displaying notifications

### iOS Permissions
Background modes are configured for notifications in `Info.plist`.

## Data Persistence

All data is stored locally using `shared_preferences`:
- Water entries are saved with timestamps
- Settings persist across app restarts
- Storage includes version key for future migrations

## State Management

The app uses **Riverpod** for state management with the following providers:
- `storageServiceProvider` - Manages local storage
- `settingsProvider` - App settings and preferences
- `waterProvider` - Water entry management
- `todayTotalProvider` - Today's total water intake
- `dailySummariesProvider` - Historical data summaries
- `currentStreakProvider` - Goal streak calculation

## Design Philosophy

The app follows a **glassmorphism** design language:
- Frosted glass effects with backdrop blur
- Translucent cards with subtle borders
- Soft color palette (light blues, whites)
- Gentle gradients for depth
- Premium, modern aesthetic

## Testing

The architecture separates business logic from UI, making it easy to test:
- Models are immutable with Freezed
- Providers contain testable business logic
- Services are isolated and mockable

## License

This project is created as a demonstration app.

## Version

**v1.0.0** - Initial release
