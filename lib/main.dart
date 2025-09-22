import 'package:flutter/material.dart';
import 'screens/authentication/login_page.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const PashudhanAIApp());
}

class PashudhanAIApp extends StatelessWidget {
  const PashudhanAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pashudhan-AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        fontFamily: 'Roboto', // Example font, you can change this
      ),
      home: const LoginPage(), // Start the app with the LoginPage
    );
  }
}
