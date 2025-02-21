import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import 'product_listing_screen.dart'; // صفحه نمایش محصولات را وارد کنید

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({super.key});

  static const String screenId = '/chooseCategory';

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'image': 'assets/images/clothes.png',
      'title': 'پوشاک مردانه',
      'category': 'men\'s clothing',
    },
    {
      'image': 'assets/images/womanclothes.png',
      'title': 'پوشاک زنانه',
      'category': 'women\'s clothing',
    },
    {
      'image': 'assets/images/jewerly.png',
      'title': 'جواهرات',
      'category': 'jewelery',
    },
    {
      'image': 'assets/images/elec.png',
      'title': 'برقی',
      'category': 'electronics',
    },
    {
      'image': 'assets/images/all.png',
      'title': 'همه محصولات',
      'category': 'products',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryOptions(
                image: categories[index]['image']!,
                title: categories[index]['title']!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListingScreen(
                        category: categories[index]['category'],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryOptions extends StatelessWidget {
  const CategoryOptions({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: getBorderRadiusFunc(10),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      child: ListTile(
        leading: Image.asset(
          image,
          width: 50,
          height: 50,
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: 'irs', fontSize: 16.sp),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
