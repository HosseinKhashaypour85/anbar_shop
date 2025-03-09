import 'dart:async';

import 'package:dio/dio.dart';
import 'package:online_shop/features/cart_features/model/cart_model.dart';
import 'package:online_shop/features/cart_features/model/show_cart_model.dart';
import 'package:online_shop/features/cart_features/services/cart_api_services.dart';

class CartApiRepository {
  final CartApiServices _apiServices = CartApiServices();

  Future<CartModel?> callAddToCartApi(String id, String title, int count,
      double price, bool checkCart, String image) async {
    try {
      final Response? response = await _apiServices.callAddToCartApi(
          id, title, count, price, checkCart, image);

      if (response == null) {
        throw Exception("پاسخی از سرور دریافت نشد.");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CartModel.fromJson(response.data);
      } else {
        throw Exception(
            "خطا در افزودن محصول به سبد: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("API Error: ${e.response?.data ?? e.message}");
      throw Exception("مشکلی در ارتباط با سرور به وجود آمد.");
    } catch (e) {
      print("Unknown Error: $e");
      throw Exception("خطای نامشخص رخ داده است.");
    }
  }

  Future<ShowCartModel> callShowCartApi() async {
    final Response response = await _apiServices.callShowCartApi();
    ShowCartModel showCartModel = ShowCartModel.fromJson(response.data);
    return showCartModel;
  }
  Future<void> callDeleteProductApi(String id) async {
    await _apiServices.callDeleteProductApi(id);
  }
}
