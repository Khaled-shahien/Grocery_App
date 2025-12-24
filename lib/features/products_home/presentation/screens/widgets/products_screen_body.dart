import 'package:flutter/material.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';
import 'package:grocery_app/features/products_home/presentation/screens/widgets/product_card.dart';

class ProductsHomeScreenBody extends StatelessWidget {
  const ProductsHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive values
    final horizontalPadding = screenWidth * 0.04;
    final crossAxisSpacing = screenWidth * 0.04;
    final mainAxisSpacing = screenWidth * 0.04;

    // Determine number of columns based on screen width
    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth < 600) {
      // Mobile: 2 columns
      crossAxisCount = 2;
      childAspectRatio = 0.72;
    } else if (screenWidth < 900) {
      // Tablet: 3 columns
      crossAxisCount = 3;
      childAspectRatio = 0.75;
    } else {
      // Large screens: 4 columns
      crossAxisCount = 4;
      childAspectRatio = 0.78;
    }

    final List<ProductModel> products = [
      ProductModel(
        id: '1',
        name: 'Vibrant Fruit Platter',
        price: 20.78,
        oldPrice: 30.00,
        rating: 4.9,
        imageUrl:
        'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=400',
      ),
      ProductModel(
        id: '2',
        name: "Eden's Strawberry",
        price: 26.78,
        oldPrice: 30.00,
        rating: 4.9,
        imageUrl:
        'https://images.unsplash.com/photo-1498557850523-fd3d118b962e?w=400',
      ),
      ProductModel(
        id: '3',
        name: 'Fresh Organic Vegetables',
        price: 15.50,
        oldPrice: 25.00,
        rating: 4.7,
        imageUrl:
        'https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=400',
      ),
      ProductModel(
        id: '4',
        name: 'Premium Honey',
        price: 18.99,
        oldPrice: 22.00,
        rating: 4.8,
        imageUrl:
        'https://images.unsplash.com/photo-1587049352846-4a222e784210?w=400',
      ),
      ProductModel(
        id: '5',
        name: 'Tropical Fruit Mix',
        price: 22.50,
        oldPrice: 28.00,
        rating: 4.6,
        imageUrl:
        'https://images.unsplash.com/photo-1617897903655-7fbe14f1e322?w=400',
      ),
      ProductModel(
        id: '6',
        name: 'Berry Collection',
        price: 24.99,
        oldPrice: 32.00,
        rating: 4.9,
        imageUrl:
        'https://images.unsplash.com/photo-1498557850523-fd3d118b962e?w=400',
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(horizontalPadding),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ProductCard(product: products[index]);
              },
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }
}