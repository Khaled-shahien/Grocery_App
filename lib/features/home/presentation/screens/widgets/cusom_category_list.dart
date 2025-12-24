import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/core/theme/app_colors.dart';

class CusomCategoryList extends StatelessWidget {
  const CusomCategoryList({super.key});

  final List<String> categoryIcons = const [
    'assets/images/fruits_icon.svg',
    'assets/images/mushrooms_icon.svg',
    'assets/images/milk_carton_icon.svg',
    'assets/images/fruits_icon.svg',
    'assets/images/mushrooms_icon.svg',
    'assets/images/milk_carton_icon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final itemWidth = (screenWidth * 0.23).clamp(80.0, 110.0);
    final itemSpacing = screenWidth * 0.03;
    final horizontalPadding = screenWidth * 0.04;
    final borderRadius = screenWidth * 0.025;
    final iconSize = (screenWidth * 0.1).clamp(35.0, 45.0);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      itemCount: categoryIcons.length,
      itemBuilder: (context, index) {
        return Container(
          width: itemWidth,
          margin: EdgeInsets.only(right: itemSpacing),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(.2),
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              categoryIcons[index],
              width: iconSize,
              height: iconSize,
            ),
          ),
        );
      },
    );
  }
}