import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/features/category_features/logic/bloc/category_bloc.dart';
import 'package:online_shop/features/category_features/services/category_api_repository.dart';
import 'package:online_shop/features/home_features/logic/bloc/home_bloc.dart';
import 'package:online_shop/features/home_features/services/home_api_repository.dart';
import 'package:online_shop/features/intro_features/logic/intro_cubit.dart';
import 'package:online_shop/features/intro_features/screens/splash_screen.dart';
import 'package:online_shop/features/public_features/screens/bottom_nav_bar.dart';

import 'features/category_features/screens/choose_category_screen.dart';
import 'features/home_features/screen/filter_screen.dart';
import 'features/home_features/screen/home_screen.dart';
import 'features/intro_features/screens/intro_screen.dart';
import 'features/public_features/logic/bottomnav_cubit.dart';
import 'features/public_features/screens/unknown_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomnavCubit(),
          ),
          BlocProvider(
            create: (context) => IntroCubit(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              HomeApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
              CategoryApiRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('fa'),
          ],
          initialRoute: SplashScreen.screenId,
          routes: {
            UnknownScreen.screenId: (context) => UnknownScreen(),
            BottomNavBarScreen.screenId: (context) => BottomNavBarScreen(),
            SplashScreen.screenId: (context) => SplashScreen(),
            IntroScreen.screenId: (context) => IntroScreen(),
            HomeScreen.screenId: (context) => HomeScreen(),
            ChooseCategoryScreen.screenId: (context) => ChooseCategoryScreen(),
          },
          // showSemanticsDebugger: true,
        ),
      ),
    );
  }
}
