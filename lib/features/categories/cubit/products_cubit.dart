import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/api/api_service.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ApiService apiService;

  ProductsCubit(this.apiService) : super(ProductsInitial());
  //money location
  Map<String, List<ProductModel>> allCategories = {};

  Future<void> getAllProducts() async {
    if (allCategories.isNotEmpty) {
      emit(CategoriesSuccess());
      return;
    }

    emit(ProductsLoading());
    try {
      final response = await apiService.getProducts();
      if (response.isNotEmpty) {
        allCategories = response[0].categories;
        emit(CategoriesSuccess());
      }
    } catch (e) {
      emit(ProductsFailure(e.toString()));
    }
  }

  Future<void> getProductsByCategory(String category) async {
    emit(ProductsLoading());
    try {
      if (allCategories.isEmpty) {
        await getAllProducts();
        emit(ProductsLoading());
      }

      final categoryKey = category.toLowerCase();
      //categoryKey==Key Search in map about category
      final products = allCategories[categoryKey] ?? [];
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsFailure(e.toString()));
    }
  }

  int getProductCountByCategory(String category) {
    final categoryKey = category.toLowerCase();
    return allCategories[categoryKey]?.length ?? 0;
  }
}
