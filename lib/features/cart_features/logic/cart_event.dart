part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String id;
  final dynamic token;
  final String image;
  final int count;
  final String title;
  final double price;
  final bool checkCart;

  AddToCartEvent({
    required this.id,
    required this.token,
    required this.image,
    required this.count,
    required this.title,
    required this.price,
    required this.checkCart,
  });
}

class CallShowCart extends CartEvent {}

// delete product
class CallDeleteProduct extends CartEvent {
  final String id;
  CallDeleteProduct({required this.id});
}
