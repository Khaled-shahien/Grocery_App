import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/cubit/cart%20item/cart_item_cubit.dart';
import 'package:grocery_app/features/cart/data/models/cart_item_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    final imageSize = screenWidth * 0.22;
    final horizontalPadding = screenWidth * 0.04;
    final spacing = screenWidth * 0.04;
    final iconSize = screenWidth * 0.07;
    final titleFontSize = screenWidth * 0.04;
    final priceFontSize = screenWidth * 0.045;
    final quantityFontSize = screenWidth * 0.05;

    return BlocBuilder<CartItemCubit, CartItemState>(
      buildWhen: (prev, curr) {
        if (curr is CartItemUpdated) {
          if (curr.cartItemModel == cartItem) return true;
        }
        return false;
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(horizontalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.045),
                child: Image.network(
                  cartItem.productModel.imageUrl,
                  height: imageSize * 1.2,
                  width: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: imageSize * 1.2,
                      width: imageSize,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(screenWidth * 0.045),
                      ),
                      child: Icon(
                        Icons.image_not_supported,
                        size: iconSize * 1.2,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.productModel.name,
                      style: TextStyle(
                        fontSize: titleFontSize.clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      '\$${cartItem.calcTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: priceFontSize.clamp(16.0, 20.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.045),
                  color: const Color(0xffEFEFEF),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartItem.decreaseCount();
                        context.read<CartItemCubit>().updateCartItem(cartItem);
                      },
                      child: Icon(
                        Icons.remove,
                        size: iconSize.clamp(24.0, 32.0),
                        color: const Color(0xffB1B1B1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        '${cartItem.quantity}',
                        style: TextStyle(
                          fontSize: quantityFontSize.clamp(18.0, 22.0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartItem.increaseCount();
                        context.read<CartItemCubit>().updateCartItem(cartItem);
                      },
                      child: Icon(
                        Icons.add,
                        size: iconSize.clamp(24.0, 32.0),
                        color: const Color(0xffB1B1B1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}