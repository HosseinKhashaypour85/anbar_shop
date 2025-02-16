import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/const/shape/media_query.dart';
import 'package:online_shop/features/intro_features/logic/pref/shared_pref.dart';
import 'package:online_shop/features/intro_features/screens/intro_screen.dart';
import 'package:online_shop/features/public_features/functions/pre_values/pre_values.dart';
import 'package:online_shop/features/public_features/screens/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateFunc() {
    Timer(
      Duration(seconds: 3),
      () async {
        if (await SharedPref().getIntroStatus()) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavBarScreen.screenId,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            IntroScreen.screenId,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    navigateFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInUp(
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      PreValues().image2Logo,
                      width: getWidth(context, 0.7.sp),
                    ),
                    Text(
                      PreValues().websiteUrl,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
