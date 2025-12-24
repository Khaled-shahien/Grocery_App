import 'package:flutter/material.dart';

/// Model class for onboarding page data
class OnboardingPageModel {
  final String imagePath;
  final String title;
  final String description;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final double spacing;
  final Color backgroundColor;

  const OnboardingPageModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.titleStyle,
    required this.descriptionStyle,
    required this.spacing,
    required this.backgroundColor,
  });
}
