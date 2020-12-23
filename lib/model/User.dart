// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.dateJoined,
    this.address,
    this.role,
    this.cart,
    this.wishlist,
    this.orders,
    this.id,
    this.uid,
    this.fname,
    this.lname,
    this.email,
    this.password,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  DateTime dateJoined;
  List<dynamic> address;
  String role;
  List<dynamic> cart;
  List<dynamic> wishlist;
  List<dynamic> orders;
  String id;
  String uid;
  String fname;
  String lname;
  String email;
  String password;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        dateJoined: DateTime.parse(json["date_joined"]),
        address: List<dynamic>.from(json["address"].map((x) => x)),
        role: json["role"],
        cart: List<dynamic>.from(json["cart"].map((x) => x)),
        wishlist: List<dynamic>.from(json["wishlist"].map((x) => x)),
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        id: json["_id"],
        uid: json["uid"],
        fname: json["fname"],
        lname: json["lname"],
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
        "uid": uid,
        "fname": fname,
        "lname": lname,
        "email": email,
        "password": password,
        "phone": phone,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
