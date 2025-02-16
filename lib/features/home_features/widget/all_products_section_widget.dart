import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
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
                        ),
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
                  onPressed: () {},
                  child: Text(
                    'افزودن به سبد خرید',
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
