import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/home/cubit/home_cubit.dart';

class TrendingDetailsBody extends StatefulWidget {
  const TrendingDetailsBody({super.key});

  @override
  State<TrendingDetailsBody> createState() => _TrendingDetailsBodyState();
}

class _TrendingDetailsBodyState extends State<TrendingDetailsBody> {
  @override
  void initState() {
    super.initState();
    // Fetch trending deals data when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Trending Deals',
          style: AppTextStyles.poppinsSemiBold.copyWith(
            fontSize: 20,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            );
          } else if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: AppTextStyles.poppinsMedium.copyWith(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().fetchHomeData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: AppTextStyles.poppinsBold.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.trendingDeals.length,
                itemBuilder: (context, index) {
                  final deal = state.trendingDeals[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              image: deal.imageUrl.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(deal.imageUrl),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: deal.imageUrl.isEmpty
                                ? const Icon(Icons.local_offer, size: 40)
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal.name,
                                style: AppTextStyles.poppinsMedium.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '\$${deal.price}',
                                    style: AppTextStyles.poppinsBold.copyWith(
                                      fontSize: 16,
                                      color: AppColors.primaryOrange,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '\$${deal.oldPrice}',
                                    style: AppTextStyles.poppinsRegular
                                        .copyWith(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            // Initial state - show loading
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            );
          }
        },
      ),
    );
  }
}