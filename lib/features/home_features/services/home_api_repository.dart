import 'package:dio/dio.dart';
import 'package:online_shop/features/home_features/model/all_products_home_model.dart';
import 'package:online_shop/features/home_features/model/home_model.dart';
import 'package:online_shop/features/home_features/services/home_api_services.dart';

class HomeApiRepository {
  final HomeApiServices _apiServices = HomeApiServices();

  Future<List<HomeModel>> callHomeApi() async {
    try {
      final Response response = await _apiServices.callHomeApi();

      if (response.data is List) {
        List<HomeModel> homeList = (response.data as List)
            .map((item) => HomeModel.fromJson(item))
            .toList();
        return homeList;
      } else {
        throw Exception("❌ Invalid response format");
      }
    } catch (e) {
      throw Exception("API Request Failed");
    }
  }
  // all products
  // Future<List<AllProductsHomeModel>> callAllProductsHomeApi() async {
  //   try {
  //     final Response response = await _apiServices.callAllProductsApi();
  //
  //     if (response.data is List) {
  //       return (response.data as List)
  //           .map((item) => AllProductsHomeModel.fromJson(item))
  //           .toList();
  //
  //     } else {
  //       throw Exception('❌ Invalid response format for all products');
  //     }
  //   } on DioException catch (e) {
  //     throw Exception('🛑 API Request Failed: ${e.message}');
  //   } catch (e) {
  //     throw Exception('❌ Unexpected Error: $e');
  //   }
  // }

}
