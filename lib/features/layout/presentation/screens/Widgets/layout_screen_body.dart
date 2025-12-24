import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/core/constants/assets.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:grocery_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:grocery_app/features/home/presentation/screens/home_screen.dart';
import 'package:grocery_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:grocery_app/features/profile/presentation/screens/profile_screen.dart';

class LayoutScreenBody extends StatefulWidget {
  const LayoutScreenBody({super.key});

  @override
  State<LayoutScreenBody> createState() => _LayoutScreenBodyState();
}

class _LayoutScreenBodyState extends State<LayoutScreenBody> {
  int _currentIndex = 2;

  final List<Widget> _screens = const [
    CategoriesScreen(),
    FavoritesScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values for navigation bar
    final navBarHeight = (screenHeight * 0.075).clamp(55.0, 70.0);
    final standardIconSize = (screenWidth * 0.06).clamp(22.0, 28.0);
    final homeIconSize = (screenWidth * 0.075).clamp(28.0, 35.0);
    final animationDuration = const Duration(milliseconds: 300);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: navBarHeight,
        backgroundColor: Colors.transparent,
        color: AppColors.primaryGreen,
        buttonBackgroundColor: AppColors.primaryOrange,
        animationDuration: animationDuration,
        items: [
          SvgPicture.asset(
            Assets.imagesViewGrid,
            width: standardIconSize,
            height: standardIconSize,
            colorFilter: ColorFilter.mode(
              _currentIndex == 0
                  ? AppColors.white
                  : AppColors.white.withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            Assets.imagesFavorite,
            width: standardIconSize,
            height: standardIconSize,
            colorFilter: ColorFilter.mode(
              _currentIndex == 1
                  ? AppColors.white
                  : AppColors.white.withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            Assets.imagesHome,
            width: homeIconSize,
            height: homeIconSize,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            Assets.imagesShopping,
            width: standardIconSize,
            height: standardIconSize,
            colorFilter: ColorFilter.mode(
              _currentIndex == 3
                  ? AppColors.white
                  : AppColors.white.withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
          Icon(
            Icons.person,
            size: standardIconSize,
            color: _currentIndex == 4
                ? AppColors.white
                : AppColors.white.withOpacity(0.6),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
