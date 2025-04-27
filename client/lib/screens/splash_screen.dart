import 'package:flutter/material.dart';
import 'package:your_project/screens/welcome_screen.dart'; // Navigate to the Welcome screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomeScreen();
  }

  Future<void> _navigateToWelcomeScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Show splash for 3 seconds
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App logo or any other image
            Image.asset(
              'assets/images/logo.png', // Ensure you have a logo image in your assets
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white, // White spinner for contrast
            ),
          ],
        ),
      ),
    );
  }
}
