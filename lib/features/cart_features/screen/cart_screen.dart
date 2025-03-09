import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/features/cart_features/screen/payment_webview.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three/number_to_three.dart';
import '../logic/cart_bloc.dart';
import '../model/show_cart_model.dart';
import '../services/cart_api_repository.dart';
import '../widget/cart_list_widget.dart';
import '../widget/shimmer_loading_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String screenId = 'cart_screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(
        CartApiRepository(),
      )..add(CallShowCart()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primary2Color,
          body: Stack(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is ShowCartLoadingState) {
                    return ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) => ShimmerLoadingWidget(),
                    );
                  }
                  if (state is ShowCartCompletedState) {
                    return CartItemsList(
                      showCartModel: state.showCartModel,
                      totalPrice: state.totalPrice,
                    );
                  }
                  if (state is ShowCartErrorState) {
                    return Center(
                      child: Text(
                        state.error.errorMsg ?? 'An error occurred',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),

              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is ShowCartCompletedState) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: BuySectionWidget(
                        showCartModel: state.showCartModel,
                        totalPrice: state.totalPrice,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuySectionWidget extends StatelessWidget {
  const BuySectionWidget({super.key, required this.showCartModel, required this.totalPrice});

  final ShowCartModel showCartModel;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return showCartModel.items!.isNotEmpty ?Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: getBorderRadiusFunc(10),
      ),
      width: getAllWidth(context),
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              totalPrice.toString() + '\$',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'sahel',
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: Size(getWidth(context, 0.4), 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PaymentSWebViewScreen.screenId,
                      arguments: {
                        'id' : showCartModel.items!.first.id,
                      },
                    );
                  },
                  child: Text(
                    'خرید',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'irs',
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ) : SizedBox();
  }
}