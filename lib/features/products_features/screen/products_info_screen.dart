import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/features/public_features/widget/rating_widget.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../cart_features/logic/cart_bloc.dart';
import '../../home_features/model/home_model.dart';
import '../../public_features/functions/secure_storage/secure_storage.dart';
import '../../public_features/screens/bottom_nav_bar.dart';
import '../../public_features/widget/snack_bar_widget.dart';

class ProductsInfoScreen extends StatefulWidget {
  const ProductsInfoScreen({super.key});

  static const String screenId = '/info';

  @override
  State<ProductsInfoScreen> createState() => _ProductsInfoScreenState();
}

class _ProductsInfoScreenState extends State<ProductsInfoScreen> {
  bool isAddedToCart = false;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String productId = arguments['id'].toString(); // Convert to String
    final String productImage = arguments['image'];
    final String productTitle = arguments['title'];
    final String productDesc = arguments['desc'];
    final productRate =
        arguments['rating'] != null ? arguments['rating'].rate ?? 0.0 : 0.0;
    final String productPrice =
        arguments['price'].toString(); // Convert to String

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
              if (isFav) {
                getSnackBarWidget(context,
                    'محصول با موفقیت به علاقه مندی ها اضافه شد', Colors.green);
              } else {
                getSnackBarWidget(
                    context, 'محصول از علاقه مندی ها حذف شد', Colors.red);
              }
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_outline,
              color: isFav ? Colors.red : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomNavBarScreen.screenId,
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  children: [
                    Image.network(productImage,
                        width: getWidth(context, 0.5.sp)),
                    SizedBox(height: 10.sp),
                    Text(
                      productDesc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'قیمت محصول: ',
                          style: TextStyle(fontFamily: 'irs', fontSize: 16.sp),
                        ),
                        SizedBox(width: 5.sp),
                        Text(
                          '$productPrice\$',
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 16.sp,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    Row(
                      children: [
                        Text(
                          'نظرات :',
                          style: TextStyle(
                            fontFamily: 'irs',
                            fontSize: 16.sp,
                          ),
                        ),
                        CustomRatingBar(rating: productRate),
                      ],
                    ),
                    SizedBox(height: 20.sp),
                    BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is AddToCartCompletedState) {
                          getSnackBarWidget(context,
                              'محصول به سبد خرید اضافه شد', Colors.green);
                          setState(() {
                            isAddedToCart = true;
                          });
                        } else if (state is AddToCartErrorState) {
                          getSnackBarWidget(
                              context, 'محصول در سبد خرید هست!', Colors.red);
                        }
                      },
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is AddToCartLoadingState) {
                            return const CircularProgressIndicator(
                              color: primaryColor,
                            );
                          }
                          return isAddedToCart
                              ? _buildDisabledButton('محصول در سبد خرید')
                              : _buildAddToCartButton(productId, productImage,
                                  productTitle, productPrice);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(String productId, String productImage,
      String productTitle, String productPrice) {
    return ElevatedButton(
      style: _buttonStyle(primaryColor),
      onPressed: () async {
        String? token = await SecureStorage().getUserToken();

        if (token == null || token.isEmpty) {
          getSnackBarWidget(context, 'توکن نامعتبر است', Colors.red);
          return;
        }
        BlocProvider.of<CartBloc>(context).add(
          AddToCartEvent(
            id: productId,
            checkCart: true,
            count: 1,
            image: productImage,
            price: double.tryParse(productPrice) ?? 0.0,
            // تبدیل قیمت به double
            title: productTitle,
            token: token,
          ),
        );
      },
      child: _buttonText('افزودن به سبد خرید'),
    );
  }

  Widget _buildDisabledButton(String text) {
    return ElevatedButton(
      style: _buttonStyle(boxColors),
      onPressed: null,
      child: _buttonText(text),
    );
  }

  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      fixedSize: Size(getWidth(context, 3.29), getHeight(context, 0.057)),
      shape: RoundedRectangleBorder(borderRadius: getBorderRadiusFunc(5)),
    );
  }

  Text _buttonText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontFamily: 'irs',
      ),
    );
  }
}
