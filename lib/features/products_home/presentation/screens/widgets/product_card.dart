import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/core/widgets/custom_favorite_button.dart';
import 'package:grocery_app/features/cart/cubit/cart/cart_cubit.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';
import 'package:grocery_app/features/products_home/presentation/screens/widgets/image_with_shimmer.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive values based on screen width
    final borderRadius = screenWidth * 0.04;
    final cardPadding = screenWidth * 0.025;
    final favoriteButtonSize = (screenWidth * 0.08).clamp(30.0, 40.0);
    final favoriteIconPadding = screenWidth * 0.015;

    // Font sizes
    final ratingFontSize = (screenWidth * 0.032).clamp(11.0, 15.0);
    final starIconSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final nameFontSize = (screenWidth * 0.037).clamp(13.0, 17.0);
    final priceFontSize = (screenWidth * 0.045).clamp(16.0, 20.0);
    final oldPriceFontSize = (screenWidth * 0.03).clamp(10.0, 14.0);

    // Button sizes
    final addButtonSize = (screenWidth * 0.075).clamp(28.0, 35.0);
    final addIconSize = (screenWidth * 0.05).clamp(18.0, 24.0);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                  child: ImageWithShimmer(imageUrl: widget.product.imageUrl),
                ),
                Positioned(
                  top: favoriteIconPadding,
                  right: favoriteIconPadding,
                  child: Container(
                    width: favoriteButtonSize,
                    height: favoriteButtonSize,
                    padding: EdgeInsets.all(favoriteIconPadding * 0.8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: CustomFavoriteButton(product: widget.product),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.primaryOrange,
                        size: starIconSize,
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        widget.product.rating.toString(),
                        style: AppTextStyles.poppinsSemiBold.copyWith(
                          fontSize: ratingFontSize,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      widget.product.name,
                      style: AppTextStyles.poppinsSemiBold.copyWith(
                        fontSize: nameFontSize,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: AppTextStyles.poppinsBold.copyWith(
                                fontSize: priceFontSize,
                                color: AppColors.primaryOrange,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: screenWidth * 0.005),
                            Text(
                              '\$${widget.product.oldPrice.toStringAsFixed(2)}',
                              style: AppTextStyles.poppinsRegular.copyWith(
                                fontSize: oldPriceFontSize,
                                color: Colors.grey[400],
                                decoration: TextDecoration.lineThrough,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().addProductToCart(
                            widget.product,
                          );
                        },
                        child: Container(
                          width: addButtonSize,
                          height: addButtonSize,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: addIconSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}