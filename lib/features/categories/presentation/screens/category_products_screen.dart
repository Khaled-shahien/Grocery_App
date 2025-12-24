import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/cart/cubit/cart/cart_cubit.dart';
import 'package:grocery_app/features/categories/cubit/products_cubit.dart';
import 'package:grocery_app/features/products_home/presentation/screens/widgets/product_card.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  void initState() {
    super.initState();
    //send categoryName
    context.read<ProductsCubit>().getProductsByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final horizontalPadding = screenWidth * 0.04;
    final titleFontSize = (screenWidth * 0.05).clamp(18.0, 22.0);
    final iconSize = (screenWidth * 0.06).clamp(22.0, 26.0);
    final errorIconSize = (screenWidth * 0.16).clamp(56.0, 72.0);
    final textFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final crossAxisSpacing = screenWidth * 0.04;
    final mainAxisSpacing = screenWidth * 0.04;

    // Determine grid columns based on screen width
    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth < 600) {
      crossAxisCount = 2;
      childAspectRatio = 0.7;
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
      childAspectRatio = 0.73;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 0.75;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName.toUpperCase(),
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: titleFontSize),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading ||
              state is CategoriesSuccess ||
              state is ProductsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            );
          }

          if (state is ProductsFailure) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: errorIconSize, color: Colors.red),
                    SizedBox(height: screenWidth * 0.04),
                    Text(
                      'Error: ${state.errMessage}',
                      style: AppTextStyles.poppinsMedium.copyWith(
                        fontSize: textFontSize,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProductsSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        size: errorIconSize,
                        color: Colors.grey,
                      ),
                      SizedBox(height: screenWidth * 0.04),
                      Text(
                        'No products found in this category',
                        style: AppTextStyles.poppinsMedium.copyWith(
                          fontSize: textFontSize,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return BlocProvider.value(
                    value: context.read<CartCubit>(),
                    child: ProductCard(product: state.products[index]),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}