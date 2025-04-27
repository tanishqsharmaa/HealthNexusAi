import 'package:flutter/material.dart';
import 'theme/app_theme.dart'; // We'll create this next
import 'screens/login_screen.dart'; // Start with Login screen

void main() {
  runApp(const HealthNexusApp());
}

class HealthNexusApp extends StatelessWidget {
  const HealthNexusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthNexus AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Defined inside theme/app_theme.dart
      home: const LoginScreen(),  // First screen will be LoginScreen
    );
  }
}
