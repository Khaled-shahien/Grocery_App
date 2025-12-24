import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/core/constants/assets.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/theme/app_colors.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/services/shared_preferences_singleton.dart' show AppPrefs;

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    super.initState();
    bool onBoardingViewSeen = AppPrefs.getBool(kOnBoardingViewSeen);
    Future.delayed(
      Duration(seconds: 3),
          () {
        if (!mounted) return;
        if(onBoardingViewSeen){
          bool isLoggIn = FirebaseAuth.instance.currentUser != null;
          if(isLoggIn){
            context.go(AppRoutes.layout);
          }else{
            context.go(AppRoutes.login);
          }
        }else{
          context.go(AppRoutes.onboarding);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Calculate responsive image size (30% of screen width, max 300)
    final double imageSize = (screenWidth * 0.3).clamp(100.0, 300.0);

    return Scaffold(
      backgroundColor: AppColors.lightYellow,
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: Image.asset(
              Assets.imagesLemonIcon,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}