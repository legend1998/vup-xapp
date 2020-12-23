import 'dart:convert';
import 'Product.dart';
import 'Category.dart';
import "package:http/http.dart" as http;
import 'User.dart';

class Services {
  static const url = "http://vup-api.herokuapp.com/";

  static Future<User> getUser(email, password) async {
    try {
      final response = await http.post(
        '$url/user/login',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authentication': 'dklfhaewowi32047230jlks'
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}),
      );

      if (200 == response.statusCode) {
        final User user = userFromJson(response.body);
        return user;
      }
    } catch (e) {
      print(e);
      return User();
    }
  }

  static Future<List<Products>> getproducts() async {
    try {
      final response = await http.get('$url/product/getall',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authentication': 'dklfhaewowi32047230jlks'
          });
      if (200 == response.statusCode) {
        final List<Products> products = productsFromJson(response.body);
        return products;
      }
    } catch (e) {
      print(e);
      return List<Products>();
    }
  }

  static Future<List<Category>> getCategory() async {
    try {
      final response = await http.get('$url/category/getcategory',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authentication': 'dklfhaewowi32047230jlks'
          });
      if (200 == response.statusCode) {
        final List<Category> categories = categoryFromJson(response.body);
        return categories;
      }
    } catch (e) {
      print(e);
      return List<Category>();
    }
  }
}
