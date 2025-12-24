import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/api/api_service.dart';
import 'package:grocery_app/core/api/dio_factory.dart';
import 'package:grocery_app/features/auth/presentation/screens/congratulations.dart';
import 'package:grocery_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:grocery_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:grocery_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:grocery_app/features/categories/cubit/products_cubit.dart';
import 'package:grocery_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:grocery_app/features/categories/presentation/screens/category_products_screen.dart';
import 'package:grocery_app/features/layout/presentation/screens/layout_screen.dart';
import 'package:grocery_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:grocery_app/features/products_home/presentation/screens/products_screen.dart';
import 'package:grocery_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:grocery_app/features/trending_deals/presentation/screens/trending_deals_screen.dart';

class AppRouter {
  static final apiService = ApiService(DioFactory.create());

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.congratulations,
        builder: (context, state) {
          final userName = state.extra as String? ?? 'User';
          return CongratulationsScreen(userName: userName);
        },
      ),
      GoRoute(
        path: AppRoutes.categories,
        builder: (context, state) => BlocProvider(
          create: (context) => ProductsCubit(apiService),
          child: const CategoriesScreen(),
        ),
      ),
      GoRoute(
        path: '${AppRoutes.categoryProducts}/:categoryName',
        builder: (context, state) {
          final categoryName = state.pathParameters['categoryName']!;
          return BlocProvider(
            create: (context) => ProductsCubit(apiService),
            child: CategoryProductsScreen(categoryName: categoryName),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) => const ProductsHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.layout,
        builder: (context, state) => const LayoutScreen(),
      ),
      // Add Trending Deals route
      GoRoute(
        path: AppRoutes.trendingDeals,
        builder: (context, state) => const TrendingDealsScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text('Error: ${state.error?.message}')),
      );
    },
  );
}

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String productDetails = '/product-details';
  static const String congratulations = '/congratulations';
  static const String categories = '/categories';
  static const String categoryProducts = '/category-products';
  static const String cart = '/cart';
  static const String product = '/product';
  static const String layout = '/layout';
  // Add Trending Deals route constant
  static const String trendingDeals = '/trending-deals';
}
