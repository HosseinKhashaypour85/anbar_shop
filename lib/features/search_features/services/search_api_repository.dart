import 'package:dio/dio.dart';
import 'package:online_shop/features/search_features/model/search_model.dart';
import 'package:online_shop/features/search_features/services/search_api_services.dart';

class SearchApiRepository {
  final SearchApiServices _apiServices = SearchApiServices();

  Future<List<SearchModel>> callSearchApi() async {
    try {
      final Response response = await _apiServices.callSearchApi();

      if (response.data is List) {
        List<SearchModel> homeList = (response.data as List).map((item) {
          print("Parsing item: $item");
          return SearchModel.fromJson(item);
        }).toList();
        return homeList;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      print("Repository Error: $e");
      throw Exception("API Request Failed");
    }
  }
}
