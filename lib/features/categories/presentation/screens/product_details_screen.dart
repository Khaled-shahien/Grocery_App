import 'package:flutter/material.dart';
import 'package:grocery_app/features/products_home/presentation/screens/widgets/products_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //THE BODY IS IN A SEPARATED FILE______________
    return ProductsHomeScreenBody();
  }
}