import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //open drawer
          },
        ),

        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () {
                //open basket
              },
            ),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              height: 430,
              child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.grey[300])),
                          child: Column(
                            children: [
                              new Image.network(
                                  'https://source.unsplash.com/400x400/?gown,fashion,$index'),
                            ],
                          )),
                      onTap: () {
                        // go to product page
                      },
                    );
                  }),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Product Name ",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Product description ",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  height: 50,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 150,
                    height: 60,
                    child: FlatButton(
                      child: Text(
                        "Add in Basket",
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
            )
          ],
        ),
      ),
    );
  }
}
