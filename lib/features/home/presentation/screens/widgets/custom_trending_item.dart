import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';

class CustomTrendingItem extends StatelessWidget {
  final String name, price, image;
  const CustomTrendingItem({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final borderRadius = screenWidth * 0.04;
    final padding = screenWidth * 0.02;
    final nameFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final priceFontSize = (screenWidth * 0.035).clamp(12.0, 16.0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.poppinsMedium.copyWith(
                color: Colors.white,
                fontSize: nameFontSize,
              ),
            ),
            Text(
              price,
              style: AppTextStyles.poppinsRegular.copyWith(
                color: Colors.white,
                fontSize: priceFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}