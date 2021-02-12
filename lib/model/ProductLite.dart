// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'ProductLite.g.dart';

List<ProductLite> productLiteFromJson(String str) => List<ProductLite>.from(
    json.decode(str).map((x) => ProductLite.fromJson(x)));

String productLiteToJson(List<ProductLite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class ProductLite {
  ProductLite({
    this.category,
    this.createdAt,
    this.featured,
    this.id,
    this.title,
    this.offerPrice,
    this.sellPrice,
    this.description,
    this.color,
    this.thumbnailUrl,
    this.group,
  });
  @HiveField(0)
  List<String> category;
  @HiveField(1)
  DateTime createdAt;
  @HiveField(2)
  bool featured;
  @HiveField(3)
  String id;
  @HiveField(4)
  String title;
  @HiveField(5)
  int offerPrice;
  @HiveField(6)
  int sellPrice;
  @HiveField(7)
  String description;
  @HiveField(8)
  String color;
  @HiveField(9)
  String thumbnailUrl;
  @HiveField(10)
  String group;

  factory ProductLite.fromJson(Map<String, dynamic> json) => ProductLite(
        category: List<String>.from(json["category"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        featured: json["featured"],
        id: json["_id"],
        title: json["title"],
        offerPrice: json["offer_price"],
        sellPrice: json["sell_price"],
        description: json["description"],
        color: json["color"],
        thumbnailUrl: json["thumbnailURL"],
        group: json["group"],
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "featured": featured,
        "_id": id,
        "title": title,
        "offer_price": offerPrice,
        "sell_price": sellPrice,
        "description": description,
        "color": color,
        "thumbnailURL": thumbnailUrl,
        "group": group,
      };
}
