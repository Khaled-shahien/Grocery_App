import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/services/firebase_store_service.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/auth/data/models/user_model.dart';
import 'package:grocery_app/features/home/presentation/screens/widgets/cusom_category_list.dart';
import 'package:grocery_app/features/home/presentation/screens/widgets/custom_app_bar.dart';
import 'package:grocery_app/features/home/presentation/screens/widgets/custom_recommended_list.dart';
import 'package:grocery_app/features/home/presentation/screens/widgets/custom_trending_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/core/navigation/app_router.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseStoreService();
    final currentUser = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: FutureBuilder<UserModel>(
        future: firebaseService.getUserData(docId: currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ هنا بيظهر اسم المستخدم
              CustomAppBar(name: '${user.fName} ${user.lName}'),

              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14,
                        ),
                        child: Text(
                          'Recommended for ${user.fName}', // ✅ مثال تاني لعرض الاسم
                          style: AppTextStyles.poppinsRegular.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomRecommendedList(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              style: AppTextStyles.poppinsRegular.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.push(AppRoutes.categories);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16,
                        ),
                        child: SizedBox(height: 60, child: CusomCategoryList()),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trending deals',
                              style: AppTextStyles.poppinsRegular.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.push(AppRoutes.trendingDeals);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomTrendingGrid(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
