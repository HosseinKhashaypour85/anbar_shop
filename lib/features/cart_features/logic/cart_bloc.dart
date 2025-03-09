import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:online_shop/features/cart_features/model/show_cart_model.dart';
import '../../public_features/functions/error/error_exception.dart';
import '../../public_features/functions/error/error_message_class.dart';
import '../model/cart_model.dart';
import '../services/cart_api_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartApiRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<AddToCartEvent>(_addToCart);
    on<CallShowCart>(_showCart);
    on<CallDeleteProduct>(_deleteCart);
  }

  FutureOr<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(AddToCartLoadingState());

    try {
      final CartModel? cartModel = await repository.callAddToCartApi(
        event.id,
        event.title,
        event.count,
        event.price,
        event.checkCart,
        event.image,
      );

      if (cartModel == null) {
        emit(AddToCartErrorState(
          error: ErrorMessageClass(errorMsg: "خطا در دریافت اطلاعات از سرور"),
        ));
        return;
      }

      emit(AddToCartCompletedState(cartModel));
    } on DioException catch (e) {
      emit(AddToCartErrorState(
        error: ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)),
      ));
    } catch (e) {
      emit(AddToCartErrorState(
        error: ErrorMessageClass(errorMsg: "خطای نامشخص رخ داده است"),
      ));
    }
  }
  FutureOr<void> _showCart(CallShowCart event, Emitter<CartState> emit) async {
    emit(ShowCartLoadingState());

    try {
      ShowCartModel showCartModel = await repository.callShowCartApi();
      double totalPrice = 0;
      for(var product in showCartModel.items!){
        totalPrice += product.price?.toDouble() ?? 0;
      }

      if (showCartModel == null) {
        emit(ShowCartErrorState(
          error: ErrorMessageClass(errorMsg: "خطا در دریافت اطلاعات از سرور"),
        ));
        return;
      }

      emit(ShowCartCompletedState(showCartModel , totalPrice)); // ارسال وضعیت کامل شدن با داده‌ها
    } on DioException catch (e) {
      emit(ShowCartErrorState(
        error: ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)),
      ));
    } catch (e) {
      emit(ShowCartErrorState(
        error: ErrorMessageClass(errorMsg: "خطای نامشخص رخ داده است"),
      ));
    }
  }
  FutureOr<void> _deleteCart(
      CallDeleteProduct event, Emitter<CartState> emit) async {
    emit(DeleteProductLoadingState());
    try {
      await repository.callDeleteProductApi(event.id);
      ShowCartModel showCartModel = await repository.callShowCartApi();
      double totalPrice = 0;
      for(var product in showCartModel.items!){
        totalPrice += product.price?.toDouble() ?? 0;
      }
      emit(ShowCartCompletedState(showCartModel , totalPrice));
    } catch (e) {
      emit(ShowCartErrorState(
        error: ErrorMessageClass(errorMsg: e.toString()),
      ));
    }
  }
}
