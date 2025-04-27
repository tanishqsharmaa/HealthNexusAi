import 'package:flutter/material.dart';

// Colors used throughout the app
class AppColors {
  static const Color primaryColor = Color(0xFF4CAF50);   // Green color for primary buttons
  static const Color secondaryColor = Color(0xFF2196F3); // Blue color for secondary actions
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light grey background
  static const Color accentColor = Color(0xFFFF5722);    // Orange accent color
  static const Color errorColor = Color(0xFFF44336);     // Red color for errors
  static const Color textColor = Color(0xFF212121);      // Dark grey for text
  static const Color disabledColor = Color(0xFFBDBDBD);  // Grey for disabled elements
  static const Color inputBorderColor = Color(0xFFBDBDBD); // Border color for text fields
}

// App-wide text styles
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 16,
    color: AppColors.secondaryColor,
    decoration: TextDecoration.underline,
  );
}

// Default padding and margin values
class AppPadding {
  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets formFieldPadding = EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0);
}

// API Base URL (to be updated with actual backend URL)
class ApiConstants {
  static const String baseUrl = "https://your-api-endpoint.com/api";
  static const String loginEndpoint = "/auth/login";
  static const String signupEndpoint = "/auth/signup";
  static const String getReportsEndpoint = "/reports";
  static const String createChatEndpoint = "/chat/create";
  // Add more API endpoints as needed
}

// App-wide Constants
class AppConstants {
  static const String appName = "HealthNexus AI";
  static const String version = "1.0.0";
  static const String splashImage = "assets/images/splash_logo.png"; // Example image for splash screen
  static const String logoImage = "assets/images/logo.png"; // Example image for the app's logo
}
