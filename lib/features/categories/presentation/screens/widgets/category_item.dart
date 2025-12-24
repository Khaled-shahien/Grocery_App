import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String textItem;
  final int itemCount;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.image,
    required this.textItem,
    required this.itemCount,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final borderRadius = screenWidth * 0.05;
    final iconSize = (screenWidth * 0.125).clamp(45.0, 60.0);
    final titleFontSize = (screenWidth * 0.03).clamp(11.0, 14.0);
    final countFontSize = (screenWidth * 0.022).clamp(8.0, 11.0);
    final spacing = screenWidth * 0.02;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffFFDB20) : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: iconSize,
            width: iconSize,
            colorFilter: isSelected
                ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
                : null,
          ),
          SizedBox(height: spacing),
          Text(
            textItem,
            style: AppTextStyles.poppinsBold.copyWith(
              fontSize: titleFontSize,
              color: isSelected
                  ? const Color(0xff000000)
                  : const Color(0xffE67F1E),
            ),
          ),
          SizedBox(height: spacing * 0.3),
          Text(
            "($itemCount items)",
            style: AppTextStyles.poppinsBold.copyWith(
              fontSize: countFontSize,
              color: isSelected
                  ? const Color(0xff000000)
                  : const Color(0xffE67F1E),
            ),
          ),
        ],
      ),
    );
  }
}