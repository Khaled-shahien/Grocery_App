import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/core/services/favorites_service.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';

class FavoritesScreenBody extends StatefulWidget {
  const FavoritesScreenBody({super.key});

  @override
  State<FavoritesScreenBody> createState() => _FavoritesScreenBodyState();
}

class _FavoritesScreenBodyState extends State<FavoritesScreenBody> {
  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return _buildNotLoggedInView();
    }

    return StreamBuilder<List<ProductModel>>(
      stream: _favoritesService.getFavoriteProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryOrange),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorView();
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyFavoritesView();
        }

        final List<ProductModel> favoriteProducts = snapshot.data!;
        return _buildFavoritesListView(favoriteProducts);
      },
    );
  }

  Widget _buildNotLoggedInView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = (screenWidth * 0.16).clamp(56.0, 72.0);
    final titleFontSize = (screenWidth * 0.045).clamp(16.0, 20.0);
    final buttonFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final buttonPadding = screenWidth * 0.06;
    final spacing = screenWidth * 0.04;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: iconSize,
              color: AppColors.primaryOrange,
            ),
            SizedBox(height: spacing),
            Text(
              'Please log in to view your favorites',
              style: AppTextStyles.poppinsMedium.copyWith(fontSize: titleFontSize),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacing),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                padding: EdgeInsets.symmetric(
                  horizontal: buttonPadding,
                  vertical: buttonPadding * 0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Log In',
                style: AppTextStyles.poppinsMedium.copyWith(
                  color: AppColors.white,
                  fontSize: buttonFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = (screenWidth * 0.12).clamp(48.0, 56.0);
    final titleFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final buttonFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final spacing = screenWidth * 0.04;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: iconSize),
            SizedBox(height: spacing),
            Text(
              'Failed to load favorites',
              style: AppTextStyles.poppinsMedium.copyWith(fontSize: titleFontSize),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacing),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenWidth * 0.03,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.poppinsMedium.copyWith(
                  color: AppColors.white,
                  fontSize: buttonFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFavoritesView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = (screenWidth * 0.16).clamp(56.0, 72.0);
    final titleFontSize = (screenWidth * 0.05).clamp(18.0, 22.0);
    final subtitleFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final spacing = screenWidth * 0.04;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: iconSize,
              color: AppColors.primaryOrange,
            ),
            SizedBox(height: spacing),
            Text(
              'No favorites yet',
              style: AppTextStyles.poppinsBold.copyWith(fontSize: titleFontSize),
            ),
            SizedBox(height: spacing * 0.5),
            Text(
              'Start adding products to your favorites',
              style: AppTextStyles.poppinsRegular.copyWith(
                fontSize: subtitleFontSize,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesListView(List<ProductModel> products) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04;
    final titleFontSize = (screenWidth * 0.06).clamp(20.0, 26.0);
    final spacing = screenWidth * 0.04;
    final crossAxisSpacing = screenWidth * 0.04;
    final mainAxisSpacing = screenWidth * 0.04;

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

    return Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Favorites',
            style: AppTextStyles.poppinsBold.copyWith(
              fontSize: titleFontSize,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: spacing),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    final screenWidth = MediaQuery.of(context).size.width;
    final borderRadius = screenWidth * 0.03;
    final cardPadding = screenWidth * 0.03;
    final nameFontSize = (screenWidth * 0.035).clamp(12.0, 16.0);
    final priceFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final iconSize = (screenWidth * 0.06).clamp(20.0, 26.0);
    final errorIconSize = (screenWidth * 0.1).clamp(35.0, 45.0);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadius),
              ),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.lightGray,
                    child: Icon(
                      Icons.image_not_supported,
                      size: errorIconSize,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.poppinsMedium.copyWith(
                    fontSize: nameFontSize,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: cardPadding * 0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.poppinsBold.copyWith(
                        fontSize: priceFontSize,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _removeFromFavorites(product.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: AppColors.primaryOrange,
                        size: iconSize,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _removeFromFavorites(String productId) {
    try {
      _favoritesService.removeProductFromFavorites(productId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove from favorites: $e'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }
}