# Flutter Project README

# Klontong Mobile App
Klontong is a Flutter-based mobile application following Clean Architecture principles. It utilizes BLoC for state management and integrates Firebase services.

## 🚀 Dependencies
The project uses the following dependencies:

| Package                   | Description |
|---------------------------|-------------|
| `flutter_bloc: ^8.1.3`     | State management using BLoC pattern |
| `dio: ^5.3.2`              | HTTP client for network requests |
| `get_it: ^7.2.0`           | Dependency injection |
| `dartz: ^0.10.1`           | Functional programming utilities |
| `rxdart: ^0.27.7`          | Reactive programming with streams |
| `equatable: ^2.0.5`        | Simplifies object comparisons |
| `flutter_screenutil: ^5.5.3+2` | Responsive UI handling |
| `intl: ^0.19.0`            | Internationalization and formatting |
| `firebase_core: ^2.15.0`   | Firebase core services |
| `firebase_crashlytics: ^3.3.1` | Crash reporting |
| `firebase_remote_config: 4.3.17` | Remote configuration management |
| `firebase_analytics: ^10.4.4` | Firebase analytics |


## Project Setup
### 1. Install Dependencies
Run the following command to install required packages:
```sh
flutter pub get
```

### 2. Firebase Setup
Ensure Firebase is properly configured for the project:
```sh
flutterfire configure
```
This generates `firebase_options.dart` automatically.

### 3. Running the Project
Execute the following command:
```sh
flutter run
```

## Application Initialization
The `main.dart` file contains the startup sequence:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfig.init();
  UrlConstant urlConstant = await UrlConstant.create();
  sl.registerSingleton<UrlConstant>(urlConstant);
  await setupInjection();
  runApp(const App());
}
```

### Initialization Steps:
1. **Ensure Flutter Widgets are Initialized**
    - `WidgetsFlutterBinding.ensureInitialized();`
2. **Initialize Firebase**
    - `Firebase.initializeApp()` loads Firebase services.
3. **Initialize RemoteConfig**
    - `RemoteConfig.init()` fetches and applies Firebase Remote Config settings.
4. **Setup URL Constants**
    - `UrlConstant.create()` asynchronously fetches API tokens.
    - The instance is registered in `get_it` for DI (`sl.registerSingleton<UrlConstant>()`).
5. **Setup Dependency Injection**
    - `setupInjection()` initializes other dependencies.
6. **Run the Application**
    - `runApp(const App());`


## 📂 Project Structure
The project follows a modular structure based on Clean Architecture:
```
lib/
 ├── core/                     # Contains shared utilities and error handling
 │   ├── error/                # Failure and exception handling
 │   ├── network/              # Network service with Dio
 │   ├── usecase/              # Base use case classes
 │   ├── di.dart               # Dependency injection (GetIt)
 │   ├── constants.dart        # Application-wide constants
 │
 ├── feature/                  # Each feature has its own module
 │   ├── product/              # Product feature
 │   │   ├── data/             # Data layer (API, repository)
 │   │   ├── domain/           # Business logic layer
 │   │   ├── presentation/     # UI layer (Bloc, Widgets, Screens)
 │   │   ├── product_bloc.dart # BLoC implementation
 │
 ├── utils/                    # Utility functions (formatters, extensions)
 ├── main.dart                 # Application entry point
```


## State Management with BLoC
This project uses `flutter_bloc` for state management. Example event handling:

```dart
on<CreateProduct>((event, emit) async {
  emit(const CreatingProduct());
  var response = await productRepository.createProduct(event.product);
  response.fold(
    (failure) => onFailure(failure, emit),
    (response) => emit(const CreatedProduct()),
  );
});
```

## API Requests with Dio
The app uses `dio` for making HTTP requests. Example usage:

```dart
Response<dynamic> response = await dio.post(
  UrlConstant.product,
  data: product,
  options: Options(headers: headers),
);
```

## Error Handling
All failures are handled using `dartz` Either type for better functional error management.

## Conclusion
This project is structured for scalability and maintainability, following Clean Architecture and BLoC patterns. 🚀

# Klontong Mobile App

Klontong is a Flutter-based mobile application following Clean Architecture principles. It utilizes BLoC for state management and integrates Firebase services.
