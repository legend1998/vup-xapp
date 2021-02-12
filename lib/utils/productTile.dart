import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/ProductScreen.dart';
import 'package:vup/model/Product.dart';
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
            Image.network(p.thumbnailUrl),
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
              '₹ ${p.sellPrice.toString()}',
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
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                p.thumbnailUrl,
                width: 90,
              ),
              height: 90,
              width: 90,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(id: p.id)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text('★ rating'),
                  Text(
                    '₹ ${p.sellPrice.toString()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
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

//Widget productDetail(Products data)=>Container(child: ,)
