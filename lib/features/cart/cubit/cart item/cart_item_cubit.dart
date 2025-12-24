import 'package:bloc/bloc.dart';
import 'package:grocery_app/features/cart/data/models/cart_item_model.dart';
import 'package:meta/meta.dart';

part 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(CartItemInitial());

  void updateCartItem(CartItemModel cartItemModel){
    emit(CartItemUpdated(cartItemModel: cartItemModel));
  }
}
