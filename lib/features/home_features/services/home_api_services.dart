import 'package:dio/dio.dart';

class HomeApiServices {
  final Dio _dio = Dio();
  // first slider
  Future<Response>callHomeApi()async{
    final apiUrl = 'https://fakestoreapi.com/products';
    final Response response = await _dio.get(apiUrl);
    return response;
  }
  // all products
  Future<Response>callAllProductsApi()async{
    final apiUrl = 'https://dummyjson.com/products';
    final Response response = await _dio.get(apiUrl);
    return response;
  }
}