import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/const/theme/colors.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../public_features/functions/pre_values/pre_values.dart';
import '../model/home_model.dart';

class ProductsFirstSlider extends StatelessWidget {
  const ProductsFirstSlider({super.key, required this.homeModel});

  final List<HomeModel> homeModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.sp),
        width: getAllWidth(context),
        height: getHeight(context, 0.5),
        color: primaryColor,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: homeModel.length,
          itemBuilder: (context, index) {
            final helper = homeModel[index];
            return GestureDetector (
              onTap: () {
              //   navigate to info screen
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: getWidth(context, 0.5),
                height: getHeight(context, 0.6),
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                margin: EdgeInsets.only(right: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: getBorderRadiusFunc(10),
                      child: FadeInImage(
                        placeholder: AssetImage(
                          PreValues().image2Logo,
                        ),
                        image: NetworkImage(
                          helper.image!,
                        ),
                        width: getWidth(context, 0.3.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Text(
                        helper.title!,
                        style: TextStyle(
                          fontFamily: 'irs',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      helper.price.toString() + '\$',
                      style: TextStyle(
                        fontFamily: 'irs',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
