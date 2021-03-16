import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/ProductScreen.dart';
import 'package:vup/model/Product.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:vup/model/ProductLite.dart';

Widget productTile(ProductLite p, BuildContext context) => Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(
                        id: p.id,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              p.thumbnailUrl,
              width: 100,
            ),
            Center(
              child: Text(
                p.title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Text(
              '₹ ${p.offerPrice.toString()}',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );

Widget productSearchTile(ProductLite p, BuildContext context) => Card(
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                p.thumbnailUrl,
                width: 90,
              ),
              height: 90,
              width: 120,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(id: p.id)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        p.title,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      '★ ${p.rating}',
                      style: TextStyle(color: Colors.greenAccent[700]),
                    ),
                    Text(
                      '₹ ${p.offerPrice.toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget priceAndRating(Products data) => Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '₹ ${data.sellPrice}',
                style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[400]),
              ),
              Text(
                '₹  ${data.offerPrice}',
                style: TextStyle(fontSize: 28, color: Colors.grey[800]),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.green,
              ),
              Text(data.rating,
                  style: TextStyle(
                    fontSize: 20,
                  ))
            ],
          )
        ],
      ),
    );

class WishlistItem extends StatelessWidget {
  const WishlistItem({Key key, this.p, this.callbackdeleteItem})
      : super(key: key);

  final ProductLite p;
  final callbackdeleteItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                p.thumbnailUrl,
                width: 90,
              ),
              height: 90,
              width: 120,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(id: p.id)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        p.title,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      '★ ${p.rating}',
                      style: TextStyle(color: Colors.greenAccent[700]),
                    ),
                    Row(
                      children: [
                        Text(
                          '₹ ${p.offerPrice.toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                          child: Icon(Icons.delete),
                          onPressed: () {
                            callbackdeleteItem(p.id);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BasketTile extends StatelessWidget {
  BasketTile(
      {Key key, this.p, this.callbackBasketvalue, this.callbackDeleteitem})
      : super(key: key);

  final ProductLite p;
  final callbackBasketvalue;
  final callbackDeleteitem;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen(id: p.id)));
            },
            child: SizedBox(
              child: Image.network(
                p.thumbnailUrl,
                width: 90,
              ),
              height: 90,
              width: 120,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '₹ ${p.offerPrice.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomNumberPicker(
                          initialValue: p.quantity,
                          maxValue: 9,
                          valueTextStyle:
                              TextStyle(fontSize: 16, color: Colors.blue),
                          minValue: 1,
                          step: 1,
                          onValue: (value) async {
                            p.quantity = value;
                            callbackBasketvalue();
                          },
                        ),
                        Container(
                          child: FlatButton(
                            child: Icon(Icons.delete),
                            onPressed: () {
                              //do something
                              callbackDeleteitem(p.id);
                            },
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
