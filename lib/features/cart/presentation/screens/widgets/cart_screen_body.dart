import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/cubit/cart%20item/cart_item_cubit.dart';
import 'package:grocery_app/features/cart/cubit/cart/cart_cubit.dart';
import 'list_ cart_items.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    final horizontalPadding = screenWidth * 0.04;
    final appBarFontSize = screenWidth * 0.045;
    // final messageFontSize = screenWidth * 0.04;
    final priceFontSize = screenWidth * 0.05;
    final buttonFontSize = screenWidth * 0.048;
    final bottomBarHeight = screenHeight * 0.12;

    CartCubit cartCubit = context.watch<CartCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ITEM DETAILS',
              style: TextStyle(
                fontSize: appBarFontSize.clamp(16.0, 20.0),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'HELP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: CartItemsList(cartItems: cartCubit.cartModel.cartItems),
      bottomNavigationBar: Container(
        height: bottomBarHeight.clamp(100.0, 140.0),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BlocBuilder<CartItemCubit, CartItemState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add items worth ₹130 more for FREE delivery ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.025),
                          child: Text(
                            '₹${cartCubit.cartModel.calcTotalPrice().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: priceFontSize.clamp(18.0, 24.0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text('price details', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: Text(
                        'PLACE ORDER',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: buttonFontSize.clamp(16.0, 22.0),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
