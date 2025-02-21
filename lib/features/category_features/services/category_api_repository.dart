import 'package:dio/dio.dart';
import 'package:online_shop/features/category_features/model/category_model.dart';
import 'package:online_shop/features/category_features/services/category_api_services.dart';

class CategoryApiRepository {
  final CategoryApiServices _apiServices = CategoryApiServices();

  Future<CategoryModel> callCategoryApi(String category) async {
    final Response response = await _apiServices.callCategoryApi(category);
    CategoryModel categoryModel = CategoryModel.fromJson(response.data);
    return categoryModel;
  }
}
