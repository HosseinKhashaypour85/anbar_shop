class ShowCartModel {
  ShowCartModel({
    this.page,
    this.perPage,
    this.totalItems,
    this.totalPages,
    this.items,});

  ShowCartModel.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['perPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  int? page;
  int? perPage;
  int? totalItems;
  int? totalPages;
  List<Items>? items;


}

class Items {
  Items({
    this.collectionId,
    this.collectionName,
    this.count,
    this.created,
    this.id,
    this.image,
    this.isInBasket,
    this.price,
    this.title,
    this.token,
    this.updated,});

  Items.fromJson(dynamic json) {
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    count = json['count'];
    created = json['created'];
    id = json['id'];
    image = json['image'];
    isInBasket = json['isInBasket'];
    price = json['price'];
    title = json['title'];
    token = json['token'];
    updated = json['updated'];
  }
  String? collectionId;
  String? collectionName;
  int? count;
  String? created;
  String? id;
  String? image;
  bool? isInBasket;
  double? price;
  String? title;
  String? token;
  String? updated;


}