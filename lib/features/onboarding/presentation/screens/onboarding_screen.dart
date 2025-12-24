import 'package:flutter/material.dart';
import 'package:grocery_app/features/onboarding/presentation/screens/widgets/onboarding_screen_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: OnboardingScreenBody(),
    );
  }
}


