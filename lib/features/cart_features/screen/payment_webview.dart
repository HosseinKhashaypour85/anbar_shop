import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../public_features/logic/bottomnav_cubit.dart';
import '../../public_features/screens/bottom_nav_bar.dart';
import '../../public_features/widget/snack_bar_widget.dart';
import '../logic/cart_bloc.dart';

class PaymentSWebViewScreen extends StatefulWidget {
  const PaymentSWebViewScreen({super.key});

  static const String screenId = '/payment_webview_screen';

  @override
  State<PaymentSWebViewScreen> createState() => _PaymentSWebViewScreenState();
}

class _PaymentSWebViewScreenState extends State<PaymentSWebViewScreen> {
  late WebViewController _controller;
  late Map<String, dynamic> arguments; // برای دریافت آرگومان‌ها
  bool canScope = false;
  int pressCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController(); // مقداردهی اولیه WebViewController
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // دریافت آرگومان‌ها در didChangeDependencies
    arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    webView();
  }

  // متد بارگذاری WebView
  webView() {
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url == 'app://prokala/succeed') {
              // اگر کاربر موفق شد
              getSnackBarWidget(context, 'سفارش شما با موفقیت ثبت شد', Colors.green);
              BlocProvider.of<BottomnavCubit>(context).changeIndex(0);
              Navigator.pushNamedAndRemoveUntil(context, BottomNavBarScreen.screenId, (route) => false);
              BlocProvider.of<CartBloc>(context).add(CallDeleteProduct(id: arguments['id']));
              return NavigationDecision.navigate;
            } else if (request.url == 'app://prokala/failed') {
              // اگر کاربر شکست خورد
              getSnackBarWidget(context, 'سفارش شما با شکست مواجه شد، دوباره تلاش کنید', Colors.red);
              BlocProvider.of<BottomnavCubit>(context).changeIndex(0);
              Navigator.pushNamedAndRemoveUntil(context, BottomNavBarScreen.screenId, (route) => false);
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://programmingshow.ir/programminshow/deeplink.html'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PopScope(
          canPop: canScope,
          onPopInvoked: (value) async {
            final canGoBack = await _controller.canGoBack() ?? false;
            if (canGoBack) {
              _controller.goBack();
              canScope = false;
            } else {
              pressCount++;
              if (pressCount == 2) {
                BlocProvider.of<BottomnavCubit>(context).changeIndex(0);
                Navigator.of(context).pushNamedAndRemoveUntil(BottomNavBarScreen.screenId, (route) => false);
                canScope = false;
              } else {
                Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() => pressCount--);
                getSnackBarWidget(context, 'برای بازگشت به صفحه اصلی یکبار دیگر کلیک کنید', Colors.black);
                canScope = false;
              }
            }
          },
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}