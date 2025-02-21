import 'package:dio/dio.dart';
import 'package:online_shop/features/category_features/model/category_model.dart';

class CategoryApiServices {
  final Dio _dio = Dio();
  Future<Response>callCategoryApi(String category)async{
    final apiUrl = 'https://fakestoreapi.com/products/category/$category';
    final Response response = await _dio.get(apiUrl);
    return response;
  }
}