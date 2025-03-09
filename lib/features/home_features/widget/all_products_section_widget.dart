import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/features/products_features/screen/products_info_screen.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../cart_features/logic/cart_bloc.dart';
import '../model/home_model.dart';

class AllProductsSection extends StatelessWidget {
  const AllProductsSection({super.key, required this.homeModel});

  final List<HomeModel> homeModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeModel.length,
      itemBuilder: (context, index) {
        final helper = homeModel[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child: Image.network(
                    helper.image!,
                    width: getWidth(context, 0.3.sp),
                  ),
                ),
                SizedBox(width: 12.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        helper.title!,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: 4.sp),
                    ],
                  ),
                ),
                SizedBox(width: 12.sp),
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
                    Navigator.pushReplacementNamed(
                      context,
                      ProductsInfoScreen.screenId,
                      arguments: {
                        'id' : helper.id,
                        'title' : helper.title,
                        'image' : helper.image,
                        'desc' : helper.description,
                        'price' : helper.price,
                        'rating' : helper.rating,
                      }
                    );
                  },
                  child: Text(
                    'مشاهده محصول',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontFamily: 'irs',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
