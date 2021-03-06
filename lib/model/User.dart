// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:vup/model/Coupans.dart';

part 'User.g.dart';
// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@HiveType(typeId: 4)
class User {
  User({
    this.dateJoined,
    this.address,
    this.role,
    this.cart,
    this.wishlist,
    this.orders,
    this.id,
    this.refBy,
    this.coupans,
    this.fname,
    this.lname,
    this.refCode,
    this.email,
    this.password,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
  @HiveField(0)
  DateTime dateJoined;
  @HiveField(1)
  List<dynamic> address;
  @HiveField(2)
  String role;
  @HiveField(3)
  List<dynamic> cart;
  @HiveField(4)
  List<dynamic> wishlist;
  @HiveField(5)
  List<dynamic> orders;
  @HiveField(6)
  String id;
  @HiveField(7)
  String refBy;
  @HiveField(8)
  List<Coupan> coupans;
  @HiveField(9)
  String fname;
  @HiveField(10)
  String lname;
  @HiveField(11)
  String refCode;
  @HiveField(12)
  String email;
  @HiveField(13)
  String password;
  @HiveField(14)
  String phone;
  @HiveField(15)
  DateTime createdAt;
  @HiveField(16)
  DateTime updatedAt;
  @HiveField(17)
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        dateJoined: DateTime.parse(json["date_joined"]),
        address: List<dynamic>.from(json["address"].map((x) => x)),
        role: json["role"],
        cart: List<dynamic>.from(json["cart"].map((x) => x)),
        wishlist: List<dynamic>.from(json["wishlist"].map((x) => x)),
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        id: json["_id"],
        refBy: json["refBy"],
        coupans:
            List<Coupan>.from(json["coupans"].map((x) => Coupan.fromJson(x))),
        fname: json["fname"],
        lname: json["lname"],
        refCode: json["refCode"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "date_joined": dateJoined.toIso8601String(),
        "address": List<dynamic>.from(address.map((x) => x)),
        "role": role,
        "cart": List<dynamic>.from(cart.map((x) => x)),
        "wishlist": List<dynamic>.from(wishlist.map((x) => x)),
        "orders": List<dynamic>.from(orders.map((x) => x)),
        "_id": id,
        "refBy": refBy,
        "coupans": List<dynamic>.from(coupans.map((x) => x.toJson())),
        "fname": fname,
        "lname": lname,
        "refCode": refCode,
        "email": email,
        "password": password,
        "phone": phone,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
