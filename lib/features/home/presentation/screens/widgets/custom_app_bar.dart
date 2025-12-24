import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final horizontalPadding = screenWidth * 0.055;
    final topPadding = screenHeight * 0.012;
    final fontSize = (screenWidth * 0.037).clamp(13.0, 17.0);

    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding, top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GOOD MORNING!',
            style: AppTextStyles.poppinsRegular.copyWith(fontSize: fontSize),
          ),
          Text(
            name,
            style: AppTextStyles.poppinsItalic.copyWith(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}