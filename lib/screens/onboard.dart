import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/screens/main_screen.dart';
import 'package:todo_list/utils/onboarding_preferences.dart';
import 'package:todo_list/widgets/page_transition.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "We build ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                    TextSpan(
                      text: "TODOAPP",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Poppins",
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red[400],
                        decorationThickness: 4,
                      ),
                    ),
                    const TextSpan(
                      text: " to help ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Manage your activity everyday",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen <= 360.0 ? 18 : 22,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              Image.asset(
                "assets/images/hero.png",
                width: 346,
                height: 346,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransitionWidget.slideFromRight(
                        const MainScreen(),
                      ),
                    );
                    OnboardingPreferences.markOnboardingComplete();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
