class SearchModel {
  SearchModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] as int?,
      title: json['title'] as String? ?? "بدون عنوان", // مقدار پیش‌فرض
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // مقدار پیش‌فرض 0.0
      description: json['description'] as String? ?? "توضیحی موجود نیست",
      category: json['category'] as String? ?? "نامشخص",
      image: json['image'] as String? ?? "", // مقدار پیش‌فرض عکس خالی
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : Rating(), // مقدار پیش‌فرض
    );
  }

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating?.toJson(),
    };
  }
}

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0, // مقدار پیش‌فرض 0.0
      count: (json['count'] as num?)?.toInt() ?? 0, // مقدار پیش‌فرض 0
    );
  }

  double? rate;
  int? count;

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
