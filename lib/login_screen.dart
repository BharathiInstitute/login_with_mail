import 'package:flutter/material.dart'; // Import Flutter Material UI
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'register_screen.dart'; // Import the RegisterScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller for the email input field
  final TextEditingController emailCtrl = TextEditingController();
  // Controller for the password input field
  final TextEditingController passCtrl = TextEditingController();

  bool isLoading = false; // Loading state for the login process

  // Function to handle login logic
  void login() async {
    setState(() => isLoading = true); // Set loading to true

    try {
      // Attempt to sign in with email and password using Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(), // Get and trim email input
        password: passCtrl.text.trim(), // Get and trim password input
      );
      // Show success message if login is successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Login successful')),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message if login fails
      String message = e.message ?? 'Login failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ $message')),
      );
    } finally {
      setState(() => isLoading = false); // Set loading to false
    }
  }

  // Function to handle password reset
  void resetPassword() async {
    if (emailCtrl.text.trim().isEmpty) {
      // Check if the email field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠️ Enter your email first')),
      );
      return;
    }

    try {
      // Send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailCtrl.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📧 Reset link sent to your email')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to send reset email: $e')),
      );
    }
  }

  // Function to navigate to the registration screen
  void goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the login screen
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Login')), // App bar with title
      body: Padding(
        padding: const EdgeInsets.all(20), // Add padding around the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
          children: [
            // Email input field
            TextField(
              controller: emailCtrl, // Connects to emailCtrl
              keyboardType: TextInputType.emailAddress, // Keyboard type for email
              decoration: InputDecoration(labelText: 'Email'), // Shows 'Email' label
            ),
            // Password input field
            TextField(
              controller: passCtrl, // Connects to passCtrl
              obscureText: true, // Hides the password text
              decoration: InputDecoration(labelText: 'Password'), // Shows 'Password' label
            ),
            SizedBox(height: 20), // Adds vertical space
            // Show loading indicator or login button
            isLoading
                ? CircularProgressIndicator() // Loading indicator
                : ElevatedButton(
                    onPressed: login, // Calls login() when pressed
                    child: Text('Login'), // Button text
                  ),
            // Forgot Password button
            TextButton(
              onPressed: resetPassword, // Calls resetPassword() when pressed
              child: Text('Forgot Password?'), // Button text
            ),
            // Register button
            TextButton(
              onPressed: goToRegister, // Calls goToRegister() when pressed
              child: Text("Don't have an account? Register"), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
