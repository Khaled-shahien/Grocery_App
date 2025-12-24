import 'package:flutter/material.dart';
import 'package:grocery_app/features/products_home/presentation/screens/widgets/products_screen_body.dart';

class ProductsHomeScreen extends StatelessWidget {
  const ProductsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductsHomeScreenBody(),
    );
  }
}
