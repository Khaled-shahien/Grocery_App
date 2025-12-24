import 'package:grocery_app/features/categories/data/models/product_model.dart';

class CartItemModel{
  final ProductModel productModel;
  int quantity;

  CartItemModel({required this.productModel, required this.quantity});

  num calcTotalPrice(){
    return productModel.price * quantity;
  }

  increaseCount(){
    quantity++;
  }

  decreaseCount(){
    if (quantity > 1) {
      quantity--;
    }
  }
}