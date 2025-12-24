import 'package:flutter/material.dart';

class CustomRecommendedList extends StatelessWidget {
  const CustomRecommendedList({super.key});

  final List<String> images = const [
    'assets/images/bowl.png',
    'assets/images/cleaning_products.png',
    'assets/images/bowl.png',
    'assets/images/cleaning_products.png',
    'assets/images/cleaning_products.png',
    'assets/images/bowl.png',
    'assets/images/cleaning_products.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final itemWidth = (screenWidth * 0.4).clamp(140.0, 180.0);
    final itemSpacing = screenWidth * 0.02;
    final borderRadius = screenWidth * 0.05;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          width: itemWidth,
          margin: EdgeInsets.symmetric(horizontal: itemSpacing),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}