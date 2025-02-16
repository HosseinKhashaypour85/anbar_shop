class HomeModel {
  HomeModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  HomeModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null
        ? Rating.fromJson(json['rating'])
        : null;
  }

  int? id;
  String? title;
  double? price;  // Price can be int or double, handle both
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['category'] = category;
    map['image'] = image;
    if (rating != null) {
      map['rating'] = rating?.toJson();
    }
    return map;
  }
}

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  Rating.fromJson(dynamic json) {
    rate = (json['rate'] is int) ? (json['rate'] as int).toDouble() : json['rate'];  // handle int or double for rate
    count = json['count'];
  }

  double? rate;  // rate is a double, handle both int and double input
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    map['count'] = count;
    return map;
  }
}
