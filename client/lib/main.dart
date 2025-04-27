import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Dashboard',
      theme: AppTheme.lightTheme, // Use the custom theme defined in theme.dart
      initialRoute: '/', // Define the initial route
      routes: appRoutes, // Use the routes defined in routes.dart
    );
  }
}