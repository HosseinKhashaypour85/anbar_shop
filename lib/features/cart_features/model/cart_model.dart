class CartModel {
  CartModel({
    this.collectionId,
    this.collectionName,
    this.count,
    this.created,
    this.id,
    this.image,
    this.price,
    this.title,
    this.token,
    this.updated,
    this.checkCart,
  });

  CartModel.fromJson(dynamic json) {
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    count = json['count'];
    created = json['created'];
    id = json['id'];
    image = json['image'];
    price = json['price'];
    title = json['title'];
    token = json['token'];
    updated = json['updated'];
    checkCart = json['isInBasket'];
  }

  String? collectionId;
  String? collectionName;
  int? count;
  String? created;
  String? id;
  String? image;
  double? price;
  String? title;
  String? token;
  String? updated;
  bool? checkCart;
}