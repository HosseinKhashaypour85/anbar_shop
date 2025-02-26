import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/features/auth_features/screens/auth_screen.dart';
import 'package:online_shop/features/category_features/screens/choose_category_screen.dart';
import 'package:online_shop/features/home_features/screen/home_screen.dart';
import 'package:online_shop/features/public_features/logic/bottomnav_cubit.dart';

import '../../../const/theme/colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  static const String screenId = 'bottomNav';

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screenList = [
    HomeScreen(),
    ChooseCategoryScreen(),
    Container(),
    AuthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomnavCubit , int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: primaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'irs',
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'irs',
            ),
            items: [
              BottomNavigationBarItem(
                label: 'خانه',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'دسته بندی ها',
                icon: Icon(Icons.category_outlined),
                activeIcon: Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                label: 'سبد خرید',
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart),
              ),
              BottomNavigationBarItem(
                label: 'حساب کاربری',
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
              ),
            ],
            currentIndex: BlocProvider.of<BottomnavCubit>(context).currentIndex ,
            onTap: (value) {
              BlocProvider.of<BottomnavCubit>(context).changeIndex(value);
            },
          ),
          body: screenList.elementAt(BlocProvider.of<BottomnavCubit>(context).currentIndex),
        );
      },
    );
  }
}
