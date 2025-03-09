import 'package:dio/dio.dart';
import 'package:online_shop/features/public_features/functions/id_generator/id_generator.dart';
import 'package:online_shop/features/public_features/functions/secure_storage/secure_storage.dart';

import '../model/show_cart_model.dart';

class CartApiServices {
  final Dio _dio = Dio();

  Future<Response?> callAddToCartApi(String id, String title, int count,
      double price, bool checkCart, String image) async {
    try {
      final token = await SecureStorage().getUserToken();
      if (token == null || token.isEmpty) {
        throw Exception("توکن نامعتبر است");
      }

      final String idGenerator = IdGenerator().idGenerator();

      final apiUrl =
          'https://hosseinkhashaypour.chbk.app/api/collections/anabar_cart/records';

      final Response response = await _dio.post(
        apiUrl,
        data: {
          'id': idGenerator,
          'token': token,
          'image': image,
          'count': count,
          'title': title,
          'price': price,
          'isInBasket': checkCart,
        },
      );

      return response;
    } on DioException catch (e) {
      print("API Error: ${e.response?.data ?? e.message}");
      return e.response;
    } catch (e) {
      print("Unknown Error: $e");
      return null;
    }
  }

  Future<Response> callShowCartApi() async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/anabar_cart/records';
    final Response response = await _dio.get(apiUrl);
    return response;
  }

  Future<Response> callDeleteProductApi(String id) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/anabar_cart/records/$id';
    final Response response = await _dio.delete(apiUrl);
    return response;
  }
}
