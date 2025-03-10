import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/const/shape/media_query.dart';
import 'package:online_shop/const/theme/colors.dart';
import 'package:online_shop/features/home_features/logic/bloc/home_bloc.dart';
import 'package:online_shop/features/home_features/model/all_products_home_model.dart';
import 'package:online_shop/features/home_features/services/home_api_repository.dart';
import 'package:online_shop/features/home_features/model/home_model.dart';
import 'package:online_shop/features/public_features/functions/pre_values/pre_values.dart';
import 'package:online_shop/features/public_features/widget/rating_widget.dart';
import 'package:online_shop/features/public_features/widget/search_bar_widget.dart';

import '../../../const/shape/border_radius.dart';
import '../widget/all_products_section_widget.dart';
import '../widget/products_first_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String screenId = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(HomeApiRepository())..add(CallHomeEvent()),
      child: SafeArea(
        child: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
          },
          child: Scaffold(
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                if (state is HomeCompletedState) {
                  return HomeContent(
                    homeModel: state.homeModel,
                  );
                }
                if (state is HomeErrorState) {
                  return Center(
                    child: Text('Error: ${state.error.errorMsg}'),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.homeModel,
  });

  final List<HomeModel> homeModel;

  @override
  Widget build(BuildContext context) {
    void showModalBottomFunc(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "فیلتر محصولات",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'irs',
                  ),
                ),
                SizedBox(height: 10),
                Text("دسته‌بندی:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Wrap(
                  spacing: 8,
                  children: ["همه", "مردانه", "زنانه", "الکترونیک", "جواهرات"]
                      .map((category) {
                    return FilterChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          fontFamily: 'irs',
                        ),
                      ),
                      onSelected: (bool selected) {},
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                Text(
                  "محدوده قیمت:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'irs',
                  ),
                ),
                RangeSlider(
                  values: RangeValues(10, 200),
                  min: 0,
                  max: 500,
                  divisions: 10,
                  labels: RangeLabels("10\$", "200\$"),
                  onChanged: (RangeValues values) {},
                ),
                SizedBox(height: 15),
                Text(
                  "امتیاز:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'irs',
                  ),
                ),
                Row(
                  // children: List.generate(
                  //   5,
                  //   (index) {
                  //     return IconButton(
                  //       icon: Icon(
                  //         Icons.star,
                  //         color: index < 4 ? Colors.amber : Colors.grey,
                  //       ),
                  //       onPressed: () {},
                  //     );
                  //   },
                  // ),
                  children: [CustomRatingBar(rating: 0 , changeRate: false,)],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    "اعمال فیلتر",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'irs',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7.sp),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: getBorderRadiusFunc(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.filter_alt, color: Colors.white),
                  onPressed: () {
                    showModalBottomFunc(context);
                  },
                ),
              ),
              Expanded(
                child: SearchBarWidget(),
              ),
            ],
          ),
          ProductsFirstSlider(homeModel: homeModel),
          AllProductsSection(homeModel: homeModel),
        ],
      ),
    );
  }
}
