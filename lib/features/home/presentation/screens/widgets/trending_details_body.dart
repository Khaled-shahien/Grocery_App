import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';
import 'package:grocery_app/features/products_home/presentation/screens/widgets/product_card.dart';

class TrendingDetailsBody extends StatelessWidget {
  const TrendingDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final horizontalPadding = screenWidth * 0.04;
    final crossAxisSpacing = screenWidth * 0.04;
    final mainAxisSpacing = screenWidth * 0.04;
    final titleFontSize = (screenWidth * 0.05).clamp(18.0, 22.0);
    final iconSize = (screenWidth * 0.06).clamp(22.0, 26.0);

    // Determine grid columns based on screen width
    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth < 600) {
      crossAxisCount = 2;
      childAspectRatio = 0.75;
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
      childAspectRatio = 0.78;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 0.8;
    }

    // Sample trending products data
    final List<ProductModel> trendingProducts = [
      ProductModel(
        id: '1',
        name: 'Organic Fresh Fruits',
        price: 25.99,
        oldPrice: 35.99,
        rating: 4.8,
        imageUrl:
        'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=400',
      ),
      ProductModel(
        id: '2',
        name: 'Premium Vegetables',
        price: 18.50,
        oldPrice: 25.00,
        rating: 4.6,
        imageUrl:
        'https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=400',
      ),
      ProductModel(
        id: '3',
        name: 'Natural Honey',
        price: 22.99,
        oldPrice: 30.00,
        rating: 4.9,
        imageUrl:
        'https://images.unsplash.com/photo-1587049352846-4a222e784210?w=400',
      ),
      ProductModel(
        id: '4',
        name: 'Fresh Berries',
        price: 19.99,
        oldPrice: 28.50,
        rating: 4.7,
        imageUrl:
        'https://images.unsplash.com/photo-1498557850523-fd3d118b962e?w=400',
      ),
      ProductModel(
        id: '5',
        name: 'Dairy Products',
        price: 15.75,
        oldPrice: 22.25,
        rating: 4.5,
        imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400',
      ),
      ProductModel(
        id: '6',
        name: 'Whole Grain Bread',
        price: 8.99,
        oldPrice: 12.50,
        rating: 4.4,
        imageUrl:
        'https://images.unsplash.com/photo-1588110190687-1c1d6d65e1a6?w=400',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Trending Deals',
          style: AppTextStyles.poppinsSemiBold.copyWith(
            fontSize: titleFontSize,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: trendingProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(product: trendingProducts[index]);
          },
        ),
      ),
    );
  }
}