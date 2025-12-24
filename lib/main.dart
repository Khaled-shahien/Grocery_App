import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/api/api_service.dart';
import 'package:grocery_app/core/api/dio_factory.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/services/shared_preferences_singleton.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/features/cart/cubit/cart/cart_cubit.dart';
import 'package:grocery_app/features/categories/cubit/products_cubit.dart';
import 'package:grocery_app/features/home/api_home/api_home.dart';
import 'package:grocery_app/features/home/cubit/home_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AppPrefs.init();

  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final ApiService apiService = ApiService(dio);
    final HomeApiService homeApiService = HomeApiService(DioFactory.create());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ProductsCubit(apiService)),
        BlocProvider(create: (context) => HomeCubit(homeApiService)..fetchHomeData()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Grocery App',
        builder: (context, child) {
          return BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartItemAdded || state is CartItemIncrease) {
                CustomSnackBar.showCart(
                  context: context,
                  title: 'Item Added',
                  message: 'Item successfully added to your cart',
                );
              }
              if (state is CartItemRemoved) {
                CustomSnackBar.showCart(
                  context: context,
                  title: 'Item Removed',
                  message: 'Item successfully removed from your cart',
                );
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}



