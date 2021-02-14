import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/model/Product.dart';
import 'package:vup/model/Services.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future product;

  @override
  void initState() {
    super.initState();
    product = Services.getProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vup"),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: product,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SizedBox(
                  height: 600,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.done:
                Products data = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          height: 380,
                          child: ListView.builder(
                              itemCount: data.imageUrl.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String url = data.imageUrl[index];
                                return InkWell(
                                  child: Container(
                                      width: 340,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Colors.grey[300])),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          new Image.network(
                                            url,
                                            height: 360,
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    // go to product page
                                  },
                                );
                              }),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.blue,
                              onPressed: () async {
                                //do something
                                var result = await Services.addToWishlist(data);
                                Fluttertoast.showToast(msg: result);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                height: 60,
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(top: 20, left: 10),
                                child: Text(
                                  data.title,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${(100 - (data.offerPrice / data.sellPrice) * 100).floor().toString()}% OFF',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.lightBlue),
                                  ),
                                  Text(
                                    '₹ ${data.offerPrice.toString()}',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          width: 100,
                          height: 80,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: int.parse(data.rating),
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star_outlined,
                                color: Colors.blueAccent,
                              );
                            },
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 20),
                            width: 150,
                            height: 60,
                            child: FlatButton(
                              child: Text(
                                "Add in Basket",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                // go somewhere
                                var result = await Services.addToBasket(data);
                                Fluttertoast.showToast(
                                  msg: result,
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            )),
                      ],
                    ),
                    Divider(),
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "seller :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(data.seller)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "DESCRIPTION",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 250,
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 20),
                      child: Text(
                        data.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "DETAILS",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Table(
                        border: TableBorder.all(
                            color: Colors.grey[300],
                            style: BorderStyle.solid,
                            width: 0.5),
                        defaultColumnWidth: FlexColumnWidth(),
                        children: data.details
                            .map((element) => TableRow(children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20),
                                    height: 50,
                                    child: Text(element.field),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(element.value),
                                  )
                                ]))
                            .toList(),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "REVIEWS",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: data.reviews.length == 0 ? 100 : 500,
                      child: data.reviews.length == 0
                          ? Center(
                              child: Text(
                                  "buy and be the first to review this product"),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.reviews.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Text("review"),
                                );
                              },
                            ),
                    ),
                  ],
                );
              default:
                return Center(
                  child: Text("no data found"),
                );
            }
          },
        ),
      ),
    );
  }
}
