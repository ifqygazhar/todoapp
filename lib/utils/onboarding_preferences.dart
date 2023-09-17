import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreferences {
  static Future<bool> isOnboardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("OnboardingComplete") ?? false;
  }

  static Future<void> markOnboardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("OnboardingComplete", true);
  }
}
