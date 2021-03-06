import 'package:flutter/material.dart';
import 'package:vup/CheckOut.dart';
import 'package:vup/model/ProductLite.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/utils/productTile.dart';

class Basket extends StatefulWidget {
  Basket({Key key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  List _basket;
  bool _loading = false;
  int _basketValue = 0;

  @override
  void initState() {
    super.initState();
    loadBasket();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadBasket() async {
    int sum = 0;
    var temp = await Services.getUser();
    for (ProductLite product in temp.cart) {
      sum += product.offerPrice * product.quantity;
    }
    this.setState(() {
      _basket = temp.cart;
      _basketValue = sum;
      _loading = true;
    });
  }

  void totalbasket() {
    int sum = 0;
    for (ProductLite product in _basket) {
      sum += product.offerPrice * product.quantity;
    }
    this.setState(() {
      _basketValue = sum;
    });
  }

  void deleteItem(String id) {
    for (ProductLite item in _basket) {
      if (item.id == id) {
        this.setState(() {
          _basket.remove(item);
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Q bazar"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "My basket",
                style: TextStyle(fontSize: 22),
              ),
            ),
            _loading
                ? _basket.length == 0
                    ? Container(
                        height: MediaQuery.maybeOf(context).size.height * 0.7,
                        child: Center(
                          child: Text("basket is empty"),
                        ),
                      )
                    : Container(
                        height: MediaQuery.maybeOf(context).size.height * 0.65,
                        child: ListView.builder(
                          itemCount: _basket.length,
                          itemBuilder: (context, index) {
                            return BasketTile(
                              p: _basket[index],
                              callbackBasketvalue: totalbasket,
                              callbackDeleteitem: deleteItem,
                            );
                          },
                        ),
                      )
                : Container(
                    child: Text("basket is empty"),
                  ),
            _loading
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            ' Rs. $_basketValue',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              if (_basket.isEmpty) return;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CheckOut(basket: _basketValue)));
                            },
                            child: Text(
                              "Place Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Text("toal value cart and price"),
                  ),
          ],
        )));
  }
}
