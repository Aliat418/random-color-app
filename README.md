# random_color_app

# Random Color App

A Flutter application that provides color management functionality with support for both simple and custom color generation. The app demonstrates clean architecture, dependency injection, and state management using BLoC pattern.

## Features

- Random color generation using two different algorithms:
  - Simple random generation using Dart's Random class
  - Custom generation using system-based entropy (not currently active)
- Accessible color selection for text based on background color
- Animated color transitions
- Internationalization support
- State management using flutter_bloc

## Requirements

### Environment
- Flutter SDK: ^3.5.4
- Dart SDK: >=3.0.0

### Core Dependenciesdependencies:
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
├── infrastructure/           # Dependency injection setup
│   ├── di.config.dart
│   ├── di.dart
│   └── locator.dart
├── model/                   # Data models
│   └── app_color.dart       # Color representation model
├── page/                    # UI components
│   ├── color_changing_cubit.dart    # Business logic
│   ├── color_changing_page.dart     # Main UI screen
│   └── color_changing_state.dart    # State management
├── repository/              # Data layer
│   └── color_repository.dart        # Color management
├── service/                # Business logic
│   └── color_changing_service.dart  # Color generation implementations
└── utils/                  # Helper functions
    ├── app_color_utils.dart
    ├── build_context_ext.dart
    └── main.dart

## Implementation Details

### Color Generation
The app implements two color generation strategies:

1. SimpleColorChangingService
   - Uses Dart's Random class for RGB value generation
   - Currently active in the application
     Future<AppColor> generateRandomColor() async => AppColor(
     red: _random.nextInt(256),
     green: _random.nextInt(256),
     blue: _random.nextInt(256),
   );
   
2. CustomColorChangingService
   - Implements system-based entropy for color generation
   - Uses platform-specific information for seed generation
   - Currently implemented but not active

### State Management
- Uses flutter_bloc for state management
- Implements ColorChangingCubit for handling color state changes
- Supports loading, error, and loaded states
- Manages both current and new colors for animation purposes

### UI Features
- Animated color transitions using AnimationController
- Responsive text color adjustment for accessibility
- Tap interaction for color changes
- Color change counter
- Internationalized text support

## Getting Started

1. Clone the repositorygit clone [https://github.com/Aliat418/random-color-app.git]

2. Install dependenciesflutter pub get

3. Generate dependency injection codeflutter pub run build_runner build

4. Run the appflutter run

## Usage

The app provides a simple tap interface:
- Tap anywhere on the screen to generate new colors
- The background will animate to the new color
- Text color automatically adjusts for readability
- A counter keeps track of how many times you've changed colors

## Architecture

The application follows clean architecture principles:
- Repository Pattern: ColorRepository manages color generation strategies
- Service Layer: Implements different color generation algorithms
- Dependency Injection: Uses injectable for dependency management
- State Management: Uses flutter_bloc for managing application state
- UI Layer: Implements animated color transitions and accessibility features

## License

This project is licensed under the MIT License - see the LICENSE file for details
