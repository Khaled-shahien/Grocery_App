import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/constants/assets.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';

class CongratulationsScreen extends StatefulWidget {
  final String userName;

  const CongratulationsScreen({
    super.key,
    required this.userName,
  });

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final horizontalPadding = screenWidth * 0.06;
    final cardPadding = screenWidth * 0.08;
    final borderRadius = screenWidth * 0.06;
    final imageHeight = (screenHeight * 0.2).clamp(120.0, 180.0);
    final verticalSpacing = screenHeight * 0.02;

    // Font sizes
    final titleFontSize = (screenWidth * 0.07).clamp(24.0, 32.0);
    final nameFontSize = (screenWidth * 0.055).clamp(18.0, 24.0);
    final subtitleFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.imagesHealthyFoodBowl2,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: screenHeight * 0.5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Container(
                padding: EdgeInsets.all(cardPadding),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Congratulations!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.poppinsBold.copyWith(
                        fontSize: titleFontSize,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    Text(
                      widget.userName,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.jostBold.copyWith(
                        fontSize: nameFontSize,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: verticalSpacing * 2),
                    Image.asset(
                      Assets.imagesPartyBalloons,
                      height: imageHeight,
                    ),
                    SizedBox(height: verticalSpacing),
                    Text(
                      'Welcome to Grocery App!',
                      style: AppTextStyles.poppinsMedium.copyWith(
                        color: AppColors.primaryOrange,
                        fontSize: subtitleFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}