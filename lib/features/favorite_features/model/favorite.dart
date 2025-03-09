import 'package:hive/hive.dart';

part 'favorite.g.dart'; // این خط را برای ایجاد فایل g.dart اضافه کنید

@HiveType(typeId: 0)
class Favorite {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String productImage;

  Favorite({
    required this.productId,
    required this.productName,
    required this.productImage,
  });
}
