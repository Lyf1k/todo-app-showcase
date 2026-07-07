import 'package:flutter/material.dart';
import 'package:partfolio_app/core/theme/app_theme.dart';
import 'package:partfolio_app/feautures/auth/presentation/login_screen.dart';
import 'package:partfolio_app/feautures/tasks/presentation/tasks_screen.dart';
import 'package:partfolio_app/feautures/tasks/presentation/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeDataLight,
      home: HomeScreen(),
    );
  }
}
