// import 'package:flutter/material.dart';
// import 'routes.dart';
// import 'theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'theme/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/appointment_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthNexusAi',
      theme: AppTheme.lightTheme, // Use the custom theme defined in theme.dart
      initialRoute: '/', // Define the initial route
      routes: appRoutes, // Use the routes defined in routes.dart
    );
  }
}