import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/const/shape/media_query.dart';
import 'package:online_shop/const/theme/colors.dart';
import 'package:online_shop/features/public_features/functions/pre_values/pre_values.dart';
import 'package:online_shop/features/public_features/screens/bottom_nav_bar.dart';

class UnknownScreen extends StatefulWidget {
  const UnknownScreen({super.key});

  static const String screenId = '/unknown';

  @override
  State<UnknownScreen> createState() => _UnknownScreenState();
}

class _UnknownScreenState extends State<UnknownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, BottomNavBarScreen.screenId);
            },
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          spacing: 20.sp,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              PreValues().dontknowUrl,
              width: getWidth(context, 0.7.sp),
            ),
            Text(
              'صفحه مورد نظر یافت نشد',
              style: TextStyle(
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
