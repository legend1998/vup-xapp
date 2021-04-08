import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:vup/model/ProductLite.dart';
import 'Product.dart';
import 'Category.dart';
import "package:http/http.dart" as http;
import 'User.dart';
import 'cacheHive.dart';

class Services {
  static const url = "http://vup-api.herokuapp.com";

  static Future loginUser(userEmailOrPhone, password) async {
    try {
      final response = await http.post(
        '$url/user/login',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': 'dklfhaewowi32047230jlks'
        },
        body: jsonEncode(
            <String, String>{"email": userEmailOrPhone, "password": password}),
      );
      if (200 == response.statusCode) {
        final User user = userFromJson(response.body);
        var person = await Hive.openBox("user");
        person.add(user);
        print("added in box");
        return true;
      }
      return false;
    } catch (e) {
      print(e);

      return false;
    }
  }

  static Future getUser() async {
    HiveService hiveService = new HiveService();
    bool exist = await hiveService.isExists(boxName: "user");
    if (exist) {
      var box = await Hive.openBox("user");
      User person = box.getAt(0);
      return person;
    } else
      return false;
  }

  static Future<String> addToBasket(Products p) async {
    ProductLite newproduct = compressProduct(p);
    HiveService hiveService = new HiveService();
    bool exist = await hiveService.isExists(boxName: "user");
    if (exist) {
      var box = await Hive.openBox("user");
      User person = await box.getAt(0);
      if (checkexistornot(person.cart, newproduct)) {
        return "already in basket";
      } else {
        person.cart.add(newproduct);
        box.putAt(0, person);
        return "added in basket";
      }
    } else {
      return "log in to add in basket";
    }
  }

  static bool checkexistornot(List<dynamic> plist, ProductLite p) {
    for (ProductLite e in plist) {
      if (e.id == p.id) return true;
    }
    return false;
  }

  static Future<String> addToWishlist(Products p) async {
    ProductLite newproduct = compressProduct(p);

    HiveService hiveService = new HiveService();
    bool exist = await hiveService.isExists(boxName: "user");
    if (exist) {
      var box = await Hive.openBox("user");
      User person = await box.getAt(0);
      if (checkexistornot(person.wishlist, newproduct)) {
        return "already in wishlist";
      } else {
        person.wishlist.add(newproduct);
        box.putAt(0, person);

        return "added in wishlist";
      }
    } else {
      return "log in to add in wishlist";
    }
  }

  static Future getlatestproducts() async {
    HiveService hiveService = new HiveService();
    bool exist = await hiveService.isExists(boxName: "productslite");

    if (exist) {
      print("exist and returning from hive");
      return await hiveService.getBoxes("productslite");
    } else {
      try {
        final response = await http.get('$url/product/latest',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'authorization': 'dklfhaewowi32047230jlks'
            });

        if (200 == response.statusCode) {
          final List<ProductLite> products = productLiteFromJson(response.body);

          print("adding latest products in hive");
          hiveService.addBoxes(products, "productslite");
          return products;
        }
        return <Products>[];
      } catch (e) {
        print(e);
        return <Products>[];
      }
    }
  }

  static Future getTopBannerUrls() async {
    Reference reference = FirebaseStorage.instance.ref("/banner/top");
    HiveService hiveService = new HiveService();

    List topbannerurls = [];

    bool exist = await hiveService.isExists(boxName: "topbanner");
    if (exist) {
      print("loaded from localdatabase");
      topbannerurls = await hiveService.getBoxes("topbanner");
      return topbannerurls;
    } else {
      try {
        var reflist = await reference.listAll();
        for (Reference ref in reflist.items) {
          String imageurl = await ref.getDownloadURL();
          topbannerurls.add(imageurl);
        }
        await hiveService.addBoxes(topbannerurls, "topbanner");
        return topbannerurls;
      } catch (e) {
        print(e);
        return topbannerurls;
      }
    }
  }

  static Future<List<String>> getMidBannerUrls() async {
    Reference reference = FirebaseStorage.instance.ref("/banner/top");

    List<String> topbannerurls = [];
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

  static Future getBotBannerUrls() async {
    Reference reference = FirebaseStorage.instance.ref("/banner/top");

    List<String> botbannerurls = [];
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

  static Future getCategory() async {
    HiveService hiveService = new HiveService();

    bool exist = await hiveService.isExists(boxName: "category");
    if (exist) {
      print("from hive");
      //    this is big issues for now
      return await hiveService.getBoxes("category");
    } else {
      print('$url/category/getcategory');

      try {
        final response = await http.get('$url/category/getcategory',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'authorization': 'dklfhaewowi32047230jlks'
            });
        print(response.statusCode);
        if (200 == response.statusCode) {
          final List<Category> categories = categoryFromJson(response.body);

          hiveService.addBoxes(categories, "category");
          print("from web server");

          return categories;
        }
        return [];
      } catch (e) {
        print(e);
        return [];
      }
    }
  }

  static Future getproductbyCategory(String category) async {
    try {
      final response = await http.get(
        '$url/product/searchByCategory/$category',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': 'dklfhaewowi32047230jlks',
        },
      );
      if (200 == response.statusCode) {
        final List<ProductLite> result = productLiteFromJson(response.body);
        return result;
      }
      return <ProductLite>[];
    } catch (e) {
      print(e);
      return <ProductLite>[];
    }
  }

  static Future getProduct(String id) async {
    try {
      final response = await http
          .get('$url/product/getproduct/$id', headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'dklfhaewowi32047230jlks',
      });
      if (response.statusCode == 200) {
        final Products p = singleProductFromjson(response.body);
        return p;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future searchResult(String query) async {
    try {
      final response = await http.post('$url/product/search',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authorization': 'dklfhaewowi32047230jlks',
          },
          body: jsonEncode(<String, String>{
            'query': query,
          }));
      if (200 == response.statusCode) {
        final List<ProductLite> result = productLiteFromJson(response.body);
        return result;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future makeOrder() async {
    HiveService hiveService = new HiveService();
    bool exist = await hiveService.isExists(boxName: "user");
    if (!exist) return "no user data exist";

    // so much work to do here

    try {
      final response = await http.post('$url/order/makeorder',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authorization': 'dklfhaewowi32047230jlks',
          },
          body: jsonEncode(<String, dynamic>{
            "totalAmount": "400",
            "userid": "5fd845491d950472306d3e37",
            "products": ["sdfds", "sdfd"],
            "status": "paid"
          }));
      if (200 == response.statusCode) {
        final List<ProductLite> result = productLiteFromJson(response.body);
        print(response.statusCode);
        return result;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future signupUser(
      String username, String email, String phone, String password) async {
    var user = username.split(" ");
    print(user);
    try {
      final response = await http.post(
        '$url/user/create',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': 'dklfhaewowi32047230jlks'
        },
        body: jsonEncode(<String, String>{
          "fname": user[0],
          "lname": user.length == 2 ? user[1] : "",
          "email": email,
          "password": password,
          "phone": phone,
          "role": "user"
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (200 == response.statusCode) {
        final User user = userFromJson(response.body);
        var person = await Hive.openBox("user");
        person.add(user);
        print("added in box");
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static int getbasketPrice(List<dynamic> plist) {
    int sum = 0;
    plist.map((product) {
      sum += product.offerPrice * product.quantity;
    });

    return sum;
  }

  static Future<bool> forgotPassword(String mobile) async {
    try {
      final response = await http.post('$url/user/generatePasswordLink',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'authorization': 'dklfhaewowi32047230jlks',
          },
          body: jsonEncode(<String, String>{
            'mobile': mobile,
          }));
      if (200 == response.statusCode) {
        var result = json.decode(response.body);
        bool success = result["success"];
        return success;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> addAddress(
      {String uid,
      String street,
      String landmark,
      String dist,
      String state,
      String pin}) async {
    try {
      final response = await http.post(
        '$url/user/address',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': 'dklfhaewowi32047230jlks'
        },
        body: jsonEncode(<String, String>{
          "uid": uid,
          "street": street,
          "landmark": landmark,
          "district": dist,
          "state": state,
          "pin_code": pin
        }),
      );
      if (200 == response.statusCode) {
        final User user = userFromJson(response.body);
        var box = await Hive.openBox("user");
        User person = await box.getAt(0);
        person.address = user.address;
        box.putAt(0, person);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
