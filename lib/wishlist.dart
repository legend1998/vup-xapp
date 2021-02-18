import 'package:flutter/material.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/utils/productTile.dart';

class Wishlist extends StatefulWidget {
  Wishlist({Key key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  Future _user;

  @override
  void initState() {
    super.initState();
    _user = Services.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my wishlist"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              var data = snapshot.data.wishlist;
              if (data.isNotEmpty) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return productBasketTile(data[index], context);
                      }),
                );
              } else
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(
                    child: Text("oops empty wishlist"),
                  ),
                );
              break;
            default:
              return Text("something went wrong");
          }
        },
      )),
    );
  }
}
