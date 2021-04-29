import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:vup/ProductScreen.dart';
import 'package:vup/model/Product.dart';
import 'package:vup/model/ProductLite.dart';

Widget productTile(ProductLite p, BuildContext context) => Container(
        child: Card(
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 100,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(p.thumbnailUrl),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  p.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            Text(
              '₹ ${p.offerPrice.toString()}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ));

Widget productSearchTile(ProductLite p, BuildContext context) => Card(
      child: Container(
        height: 100,
        width: MediaQuery.maybeOf(context).size.width * 0.9,
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
                width: MediaQuery.maybeOf(context).size.width * 0.6,
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
        width: MediaQuery.maybeOf(context).size.width * 0.9,
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
                width: MediaQuery.maybeOf(context).size.width * 0.6,
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
                        TextButton(
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
      width: MediaQuery.maybeOf(context).size.width,
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
            width: MediaQuery.maybeOf(context).size.width * 0.6,
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
                        NumberPicker(
                            itemHeight: 30,
                            itemWidth: 40,
                            minValue: 1,
                            maxValue: 5,
                            axis: Axis.horizontal,
                            step: 1,
                            haptics: true,
                            value: p.quantity,
                            onChanged: (value) {
                              p.quantity = value;
                              callbackBasketvalue();
                            }),
                        Container(
                          child: TextButton(
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
