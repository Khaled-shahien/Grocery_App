import 'package:flutter/material.dart';
import 'package:grocery_app/features/onboarding/models/onboarding_page_model.dart';

/// Reusable page content widget
class OnboardingPageContent extends StatelessWidget {
  final OnboardingPageModel pageData;
  final bool isMiddlePage;

  const OnboardingPageContent({
    super.key,
    required this.pageData,
    this.isMiddlePage = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final imageHeight = (screenHeight * 0.35).clamp(200.0, 400.0);
    final horizontalPadding = screenWidth * 0.06;
    final verticalSpacing = screenHeight * 0.06;
    final textSpacing = pageData.spacing * (screenHeight / 800);

    // Font sizes
    final titleFontSize = (screenWidth * 0.06).clamp(20.0, 28.0);
    final descriptionFontSize = (screenWidth * 0.05).clamp(16.0, 22.0);

    // For middle page (yellow), use full width image
    if (isMiddlePage) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Full-width image without padding
          SizedBox(
            width: double.infinity,
            height: imageHeight,
            child: Image.asset(
              pageData.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                Text(
                  pageData.title,
                  style: pageData.titleStyle.copyWith(fontSize: titleFontSize),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: textSpacing),
                Text(
                  pageData.description,
                  style: pageData.descriptionStyle.copyWith(fontSize: descriptionFontSize),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Standard layout for other pages
    return Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            pageData.imagePath,
            height: imageHeight,
            fit: BoxFit.contain,
          ),
          SizedBox(height: verticalSpacing),
          Text(
            pageData.title,
            style: pageData.titleStyle.copyWith(fontSize: titleFontSize),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: textSpacing),
          Text(
            pageData.description,
            style: pageData.descriptionStyle.copyWith(fontSize: descriptionFontSize),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}