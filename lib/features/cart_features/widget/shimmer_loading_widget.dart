
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: getBorderRadiusFunc(10),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.all(10.sp),
        width: getAllHeight(context),
        height: 70.sp,
      ),
    );
  }
}