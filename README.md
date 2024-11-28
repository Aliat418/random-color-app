# Random Color App

A Flutter application that provides color management functionality with support for both simple and custom color generation. The app demonstrates clean architecture, dependency injection, and state management using BLoC pattern.

## Features

- Random color generation using two different algorithms:
  - Simple random generation using Dart's Random class
  - Custom generation using system-based entropy (not currently active)
- Accessible color selection for text based on background color
- Animated color transitions
- Internationalization support
- Clean architecture implementation

## Tech Stack

### Environment
- Flutter SDK: ^3.5.4
- Dart SDK: >=3.0.0

### Dependencies
dependencies:
  equatable: ^2.0.7
  flutter_bloc: ^8.1.6
  get_it: ^8.0.2
  injectable: ^2.5.0
  intl: ^0.19.0
  solid_lints: ^0.2.3

dev_dependencies:
  build_runner: ^2.4.13
  flutter_lints: ^4.0.0
  flutter_test: SDK
  injectable_generator: ^2.6.2
  integration_test: SDK

## Project Structure

lib/
├── core/                    # Core functionality
│   ├── extension/          
│   ├── infrastructure/      # DI setup
│   └── util/
├── data/                    # Data layer
│   ├── repository/
│   └── service/
│       ├── accessible_color_mixin.dart
│       ├── color_changing_service.dart
│       ├── custom_color_changing_service.dart
│       └── simple_color_changing_service.dart
├── domain/                  # Domain layer
│   └── model/
│       └── app_color.dart
├── presentation/           # Presentation layer
│   ├── app/
│   └── color_changing_page/
└── l10n/                   # Localization

## Implementation Details

### Color Generation
- SimpleColorChangingService: Uses Random for RGB values (0-255)
- CustomColorChangingService: Uses system entropy for unique seeds
- Accessible color calculation based on background luminance

### State Management
- BLoC pattern with Cubit implementation
- Handles loading, error, and success states
- Manages animation states and color transitions
- Tracks color change count

### UI Features
- Material Design implementation
- Color transitions with AnimationController
- Adaptive text colors for readability
- Tap anywhere to change colors
- Internationalized UI text

## Testing
test/
 └── data/                   # Data layer tests
    ├── repository/
    └── service/

- Unit tests for all services and repository

## Getting Started

1. Clone and setup:

git clone [repository-url]
cd random-color-app
flutter pub get

2. Generate dependencies:

flutter pub run build_runner build

3. Run tests:

flutter test

4. Launch application:

flutter run

## Usage

- Launch app to see initial random color
- Tap screen to generate new background color
- Watch smooth transition animation
- Text color automatically adjusts for contrast
- Counter shows number of changes
- Supports light/dark text adaptation

## Architecture

Clean Architecture implementation with:
- Domain Layer: Core business logic and entities
- Data Layer: Repository and service implementations
- Presentation Layer: UI and state management
- Core Layer: Shared utilities and infrastructure

## License

This project is licensed under the MIT License - see the LICENSE file for details.