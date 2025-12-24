import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/core/constants/assets.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/services/shared_preferences_singleton.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/onboarding/models/onboarding_page_model.dart';
import 'package:grocery_app/features/onboarding/presentation/screens/widgets/animated_page_indicator.dart';
import 'package:grocery_app/core/widgets/custome_eleveted_button.dart';
import 'package:grocery_app/features/onboarding/presentation/screens/widgets/onboarding_page_content.dart';

import '../../../../../core/constants/constants.dart';

/// Main onboarding screen with animated page indicator
class OnboardingScreenBody extends StatefulWidget {
  const OnboardingScreenBody({super.key});

  @override
  State<OnboardingScreenBody> createState() => _OnboardingScreenBodyState();
}

class _OnboardingScreenBodyState extends State<OnboardingScreenBody> {
  late final PageController _pageController;
  late final List<OnboardingPageModel> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pages = _createPages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<OnboardingPageModel> _createPages() {
    return [
      OnboardingPageModel(
        imagePath: Assets.imagesGirlWithGroceryBag,
        title: "Welcome to Qki Shop",
        titleStyle: AppTextStyles.interBold.copyWith(fontSize: 24),
        description: "Fresh Grocery and Dairly products",
        descriptionStyle: AppTextStyles.jostSemiBold.copyWith(fontSize: 20),
        spacing: 8.0,
        backgroundColor: AppColors.white,
      ),
      OnboardingPageModel(
        imagePath: Assets.imagesVegetableBasket,
        title: "Fresh, Hygienic, and natural",
        titleStyle: AppTextStyles.interBold.copyWith(fontSize: 24),
        description: "Here grocery becomes simple.",
        descriptionStyle: AppTextStyles.jostSemiBold.copyWith(fontSize: 20),
        spacing: 15.0,
        backgroundColor: AppColors.lightYellow,
      ),
      OnboardingPageModel(
        imagePath: Assets.imagesDeliveryScooter,
        title: "Order, deliver and Repeat",
        titleStyle: AppTextStyles.jostBold.copyWith(fontSize: 24),
        description: "So quick and classy.",
        descriptionStyle: AppTextStyles.interBold.copyWith(fontSize: 19),
        spacing: 17.0,
        backgroundColor: AppColors.lightGray,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive spacing
    final indicatorSpacing = screenHeight * 0.02;
    final bottomSpacing = screenHeight * 0.03;

    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        // Calculate current page for background color animation
        final currentPage =
        _pageController.hasClients ? (_pageController.page ?? 0) : 0.0;
        final pageIndex = currentPage.round().clamp(0, _pages.length - 1);

        // Check if we're on the last page
        final isLastPage = pageIndex == _pages.length - 1;

        return Scaffold(
          backgroundColor: _pages[pageIndex].backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return OnboardingPageContent(
                        pageData: _pages[index],
                        isMiddlePage: index == 1, // Yellow page
                      );
                    },
                  ),
                ),
                SizedBox(height: indicatorSpacing),
                AnimatedPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey.shade400,
                ),
                SizedBox(height: bottomSpacing),
                // Show buttons only on last page
                if (isLastPage) ...[
                  CustomeElevatedButton(
                    text: 'CREATE AN ACCOUNT',
                    onTap: () {
                      context.push(AppRoutes.signup);
                    },
                  ),
                  CustomeElevatedButton(
                    text: 'LOGIN',
                    onTap: () {
                      AppPrefs.setBool(kOnBoardingViewSeen, true);
                      context.push(AppRoutes.login);
                    },
                  ),
                ],
                SizedBox(height: bottomSpacing),
              ],
            ),
          ),
        );
      },
    );
  }
}