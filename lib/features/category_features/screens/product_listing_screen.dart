// product_listing_screen.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/const/theme/colors.dart';
import 'package:online_shop/features/category_features/model/category_model.dart';
import 'package:online_shop/features/public_features/functions/pre_values/pre_values.dart';
import '../../../const/shape/border_radius.dart';
import '../services/category_api_services.dart';

class ProductListingScreen extends StatefulWidget {
  final String category;

  const ProductListingScreen({super.key, required this.category});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late Future<List<CategoryModel>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts(widget.category);
  }

  Future<List<CategoryModel>> fetchProducts(String category) async {
    final response = await CategoryApiServices().callCategoryApi(category);

    if (response.statusCode == 200) {
      print(response.data); // چاپ داده‌ها برای بررسی
      return (response.data as List)
          .map((product) => CategoryModel.fromJson(product))
          .toList();
    } else {
      throw Exception('خطا در دریافت داده: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: FutureBuilder<List<CategoryModel>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('خطا: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('محصولی یافت نشد'));
          }

          final products = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.5, 
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: EdgeInsets.all(8.sp),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FadeInImage(
                          placeholder: AssetImage(PreValues().image2Logo),
                          image: NetworkImage(product.image!),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Text(
                          product.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${product.price?.toStringAsFixed(2) ?? ''} تومان',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.sp, vertical: 10.sp),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(8.sp),
                          ),
                        ),
                        onPressed: () {
                          //   add to cart
                        },
                        child: Text(
                          'افزودن به سبد خرید',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'irs',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.sp),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
