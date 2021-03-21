import 'package:flutter/material.dart';
import 'package:vup/model/ProductLite.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';
import 'package:vup/utils/productTile.dart';

class Wishlist extends StatefulWidget {
  Wishlist({Key key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List _wishlist;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  void loaddata() async {
    User temp = await Services.getUser();
    this.setState(() {
      _wishlist = temp.wishlist;
      _loading = true;
    });
  }

  void deleteItem(String id) {
    for (ProductLite product in _wishlist) {
      if (product.id == id) {
        this.setState(() {
          _wishlist.remove(product);
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("my wishlist"),
        ),
        body: SingleChildScrollView(
            child: _loading
                ? _wishlist.length != 0
                    ? Container(
                        height: MediaQuery.maybeOf(context).size.height,
                        child: ListView.builder(
                          itemCount: _wishlist.length,
                          itemBuilder: (context, index) {
                            return WishlistItem(
                              callbackdeleteItem: deleteItem,
                              p: _wishlist[index],
                            );
                          },
                        ),
                      )
                    : Container(
                        height: MediaQuery.maybeOf(context).size.height,
                        child: Center(
                          child: Text("oops empty wishlist"),
                        ),
                      )
                : Container(
                    height: MediaQuery.maybeOf(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )));
  }
}
