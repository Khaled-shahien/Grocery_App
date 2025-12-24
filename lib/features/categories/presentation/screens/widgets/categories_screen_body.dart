import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/features/categories/cubit/products_cubit.dart';
import 'package:grocery_app/features/categories/presentation/screens/widgets/category_item.dart';
import '../../../../../constants/assets.dart';

class CategoriesScreenBody extends StatefulWidget {
  const CategoriesScreenBody({super.key});

  @override
  State<CategoriesScreenBody> createState() => _CategoriesScreenBodyState();
}

class _CategoriesScreenBodyState extends State<CategoriesScreenBody> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final horizontalPadding = screenWidth * 0.04;
    final crossAxisSpacing = screenWidth * 0.04;
    final mainAxisSpacing = screenWidth * 0.04;

    // Determine grid columns based on screen width
    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth < 600) {
      crossAxisCount = 2;
      childAspectRatio = 0.95;
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
      childAspectRatio = 1.0;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 1.05;
    }

    final categories = [
      {'image': Assets.imagesFruitsIcon, 'name': 'Fruits'},
      {'image': Assets.imagesVegetablesIcon, 'name': 'Vegetables'},
      {'image': Assets.imagesMushroomsIcon, 'name': 'Mushroom'},
      {'image': Assets.imagesFruitsIcon, 'name': 'Dairy'},
      {'image': Assets.imagesVegetablesIcon, 'name': 'Oats'},
      {'image': Assets.imagesMushroomsIcon, 'name': 'Bread'},
      {'image': Assets.imagesFruitsIcon, 'name': 'Rice'},
      {'image': Assets.imagesVegetablesIcon, 'name': 'Egg'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsFailure) {
            return Center(child: Text('Error: ${state.errMessage}'));
          }

          if (state is CategoriesSuccess || state is ProductsSuccess) {
            return Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryName = category['name'] as String;

                  int itemCount = context
                      .read<ProductsCubit>()
                      .getProductCountByCategory(categoryName);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      context.push('/category-products/$categoryName');
                    },
                    child: CategoryItem(
                      image: category['image'] as String,
                      textItem: categoryName,
                      itemCount: itemCount,
                      isSelected: selectedIndex == index,
                    ),
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