import 'package:grocery_app/features/cart/data/models/cart_item_model.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';

class CartModel{
  final List<CartItemModel> cartItems;

  CartModel({required this.cartItems});

  void addCartItem(CartItemModel cartItemModel){
    cartItems.add(cartItemModel);
  }

  bool isExist (ProductModel productModel){
    for(var cartItem in cartItems){
      if(cartItem.productModel.id == productModel.id) return true;
    }
    return false;
  }

  CartItemModel getCartItem(ProductModel productModel){
    for(var cartItem in cartItems){
      if(cartItem.productModel.id == productModel.id) return cartItem;
    }
    return CartItemModel(productModel: productModel, quantity: 1);
  }

  num calcTotalPrice(){
    num total = 0;
    for(var cartItem in cartItems){
      total += cartItem.calcTotalPrice();
    }
    return total;
  }

  void deleteCartItem(CartItemModel cartItem){
    cartItems.remove(cartItem);
  }
}