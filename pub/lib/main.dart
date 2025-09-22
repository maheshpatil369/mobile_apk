// lib/main.dart
import 'package:flutter/material.dart';
import 'package:pashudhan_ai/screens/authentication/login_page.dart';
import 'package:pashudhan_ai/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pashudhan-AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textColor),
          bodyMedium: TextStyle(color: AppColors.textColor),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textColor),
          titleTextStyle: TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

