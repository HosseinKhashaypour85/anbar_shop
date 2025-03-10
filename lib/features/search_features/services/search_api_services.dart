import 'package:dio/dio.dart';

class SearchApiServices {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Response> callSearchApi() async {
    try {
      final apiUrl = 'https://fakestoreapi.com/products';
      final Response response = await _dio.get(apiUrl);
      print("API Response: ${response.data}"); // Debugging
      return response;
    } catch (e) {
      print("API Call Error: $e");
      throw Exception("API Request Failed");
    }
  }
}