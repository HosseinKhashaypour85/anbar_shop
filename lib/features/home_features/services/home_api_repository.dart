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


}
