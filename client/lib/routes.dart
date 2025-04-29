import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/dashboard/home_screen.dart';
import 'screens/dashboard/reports_screen.dart';
import 'screens/dashboard/appointments_screen.dart';
import 'screens/chat/chat_list_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/edit_profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(), // Default route
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/reports': (context) => const ReportsScreen(),
  '/appointments': (context) => const AppointmentsScreen(),
  '/chatList': (context) => const ChatListScreen(),
  '/chat': (context) {
    final chatName = ModalRoute.of(context)!.settings.arguments as String;
    return ChatScreen(chatName: chatName);
  },
  '/profile': (context) => const ProfileScreen(),
  '/editProfile': (context) => const EditProfileScreen(),
};