import 'package:flutter/material.dart';
import 'package:todo_list/screens/main_screen.dart';
import 'package:todo_list/screens/onboard.dart';
import 'package:todo_list/utils/onboarding_preferences.dart';

const Color kPrimaryColor = Color(0xFF001328);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isOnboardComplete = await OnboardingPreferences.isOnboardingComplete();
  runApp(MyApp(
    isOnboardingComplete: isOnboardComplete,
  ));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingComplete;
  const MyApp({super.key, required this.isOnboardingComplete});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
      ),
      home: isOnboardingComplete ? const MainScreen() : const OnboardScreen(),
    );
  }
}
