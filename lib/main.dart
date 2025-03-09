import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_shop/features/auth_features/logic/auth_bloc.dart';
import 'package:online_shop/features/auth_features/services/auth_api_repository.dart';
import 'package:online_shop/features/cart_features/logic/cart_bloc.dart';
import 'package:online_shop/features/cart_features/screen/cart_screen.dart';
import 'package:online_shop/features/cart_features/screen/payment_webview.dart';
import 'package:online_shop/features/cart_features/services/cart_api_repository.dart';
import 'package:online_shop/features/category_features/logic/bloc/category_bloc.dart';
import 'package:online_shop/features/category_features/services/category_api_repository.dart';
import 'package:online_shop/features/home_features/logic/bloc/home_bloc.dart';
import 'package:online_shop/features/home_features/services/home_api_repository.dart';
import 'package:online_shop/features/intro_features/logic/intro_cubit.dart';
import 'package:online_shop/features/intro_features/screens/splash_screen.dart';
import 'package:online_shop/features/products_features/screen/products_info_screen.dart';
import 'package:online_shop/features/public_features/logic/token_checker/token_check_cubit.dart';
import 'package:online_shop/features/public_features/screens/bottom_nav_bar.dart';

import 'features/auth_features/screens/auth_screen.dart';
import 'features/auth_features/screens/sign_up_screen.dart';
import 'features/category_features/screens/choose_category_screen.dart';
import 'features/favorite_features/model/favorite.dart';
import 'features/home_features/screen/home_screen.dart';
import 'features/intro_features/screens/intro_screen.dart';
import 'features/profile_features/screen/profile_screen.dart';
import 'features/public_features/logic/bottomnav_cubit.dart';
import 'features/public_features/screens/unknown_screen.dart';

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteAdapter());
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
          BlocProvider(
            create: (context) => AuthBloc(
              AuthApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => TokenCheckCubit(),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              CartApiRepository(),
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
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => UnknownScreen(),
          ),
          routes: {
            UnknownScreen.screenId: (context) => UnknownScreen(),
            BottomNavBarScreen.screenId: (context) => BottomNavBarScreen(),
            SplashScreen.screenId: (context) => SplashScreen(),
            IntroScreen.screenId: (context) => IntroScreen(),
            HomeScreen.screenId: (context) => HomeScreen(),
            ChooseCategoryScreen.screenId: (context) => ChooseCategoryScreen(),
            AuthScreen.screenId: (context) => AuthScreen(),
            SignUpScreen.screenId: (context) => SignUpScreen(),
            ProfileScreen.screenId: (context) => ProfileScreen(),
            CartScreen.screenId: (context) => CartScreen(),
            ProductsInfoScreen.screenId : (context) => ProductsInfoScreen(),
            PaymentSWebViewScreen.screenId : (context) => PaymentSWebViewScreen(),
          },
          // showSemanticsDebugger: true,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}