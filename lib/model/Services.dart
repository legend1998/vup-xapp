import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
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
      return User();
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
      return List<Products>();
    } catch (e) {
      print(e);
      return List<Products>();
    }
  }

  static Future getTopBannerUrls() async {
    Reference reference = FirebaseStorage.instance.ref("/banner/top");
    List<String> topbannerurls = new List();

    try {
      var reflist = await reference.listAll();
      for (Reference ref in reflist.items) {
        String imageurl = await ref.getDownloadURL();
        topbannerurls.add(imageurl);
      }

      return topbannerurls;
    } catch (e) {
      print(e);
      return topbannerurls;
    }
  }

  static Future<List<String>> getMidBannerUrls() async {
    Reference reference = FirebaseStorage.instance.ref("/banner/top");

    List<String> topbannerurls = new List();
    try {
      reference.listAll().then((refs) {
        refs.items.forEach((ref) {
          ref.getDownloadURL().then((imageurl) {
            topbannerurls.add(imageurl);
            print("image downloaeded");
          });
        });
      });
      return topbannerurls;
    } catch (e) {
      print(e);
    }
    return topbannerurls;
  }

  static Future<List<String>> getBotBannerUrls() async {
    Reference reference = FirebaseStorage.instance.ref("/banner/top");

    List<String> botbannerurls = new List();
    try {
      reference.listAll().then((refs) {
        refs.items.forEach((ref) {
          ref.getDownloadURL().then((imageurl) {
            botbannerurls.add(imageurl);
            print("image downloaeded " + '$imageurl');
          });
        });
      });
      return botbannerurls;
    } catch (e) {
      print(e);
    }
    return botbannerurls;
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
      return List<Category>();
    } catch (e) {
      print(e);
      return List<Category>();
    }
  }
}
