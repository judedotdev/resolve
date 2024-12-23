import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolve/providers/user_provider.dart';
import 'package:resolve/screens/auth/register_screen.dart';
import 'package:resolve/screens/home_screen.dart';
import 'package:resolve/screens/onboarding_screen.dart';
import 'package:resolve/screens/splash_screen.dart';
import 'package:resolve/screens/auth/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'resolve',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
        ),
      ),
      // Define routes for navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
