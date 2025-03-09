part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class AddToCartLoadingState extends CartState {}

class AddToCartCompletedState extends CartState {
  final CartModel cartModel;

  AddToCartCompletedState(this.cartModel);
}

class AddToCartErrorState extends CartState {
  final ErrorMessageClass error;

  AddToCartErrorState({required this.error});
}

//show product

class ShowCartLoadingState extends CartState {}

class ShowCartCompletedState extends CartState {
  final ShowCartModel showCartModel;
  final double totalPrice;

  ShowCartCompletedState(this.showCartModel, this.totalPrice);
}

class ShowCartErrorState extends CartState {
  final ErrorMessageClass error;

  ShowCartErrorState({required this.error});
}

//delete product
class DeleteProductLoadingState extends CartState {}

class DeleteProductCompletedState extends CartState {}