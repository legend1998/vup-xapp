import 'package:flutter/material.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/utils/productTile.dart';

class Basket extends StatefulWidget {
  Basket({Key key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
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
          title: Text("vup"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "My basket",
                  style: TextStyle(fontSize: 22, color: Colors.grey[600]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 30),
                height: 400,
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: _user,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        {
                          var data = snapshot.data.cart;
                          if (data.isNotEmpty) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return productBasketTile(data[index], context);
                              },
                            );
                          } else
                            return Container(
                              child: Center(
                                child: Text("basket is empty"),
                              ),
                            );
                        }
                        break;
                      default:
                        return Text("something went wrong");
                    }
                  },
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, right: 20),
                  width: 150,
                  height: 60,
                  child: FlatButton(
                    child: Text(
                      "Place Order",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // go somewhere
                    },
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                  )),
            ],
          ),
        ));
  }
}
