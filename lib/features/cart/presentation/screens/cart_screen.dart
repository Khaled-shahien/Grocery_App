import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/cubit/cart%20item/cart_item_cubit.dart';
import 'package:grocery_app/features/cart/presentation/screens/widgets/cart_screen_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartItemCubit(),
      child: CartScreenBody(),
    );
  }
}