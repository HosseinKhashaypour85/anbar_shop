import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/features/intro_features/logic/intro_cubit.dart';
import 'package:online_shop/features/intro_features/logic/pref/shared_pref.dart';
import 'package:online_shop/features/public_features/screens/bottom_nav_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const String screenId = '/intro';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController(initialPage: 0);

  List<Widget> pageItem = [
    PageViewItems(
      image: 'assets/images/delivery.png',
      name: 'ارسال سریع',
      desc: 'ارسال سریع محصول شما توسط ما',
    ),
    PageViewItems(
      image: 'assets/images/money.png',
      name: 'پرداخت درب منزل',
      desc: 'برای پرداخت شما عجله ای نیست :)',
    ),
    PageViewItems(
      image: 'assets/images/time.png',
      name: 'خرید سریع',
      desc: 'با فیلتر محصولات سریع محصول مورد نظر پیدا کن',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IntroCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 150.sp,
                  color: primaryColor,
                  child: Container(
                    height: 200,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200.sp,
                      height: 400.sp,
                      child: PageView.builder(
                        itemCount: pageItem.length,
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return pageItem[index];
                        },
                        onPageChanged: (value) {
                          BlocProvider.of<IntroCubit>(context)
                              .changeIndex(value);
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: pageItem.length,
                      axisDirection: Axis.horizontal,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        activeDotColor: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(getWidth(context, 0.5), 45),
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {
                            if (BlocProvider.of<IntroCubit>(context)
                                    .screenIndex <
                                2) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            } else {
                              SharedPref().setIntroStatus();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                BottomNavBarScreen.screenId,
                                (route) => false,
                              );
                            }
                          },
                          child: Text(
                            BlocProvider.of<IntroCubit>(context).screenIndex < 2
                                ? 'مرحله بعدی'
                                : 'بزن بریم',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'irs',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PageViewItems extends StatelessWidget {
  const PageViewItems({
    super.key,
    required this.image,
    required this.name,
    required this.desc,
  });

  final String image;
  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 200,
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'irs',
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            desc,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'irs',
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
