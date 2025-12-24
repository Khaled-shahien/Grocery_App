import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/cubit/cart/cart_cubit.dart';
import 'package:grocery_app/features/cart/data/models/cart_item_model.dart';
import 'package:grocery_app/features/cart/presentation/screens/widgets/cart_item.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key, required this.cartItems});
  final List<CartItemModel> cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, i) {
        return Dismissible(
          key: ValueKey(cartItems[i]),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.delete_outline, color: Colors.white),
              ),
            ),
          ),
          onDismissed: (v) {
            // Use the context from the parent widget that has access to CartCubit
            final cartCubit = context.read<CartCubit>();
            cartCubit.removeProductFromCart(cartItems[i]);
          },
          child: CartItem(cartItem: cartItems[i]),
        );
      },
    );
  }
}
