// File: lib/main.dart
// Main entry point of the Flutter app

// Import Flutter material design package
import 'package:flutter/material.dart'; // Provides Material UI widgets
// Import Firebase core for initialization
import 'package:firebase_core/firebase_core.dart'; // Provides Firebase initialization
// Import the login screen widget
import 'login_screen.dart'; // Custom login screen widget
import 'firebase_options.dart'; // Firebase configuration options (auto-generated)

// The main function is the entry point of the Flutter app
void main() async {
  // Ensures that widget binding is initialized before using platform channels
  WidgetsFlutterBinding.ensureInitialized();
  // Initializes Firebase with platform-specific options (from firebase_options.dart)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Uses correct config for Android/iOS/Web
  );
  // Runs the root widget of the app
  runApp(MyApp());
}

// The root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Add key parameter

  @override
  Widget build(BuildContext context) {
    // Returns a MaterialApp widget (top-level app container)
    return MaterialApp(
      title: 'Firebase Auth', // App title
      theme: ThemeData(primarySwatch: Colors.blue), // App theme with blue color
      home: LoginScreen(), // ✅ This must be correct: sets the first screen to LoginScreen
    );
  }
}
