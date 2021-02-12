// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Products singleProductFromjson(String str) =>
    Products.fromJson(json.decode(str));

class Products {
  Products({
    this.category,
    this.tags,
    this.imageUrl,
    this.details,
    this.reviews,
    this.createdAt,
    this.featured,
    this.id,
    this.pid,
    this.title,
    this.offerPrice,
    this.sellPrice,
    this.description,
    this.color,
    this.thumbnailUrl,
    this.group,
    this.quantity,
    this.rating,
    this.seller,
    this.updatedAt,
    this.v,
  });

  List<String> category;
  List<String> tags;
  List<String> imageUrl;
  List<Detail> details;
  List<Review> reviews;
  bool featured;
  String id;
  String pid;
  String title;
  int offerPrice;
  int sellPrice;
  String description;
  String color;
  String thumbnailUrl;
  String group;
  int quantity;
  String rating;
  String seller;
  DateTime updatedAt;
  DateTime createdAt;
  int v;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        category: List<String>.from(json["category"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        reviews: List<Review>.from(json["reviews"].map((x) => x.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        featured: json["featured"],
        id: json["_id"],
        pid: json["pid"],
        title: json["title"],
        offerPrice: json["offer_price"],
        sellPrice: json["sell_price"],
        description: json["description"],
        color: json["color"],
        thumbnailUrl: json["thumbnailURL"],
        group: json["group"],
        quantity: json["quantity"],
        rating: json["rating"],
        seller: json["seller"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl.map((x) => x)),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "reviews": List<Review>.from(reviews.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "featured": featured,
        "_id": id,
        "pid": pid,
        "title": title,
        "offer_price": offerPrice,
        "sell_price": sellPrice,
        "description": description,
        "color": color,
        "thumbnailURL": thumbnailUrl,
        "group": group,
        "quantity": quantity,
        "rating": rating,
        "seller": seller,
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Detail {
  Detail({
    this.field,
    this.value,
  });

  String field;
  String value;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        field: json["field"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "value": value,
      };
}

class Review {
  Review({this.user, this.review});

  String user;
  String review;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "review": user,
      };
}
