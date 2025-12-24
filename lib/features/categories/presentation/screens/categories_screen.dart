import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/categories/presentation/screens/widgets/categories_screen_body.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = (screenWidth * 0.05).clamp(18.0, 22.0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "CATEGORIES",
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: titleFontSize),
        ),
        centerTitle: true,
      ),
      body: const CategoriesScreenBody(),
    );
  }
}