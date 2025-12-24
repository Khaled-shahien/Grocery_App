import 'package:bloc/bloc.dart';
import 'package:grocery_app/features/cart/data/models/cart_item_model.dart';
import 'package:grocery_app/features/cart/data/models/cart_model.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  // ابدأ بـ cart فاضية
  CartModel cartModel = CartModel(
    cartItems: [], // امسح المنتجات اللي كانت هنا
  );

  void addProductToCart(ProductModel productModel) {
    bool isProductExistInCart = cartModel.isExist(productModel);
    
    if (isProductExistInCart) {
      CartItemModel cartItemModel = cartModel.getCartItem(productModel);
      cartItemModel.increaseCount();
      emit(CartItemIncrease());
    } else {
      // لو المنتج مش موجود، اعمل CartItemModel جديد
      CartItemModel newCartItem = CartItemModel(
        productModel: productModel,
        quantity: 1,
      );
      cartModel.addCartItem(newCartItem);
      emit(CartItemAdded());
    }
  }

  void removeProductFromCart(CartItemModel cartItemModel) {
    cartModel.deleteCartItem(cartItemModel);
    emit(CartItemRemoved());
  }
}