import 'package:flutter/material.dart';

class Basket extends StatefulWidget {
  Basket({Key key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Basket()));
                },
              ),
            ),
            Icon(Icons.more_vert),
          ],
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "your basket",
                  style: TextStyle(fontSize: 22, color: Colors.grey[600]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 22, top: 30),
                height: 400,
                alignment: Alignment.center,
                child: ListView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.grey[300])),
                          child: Row(
                            children: [
                              new Image.network(
                                  'https://source.unsplash.com/120x120/?cloth,fashion,$index'),
                              SizedBox(
                                width: 20,
                              ),
                              Text('product ${index + 1}'),
                            ],
                          ));
                    }),
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
