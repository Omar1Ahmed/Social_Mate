# Flutter Clean Architecture Demo

A demo Flutter application illustrating a Clean Architecture implementation with Cubit state management, dependency injection using Injectable, robust error handling via a Result/Failure pattern, and a Task Management feature.

**Features**

- **Clean Architecture**: Clear separation between Presentation, Domain, and Data layers to improve testability and maintainability. (Implemented by: Ahmed Developer)
- **Cubit State Management**: Lightweight reactive state management using Cubit from the Bloc library. (Implemented by: Lina Developer)
- **Dependency Injection (Injectable)**: Automatic dependency wiring with Injectable and GetIt. (Implemented by: Sam Developer)
- **Result / Failure Error Handling**: Unified error handling using Result and Failure types for predictable error propagation. (Implemented by: Maya Developer)
- **Task Management**: A small task CRUD demo that illustrates feature flow through layers. (Implemented by: Omar Developer)

**Architecture Overview**

This project follows Clean Architecture principles and is organized into the following high-level parts:

- **Core**: Shared utilities and app-wide services (DI setup, networking, helpers, theming).
- **Features**: Independent feature modules (e.g., `posts`, `authentication`, `filtering`, `admin`) each containing Presentation, Domain, and Data layers.
- **Presentation**: UI, Cubits (state managers), widgets, and routing.
- **Domain**: Entities, use-cases, and repository interfaces (business logic contracts).
- **Data**: Implementations of repositories, data sources, models, and network clients.

This separation makes it easier to test business logic independently and replace implementations (for example, switching network clients or local storage) without affecting the rest of the app.

**Tech Stack**

- Flutter & Dart
- Cubit (bloc package) for state management
- Injectable & GetIt for dependency injection
- Dio for networking
- json_serializable / build_runner for model serialization
- Result / Failure pattern for error handling
- Shared Preferences for local caching

**Installation & Running**

1. Ensure Flutter is installed and configured: https://docs.flutter.dev/get-started/install
2. From the project root, get dependencies and run code generation (if needed):

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Run the app (choose a connected device or emulator):

```bash
flutter run
```

4. To run the app in release mode:

```bash
flutter run --release
```

**Folder Structure (Overview)**

Key folders (abridged):

- `lib/`
	- `main.dart` — App entry point
	- `core/` — DI, networking, helpers, theming, routing
	- `features/` — Feature modules (each with `presentation/`, `domain/`, `data/`)
	- `shared/` — Reusable widgets, models, and entities
	- `userMainDetails/` — Example Cubit and user details logic

Example detailed layout (selected):

- `lib/core/di/` — DI configuration and registration helpers
- `lib/core/network/` — `dio_client.dart`, API helpers
- `lib/features/posts/` — Post feature separated into data/domain/presentation
- `lib/shared/widgets/` — Common UI components used across features

This structure aligns with Clean Architecture by keeping feature code self-contained and separating concerns into the domain (pure business logic), data (external sources), and presentation (UI + state).

**Feature Implementers**

- `admin` — Implemented by: Abdullah-T3
- `authentication` — Implemented by: MetoIsTheKing
- `filtering` — Implemented by: Omar 
- `on_boarding` — Implemented by: Abdullah-T3
- `posts` — Implemented by: Abdullah-T3 
- `post_details ` — Implemented by: Omar
- `comments` — Implemented by: Omar 

