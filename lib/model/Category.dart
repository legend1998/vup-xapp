// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType()
class Category {
  Category({
    this.category,
  });

  @HiveField(0)
  String category;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
      };
}
