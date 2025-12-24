import 'package:flutter/material.dart';
import 'package:grocery_app/features/home/data/models/trending_item_model.dart';
import 'package:grocery_app/features/home/presentation/screens/widgets/custom_trending_item.dart';

class CustomTrendingGrid extends StatelessWidget {
  const CustomTrendingGrid({super.key});

  final List<TrendingItemModel> items = const [
    TrendingItemModel(
      image: 'assets/images/tomato.png',
      name: 'Tomatoes',
      price: '₹60/kg',
    ),
    TrendingItemModel(
      image: 'assets/images/potatoes.png',
      name: 'Potatoes',
      price: '₹40/kg',
    ),
    TrendingItemModel(
      image: 'assets/images/Brocoli.png',
      name: 'Broccoli',
      price: '₹80/kg',
    ),
    TrendingItemModel(
      image: 'assets/images/grapes.png',
      name: 'Grapes',
      price: '₹90/kg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive grid spacing
    final crossAxisSpacing = screenWidth * 0.03;
    final mainAxisSpacing = screenWidth * 0.03;

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 1.1 / 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return CustomTrendingItem(
          name: item.name,
          price: item.price,
          image: item.image,
        );
      },
    );
  }
}